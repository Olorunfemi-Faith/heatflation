# HEATFLATION

![Heatflation Image](images/HEATFLATION_1.png)

A data engineering and analytics project leveraging SQL, Excel, and Python to model the relationship between climate anomalies and grain price fluctuations in Nigeria



## Heatflation Project Work flow

<br>






- [x] Phase 1: **The Problem**
<details>
<summary><kbd> view phase 1 </kbd></summary>

### Phase 1: The Problem (Theoretical & Empirical Framework)

#### 1. What is Heatflation?
"Heatflation" is a recently coined term used in modern economic discourse to describe food price inflation driven directly by extreme heat, drought, and climate shocks. 

In Nigeria, food prices have skyrocketed in recent years, placing immense pressure on household budgets. However, macroeconomic factors like currency devaluation, fuel subsidy removal, and transport costs also drive inflation. The core goal of this project is to empirically test if and to what extent climate anomalies actually impact white maize
in Kaduna and Kano state, Nigeria.

---

#### 2. Goals of the Project
This project sets out to answer three simple questions:

* **Find the Price Change:** Calculate how much grain prices actually rise or fall when bad weather hits.
* **Map the Timeline:** Figure out how long it takes for a weather shock (low rain or poor plant health) to fully hit market prices.
* **Compare Normal vs. Crisis:** Check what maize prices look like during a normal, healthy season versus a period of intense drought.

#### 3. Scope & Variables
* **Commodity:** White Maize (a core staple grain and food security indicator).
* **Location:** Kaduna & Kano State (key grain production and trading hubs in Northern Nigeria).
* **Macroeconomic Control (CPI):** Consumer Price Index used to deflate nominal prices into real prices, isolating weather impacts from general currency inflation.
* **Dependent Variable ($y_t$):** Real price percentage change (`real_price_spike_percent`), adjusted using CPI.
* **Independent Variables ($x_t$):** Rainfall anomaly (`rfh_anomaly`) and Vegetation anomaly (`vim_anomaly`).

</details>

<br>





      
- [ ] Phase 2: **Data Collection**
<details>
<summary><kbd> view phase 2 </kbd></summary>

### Phase 2: Data Collection & Assembly

We constructed a monthly panel dataset combining satellite climate metrics and macroeconomic market data across **Kaduna and Kano State**.

 The 4 Secondary Data Sources
* **Rainfall Data (CHIRPS / HDX):** Monthly rainfall totals used to calculate rainfall anomalies (`rfh_anomaly`).  
  🔗 [HDX Nigeria Subnational Rainfall Data](https://data.humdata.org/dataset/nga-rainfall-subnational)
* **Vegetation Data (MODIS / WFP Datastream):** Satellite crop health metrics (NDVI) used to calculate vegetation index margin anomalies (`vim_anomaly`).  
  🔗 [WFP VAM DataViz / Seasonal Explorer](https://dataviz.vam.wfp.org/)
* **Market Price Data (WFP VAM / HDX):** Retail white maize prices (NGN/kg) in Kaduna and Kano markets.  
  🔗 [HDX WFP Food Prices for Nigeria](https://data.humdata.org/dataset/wfp-food-prices-for-nigeria)
* **Inflation Data (Nigeria NBS):** Consumer Price Index (CPI) used to convert nominal prices into real prices.  
  🔗 [National Bureau of Statistics (NBS) CPI Reports](https://nigerianstat.gov.ng/)
 
</details>   

<br>





      
- [ ] Phase 3: **Data Cleaning** (Excel)
      
<details>
<summary><kbd> view phase 3 </kbd></summary>

   
### Data Cleaning with Excel

( *download complete raw and cleaned dataset* **[HERE](https://drive.google.com/drive/folders/1rbZ0VQx3O_sKAHD_Nkm7Jmk7rwf6XcDj?usp=drive_link)** )

Raw climate and market data contained redundant metadata, structural mismatches, and multi-market duplicates. Excel was utilized to isolate Kano and Kaduna states, standardize pricing metrics, and establish clean monthly time-series baselines.
<br>

***View the Cleaning of each data set below***



<details>
<summary><kbd> Cleaning Food Prices Dataset</kbd></summary>

<br>

<table>
  <tr>
    <th width="50%"><b>Before Cleaning</b></th>
    <th width="50%"><b>After Cleaning</b></th>
  </tr>
  <tr>
    <td valign="top">
      <img src="excel/food_prices_raw_1.png" alt="Before Cleaning Data" width="100%">
    </td>
    <td valign="top">
      <img src="excel/food_prices_clean_1.png" alt="After Cleaning Data" width="100%">
    </td>
  </tr>
</table>


#### **Data Cleaning Steps Executed**
To prepare the raw market data, I used Excel to clean, filter, and organize the records using these 7 steps:

1. **Removed Unnecessary Columns:** Deleted columns that were not needed for the analysis to keep the file clean.
2. **Filtered by Location:** Filtered the data to focus only on **Kano** and **Kaduna** states.
3. **Isolated Commodity & Split Units:** Filtered for **White Maize** and separated the text and numbers in the unit column (e.g., turning "100kg" into `100` and `kg`) using this formula:
   ```excel
   =IF(L2="KG", 1, VALUE(SUBSTITUTE(L2, "KG", "")))
4. **Filtered out Retail:** Removed Retail records to focus only on Wholesale data (doing this before splitting the units would have made things more straightforward!).
5. **Split the Date:** Separated the full date column to keep only the Month and Year.
6. **Calculated Price Per KG:** Created a new column by dividing the total price by the parsed numerical unit.
7. **Aggregated with a Pivot Table:** Used a Pivot Table to average and unify the prices where different markets recorded different prices for the same state in the exact same month.

</details>

<details>
<summary><kbd> Cleaning NDVI Dataset</kbd></summary>

<br>

<table>
  <tr>
    <th width="50%"><b>Before Cleaning</b></th>
    <th width="50%"><b>After Cleaning</b></th>
  </tr>
  <tr>
    <td valign="top">
      <img src="excel/ndvi_raw_1.png" alt="Before Cleaning Data" width="100%">
    </td>
    <td valign="top">
      <img src="excel/ndvi_clean_1.png" alt="After Cleaning Data" width="100%">
    </td>
  </tr>
</table>

</details>

<details>
<summary><kbd> Cleaning Rainfall Dataset</kbd></summary>

<br>

<table>
  <tr>
    <th width="50%"><b>Before Cleaning</b></th>
    <th width="50%"><b>After Cleaning</b></th>
  </tr>
  <tr>
    <td valign="top">
      <img src="excel/rainfall_raw_1.png" alt="Before Cleaning Data" width="100%">
    </td>
    <td valign="top">
      <img src="excel/rainfall_clean_1.png" alt="After Cleaning Data" width="100%">
    </td>
  </tr>
</table>

</details>



<details>
<summary><kbd> Cleaning CPI Dataset</kbd></summary>

<br>

<table>
  <tr>
    <th width="50%"><b>Before Cleaning</b></th>
    <th width="50%"><b>After Cleaning</b></th>
  </tr>
  <tr>
    <td valign="top">
      <img src="excel/cpi_raw_2.png" alt="Before Cleaning Data" width="100%">
    </td>
    <td valign="top">
      <img src="excel/cpi_clean_1.png" alt="After Cleaning Data" width="100%">
    </td>
  </tr>
</table>

</details>
</details>

<br>





- [ ] Phase 4: **Data Analysis** (SQL)
<details>
<summary><kbd> view phase 4 </kbd></summary>


**Database Architecture:** [SQL Script](./sql.sql)
</details>


<br>



- [ ] Phase 5: **Pattern Recognition** (Python)
<details>
<summary><kbd> view phase 5 </kbd></summary>
</details>


<br>


 
- [ ] Phase 6: **Data Visualization**
<details>
<summary><kbd> view phase 6 </kbd></summary>
</details>

<br>


<details>
<summary> Conclusion </summary>
</details>


<details>
<summary> Reference </summary>
</details>



      
