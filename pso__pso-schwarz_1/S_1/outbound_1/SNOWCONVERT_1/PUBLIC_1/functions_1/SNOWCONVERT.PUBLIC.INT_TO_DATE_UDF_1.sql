CREATE OR REPLACE FUNCTION snowconvert_public.int_to_date_udf(input_1 INT64) RETURNS DATE AS (
PARSE_DATE('%Y%m%d', CAST(input_1 + 19000000 AS STRING))
);
