CREATE OR REPLACE FUNCTION snowconvert_public.interval2months_udf(input_value STRING) RETURNS INT64
AS (
CASE 
    WHEN SUBSTR(input_value, 1, 1) = '-' THEN
      12 * CAST(SUBSTR(input_value, 1, STRPOS(SUBSTR(input_value, 2), '-')) AS INT64)
      - CAST(SUBSTR(input_value, STRPOS(input_value, '-') + 1) AS INT64)
    ELSE
      12 * CAST(SUBSTR(input_value, 1, STRPOS(SUBSTR(input_value, 2), '-')) AS INT64)
      + CAST(SUBSTR(input_value, STRPOS(input_value, '-') + 1) AS INT64)
  END
);