# 📊 E‑Commerce Data Analysis & Data Quality Audit (End‑to‑End)

## 🔍 Project Overview

This project is a **full-scale, end‑to‑end e‑commerce data analysis, data cleaning, validation, and business intelligence pipeline** built using **Python, SQL, Pandas, RapidFuzz, and Matplotlib**.

The notebook (`ecommerceAnalysis.ipynb`) does **NOT** only analyze data — it **audits data quality**, **creates validation flags**, **fixes real-world inconsistencies**, and then performs **deep business analysis with extensive visualizations**.

---

## 🧰 Technologies & Libraries Used

* **Python** – core programming language
* **Pandas** – data manipulation & joins
* **SQL (MySQL)** – data extraction
* **SQLAlchemy** – database connection
* **NumPy** – numerical operations
* **Missingno** – missing-value visualization
* **RapidFuzz** – fuzzy string matching & data correction
* **Matplotlib** – business visualizations
* **Jupyter Notebook** – interactive workflow

---

## 🗄️ Database Tables Used

Data is loaded directly from a MySQL database using SQL queries.

| Table Name  | Purpose                            |
| ----------- | ---------------------------------- |
| Orders      | Order dates, delivery info, status |
| Users       | Customer identity & demographics   |
| Products    | Pricing, stock, rating             |
| Order_Items | Quantity & final prices            |
| Categories  | Product categorization             |
| Locations   | Country, state, postal data        |
| Reviews     | Ratings & customer feedback        |

---

## 🔌 Database Connection

```python
engine = create_engine("mysql+pymysql://username:passpword@localhost:port/databasename")
```

* Establishes a live connection to the MySQL database
* Enables direct SQL → Pandas integration

---

## 📥 Data Loading (SQL → Pandas)

Each table is imported using `pd.read_sql()`:

```python
dfOrders, dfUsers, dfProducts, dfItems, dfCategories, dfLocation, dfReviews
```

This ensures:

* Schema awareness
* Type inference
* Scalable analytics

---

## 🧪 REVIEWS DATA: DATA QUALITY CHECKS

### Missing Value Visualization

```python
msno.matrix(dfReviews)
```

* Visually highlights missing patterns
* Detects systemic vs random missing data

### Flags Created (Explicit Auditing)

```python
dfReviews['missedRating']
dfReviews['missingReviewText']
```

Purpose:

* Track data issues instead of silently fixing them
* Allow reporting on data quality later

### Missing Rating Handling (Product‑Level Median)

```python
dfReviews.groupby('product_id')['rating'].median()
```

* Missing ratings replaced using **product‑specific median**
* Prevents cross‑product bias

### Review Text Cleaning

Steps performed:

1. Empty strings → NaN
2. Missing review text replaced by **most frequent review per rating**
3. Ensures text completeness for NLP readiness

---

## 🌍 LOCATION DATA CLEANING (RapidFuzz)

### Country Validation

```python
actualCountries = ['USA','UK','Australia','France','Germany','Japan','India','Canada','Brazil','UAE']
```

### Fuzzy Matching with RapidFuzz

```python
process.extractOne()
```

* Automatically fixes spelling mistakes like:

  * "Austrailia" → "Australia"
  * "Unted States" → "USA"
* Threshold = **80% similarity**
* Prevents manual rule explosion

---

## 🏷️ CATEGORY CLEANING

```python
'Fashon' → 'Fashion'
```

* Fixes categorical fragmentation
* Ensures grouping accuracy

---

## 📦 PRODUCT DATA VALIDATION

### Stock Integrity

```python
stock_issue = current_stock < 0
```

* Flags invalid stock
* Forces negative stock → 0

### Pricing Anomalies

```python
cost_price > sale_price
```

* Identifies loss‑making products
* Calculates:

  * Profit
  * Loss percentage
  * Total financial loss

### Rating Sanity Checks

* Missing ratings → mean
* Ratings clipped between **0 and 5**

---

## 👤 USER DATA CLEANING

### Flags Created

* `missingEmail`

### Fixes Applied

* Missing emails replaced with placeholder
* Full customer name created

---

## 🚚 ORDER DATA VALIDATION

### Flags Created

* `deliveryMissing`
* `invalidDelivery`

Checks:

* Delivery date before order date
* Missing delivery timestamps

---

## 🔗 MASTER DATASET CREATION

All tables merged into a **single analytical dataframe**:

```python
df = Orders + Items + Products + Categories + Users + Locations
```

Purpose:

* One source of truth
* BI‑ready dataset

---

## 📈 BUSINESS ANALYTICS & VISUALIZATIONS

### 🏆 Top 10 Revenue Products (Bar Chart)

* Identifies profit drivers

### 📦 Top Selling Products (Dual Axis)

* Orders vs Revenue comparison

### ⭐ Top 5 Customers

* Orders vs Total Spend
* High‑value customer detection

### 📅 Daily Revenue Trend (Rolling Mean)

* Revenue + Quantity on dual axes
* Detects volatility

### 🗓️ Monthly Revenue Trend

* Seasonal patterns

### 📣 Traffic Source Performance

* Marketing ROI analysis

### 🧾 Category Revenue & Order Share

* Bar chart + Pie chart
* Category dominance detection

### 📦 Order Status Distribution (Pie)

* Completion vs cancellation insight

---

## 🎯 Key Outcomes

* Built **data quality flags instead of silent fixes**
* Used **fuzzy matching for real‑world dirty data**
* Created **5+ visual business insights**
* Identified revenue leaks & loss‑making products
