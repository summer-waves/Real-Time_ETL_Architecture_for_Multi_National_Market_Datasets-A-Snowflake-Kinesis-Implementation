-- 1. Re-create the table to accept ALL values (K, M, and special characters)
CREATE OR REPLACE TABLE global_market_data (
    ticker STRING,
    company_name STRING,
    last_price STRING, 
    market_cap STRING
);

-- 2. Load the data (Removing the metadata column to fix the UTF-8 error)
COPY INTO global_market_data
FROM (
  SELECT $1, $2, $3, $4
  FROM @market_data_stage
)
FILE_FORMAT = (FORMAT_NAME = 'global_stock_csv')
PATTERN = '.*\.csv'
ON_ERROR = 'CONTINUE'; -- This ensures we get the most data possible

SELECT * FROM global_market_data LIMIT 20;
