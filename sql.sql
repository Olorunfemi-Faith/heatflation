-- ========================================================
-- 1. TABLE CREATION
-- ========================================================

CREATE TABLE cpi (
    year INT PRIMARY KEY, 
    cpi NUMERIC
);

CREATE TABLE food_prices (
    month INT, 
    year INT, 
    state VARCHAR, 
    unit_value INT, 
    unit_measure VARCHAR, 
    price_per_kg NUMERIC, 
    PRIMARY KEY (state, year, month)
);

CREATE TABLE ndvi (
    state VARCHAR, 
    year INT, 
    month INT, 
    actu_vim NUMERIC, 
    hist_vim NUMERIC, 
    PRIMARY KEY (state, year, month)
);

CREATE TABLE rainfall (
    state VARCHAR, 
    year INT, 
    month INT, 
    actu_rfh NUMERIC, 
    hist_rfh NUMERIC, 
    PRIMARY KEY (state, year, month)
);




-- ============================================================
-- 2. DATA IMPORT (COPY)
-- ==========================================================

COPY rainfall(state, year, month, actu_rfh, hist_rfh)
FROM 'C:/mydata/rainfall_1.csv'
DELIMITER ','
CSV HEADER;

COPY ndvi(state, year, month, actu_vim, hist_vim)
FROM 'C:/mydata/ndvi_1.csv'
DELIMITER ','
CSV HEADER;

COPY food_prices(month, year, state, unit_value, unit_measure, price_per_kg)
FROM 'C:/mydata/food_prices_1.csv'
DELIMITER ','
CSV HEADER;

COPY cpi(year, cpi)
FROM 'C:/mydata/cpi_1.csv'
DELIMITER ','
CSV HEADER;
CREATE TABLE rainfall (
    state VARCHAR, 
    year INT, 
    month INT, 
    actu_rfh NUMERIC, 
    hist_rfh NUMERIC, 
    PRIMARY KEY (state, year, month)
);



-- ========================================================
-- STEP 3: DATA INTEGRATION (LEFT JOIN)
-- ========================================================
-- We start with the NDVI table as our baseline to protect weather records. 
-- Then we cleanly layer on rainfall, food prices, and CPI one by one.

CREATE VIEW v1_base AS
SELECT 
    n.state,
    n.year,
    n.month,
    n.actu_vim,
    n.hist_vim,
    r.actu_rfh,
    r.hist_rfh,
    f.unit_value,
    f.unit_measure,
    f.price_per_kg,
    c.cpi
FROM 
    ndvi n
LEFT JOIN 
    rainfall r 
    ON n.state = r.state 
    AND n.year = r.year 
    AND n.month = r.month
LEFT JOIN 
    food_prices f 
    ON n.state = f.state 
    AND n.year = f.year 
    AND n.month = f.month
LEFT JOIN 
    cpi c 
    ON n.year = c.year;



-- ========================================================
-- STEP 4: INFLATION ADJUSTMENT (REAL PRICE CALCULATION)
-- ========================================================
-- This view calculates the real price 

CREATE VIEW v2_base AS
SELECT 
    state,
    year,
    month,
    actu_vim,
    hist_vim,
    actu_rfh,
    hist_rfh,
    price_per_kg AS nominal_price_per_kg,
    cpi,
    -- Calculate real price safely without filtering any rows out
    ROUND((price_per_kg / NULLIF(cpi, 0)) * 100, 2) AS real_price_per_kg
FROM 
    v1_join;


-- ========================================================
-- STEP 5: CREATE ANOMALY TABLE (v3_base)
-- ========================================================
-- This creates a physical table that computes and stores weather anomalies
-- for every single row, giving you a fast baseline for your step-by-step analysis.

CREATE TABLE v3_base AS
SELECT 
    state,
    year,
    month,
    actu_vim,
    hist_vim,
    -- Calculate vegetation anomaly (Negative means drop)
    ROUND(actu_vim - hist_vim, 4) AS vim_anomaly,
    actu_rfh,
    hist_rfh,
    -- Calculate rainfall anomaly (Negative means drought/less rain)
    ROUND(actu_rfh - hist_rfh, 2) AS rfh_anomaly,
    nominal_price_per_kg,
    cpi,
    real_price_per_kg
FROM 
    v2_base;



-- ========================================================
-- STEP 5: BACKWARD TRACEABILITY LAG PIPELINE (v4_trace_pipeline)
-- ========================================================
-- This table starts at the current market price and projects backward:
-- 1. Economic Lookback: What was the vegetation doing 1, 2, 3, and 4 months ago?
-- 2. Biological Lookback: What was the rainfall doing 1, 2, 3, and 4 months ago?

CREATE TABLE v4_trace_pipeline AS
SELECT 
    state,
    year,
    month,
    real_price_per_kg AS current_real_price,
    
    -- Calculate the percentage price spike above the state's historical average
    ROUND(
        ((real_price_per_kg - AVG(real_price_per_kg) OVER(PARTITION BY state)) 
        / AVG(real_price_per_kg) OVER(PARTITION BY state)) * 100, 2
    ) AS real_price_spike_percent,
    
    -- Current conditions for reference
    vim_anomaly AS current_vim_anomaly,
    rfh_anomaly AS current_rfh_anomaly,
    
    -- STAGE 1: ECONOMIC LOOKBACK (Looking back from today's price to past vegetation)
    LAG(vim_anomaly, 1) OVER(PARTITION BY state ORDER BY year, month) AS vim_1m_ago,
    LAG(vim_anomaly, 2) OVER(PARTITION BY state ORDER BY year, month) AS vim_2m_ago,
    LAG(vim_anomaly, 3) OVER(PARTITION BY state ORDER BY year, month) AS vim_3m_ago,
    LAG(vim_anomaly, 4) OVER(PARTITION BY state ORDER BY year, month) AS vim_4m_ago,
    
    -- STAGE 2: BIOLOGICAL LOOKBACK (Looking back from today's vegetation to past rainfall)
    LAG(rfh_anomaly, 1) OVER(PARTITION BY state ORDER BY year, month) AS rfh_1m_ago,
    LAG(rfh_anomaly, 2) OVER(PARTITION BY state ORDER BY year, month) AS rfh_2m_ago,
    LAG(rfh_anomaly, 3) OVER(PARTITION BY state ORDER BY year, month) AS rfh_3m_ago,
    LAG(rfh_anomaly, 4) OVER(PARTITION BY state ORDER BY year, month) AS rfh_4m_ago
FROM 
    v3_base;

