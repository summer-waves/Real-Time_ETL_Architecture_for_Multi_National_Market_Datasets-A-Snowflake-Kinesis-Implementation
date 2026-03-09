-- 1. Create the Pipe (The "Ear" that listens to S3)
CREATE OR REPLACE PIPE market_data_pipe
  AUTO_INGEST = TRUE
  AS
  COPY INTO global_market_data
  FROM (
    SELECT $1, $2, $3, $4
    FROM @market_data_stage
  )
  FILE_FORMAT = (FORMAT_NAME = 'global_stock_csv');

-- 2. Get the "S3 Notification" code
SHOW PIPES;