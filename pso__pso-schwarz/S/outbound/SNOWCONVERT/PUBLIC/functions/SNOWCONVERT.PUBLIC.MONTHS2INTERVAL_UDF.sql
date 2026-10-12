CREATE OR REPLACE FUNCTION snowconvert_public.months2interval_udf(input_part STRING, input_value INT64) RETURNS STRING
AS (
CASE input_part
        WHEN 'YEAR' THEN 
            CAST(input_value / 12 AS STRING)
        WHEN 'YEAR TO MONTH' THEN 
            CONCAT(CAST(TRUNC(input_value / 12) AS STRING), '-', CAST(MOD(input_value, 12) AS STRING))
        WHEN 'MONTH' THEN 
            CAST(input_value AS STRING)
    END
);