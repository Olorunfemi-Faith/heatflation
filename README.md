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
"Heatflation" refers to inflation driven directly by extreme heat, drought, and climate shocks. In agricultural economics, it describes the process where severe weather reduces crop yields, creates supply deficits in local markets, and causes food prices to surge.

---

#### 2. Goals of the Project
Following **Wooldridge’s framework for empirical economic analysis**, this project aims to:
* **Quantify the Shock:** Measure how severe weather anomalies impact real grain prices.
* **Identify the Lag:** Determine the exact timeline (transmission delay) between a weather event, crop stress, and market price spikes.
* **Establish Baselines:** Compare market prices during normal climate seasons against intense drought periods.

---

#### 3. Selection of Variables & Scope
To keep the econometric model focused and controlled, specific scope choices were made:
* **Commodity (White Maize):** White maize was selected because it is a critical staple grain in Northern Nigeria, acting as a primary food source for households and a key indicator of regional food security.
* **Geographic Scope (Kano & Katsina States):** These two northern states were chosen due to their high vulnerability to Sahelian drought patterns and their roles as major grain production and market hubs in the region.

---

#### 4. Econometric Model Variables
To model the relationship, variables were defined as follows:

* **Dependent Variable ($Y$):** 
  * `real_price_spike_percent`: The percentage change in inflation-adjusted grain prices relative to historical baselines.
* **Independent Variables ($X$):**
  * `rfh_anomaly`: Rainfall anomaly (meteorological shock).
  * `vim_anomaly`: Vegetation Index Margin anomaly (agricultural/crop health shock).
  * **Lagged Terms:** Both independent variables are tracked at $t-1, t-2, t-3,$ and $t-4$ months to capture delayed impacts.

---

#### 5. Data Retrieval & Matching
To build a dataset suitable for empirical analysis, secondary data was pulled and merged across matching timeframes (monthly level) and spatial boundaries (state level):
* **Climate Data:** Satellite-derived rainfall and vegetation health anomalies to measure environmental deviations from historical norms.
* **Market Data:** Local retail and wholesale real prices for white maize across Kano and Katsina.

---

#### 6. Biological vs. Economic Lags
In econometrics, shocks rarely impact markets instantaneously. Following **Wooldridge's Distributed Lag Model**, the total response is split into two distinct physical processes:

* **Biological Lag (Rainfall to Soil/Crop Response):** 
  * *The Mechanism:* It takes roughly 30 days ($t-1$) for rainfall deficits to physically affect soil moisture, stunt crop growth, and register on satellite vegetation sensors (VIM).
* **Economic Lag (Crop Failure to Market Price Shock):** 
  * *The Mechanism:* When crops fail, prices do not spike immediately because traders and households consume existing food reserves. It takes approximately 60 days ($t-2$) for storage reserves to run out, at which point the supply deficit hits the market at full force and triggers peak price inflation.

</details>

<br>





      
- [ ] Phase 2: **Data Collection**
<details>
<summary><kbd> view phase 2 </kbd></summary>
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



      
