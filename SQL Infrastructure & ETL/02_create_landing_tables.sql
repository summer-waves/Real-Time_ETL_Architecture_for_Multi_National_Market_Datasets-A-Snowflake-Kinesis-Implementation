-- 1. Use your project home
USE DATABASE MARKET_INSIGHTS_DB;
USE SCHEMA RAW_DATA_SCHEMA;

-- 2. THE MOMENT OF TRUTH: Sniff the headers
-- This failed before because of the AWS /* issue. It will work now!
SELECT *
FROM TABLE(
  INFER_SCHEMA(
    LOCATION=>'@market_data_stage/NASDAQ_Stock.csv',
    FILE_FORMAT=>'global_stock_csv'
  )
);