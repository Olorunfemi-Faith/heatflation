# grain-price-climate-modeling
A data engineering and analytics project leveraging SQL, Excel, and Python to model the relationship between climate anomalies and grain price fluctuations in Nigeria
## 🛠️ Data Engineering & ETL Pipeline

To prepare our four distinct datasets (Food Prices, NDVI, Rainfall, and CPI) for analytical modeling, a structured multi-stage ETL pipeline was executed across Excel and PostgreSQL.

### 📈 Phase 1: Excel Data Cleaning & Feature Selection
Raw climate and market data contained redundant metadata, structural mismatches, and multi-market duplicates. Excel was utilized to isolate Kano and Kaduna states, standardize pricing metrics, and establish clean monthly time-series baselines.
<details>
<summary>🔍 Click to view Before/After: <b>Food Prices Dataset</b></summary>

#### **Before: Granular Multi-Market Mismatch**
![Raw food prices data](food_price_raw.png)

#### **After: Standardized Monthly Baseline**
![Clean food prices data](food_price_clean.png)
</details>

<details>
<summary>🛰️ Click to view Before/After: <b>NDVI (Vegetation Index) Dataset</b></summary>

#### **Before: Raw Satellite Readings**
![Raw NDVI data](images/ndvi_raw.png)

#### **After: Clean Monthly VIM Matrix**
![Clean NDVI data](images/ndvi_clean.png)
</details>

<details>
<summary>🌧️ Click to view Before/After: <b>Rainfall Dataset</b></summary>

#### **Before: Historical Daily Records**
![Raw Rainfall data](images/rainfall_raw.png)

#### **After: Monthly Precipitation Baselines**
![Clean Rainfall data](images/rainfall_clean.png)
</details>

<details>
<summary>📈 Click to view Before/After: <b>CPI (Inflation Index) Dataset</b></summary>

#### **Before: Raw Annual Macro Index**
![Raw CPI data](images/cpi_raw.png)

#### **After: Clean Scaled Inflation Mappings**
![Clean CPI data](images/cpi_clean.png)
</details>
