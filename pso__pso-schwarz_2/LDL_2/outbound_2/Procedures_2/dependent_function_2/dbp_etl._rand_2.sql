-- Define this at the top of your script/procedure
CREATE FUNCTION `dbp_etl._rand`(min_val INT64, max_val INT64, size_val INT64)
RETURNS STRING
AS (
  LPAD(CAST(CAST(FLOOR(RAND() * (max_val - min_val + 1)) + min_val AS INT64) AS STRING), size_val, '0')
);
