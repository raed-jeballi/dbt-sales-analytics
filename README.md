# Brazilian E-commerce Analytics with dbt

A complete dbt project analyzing Olist Brazilian E-commerce data.

## Project Structure
- `raw/` - Source data from Kaggle
- `staging/` - Cleaned and standardized models  
- `analytics/` - Business-ready data marts

## Setup
1. Clone repository
2. `dbt seed` to load data from Kaggle
3. `dbt run` to build the pipeline
