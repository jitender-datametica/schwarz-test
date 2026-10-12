CREATE OR REPLACE FUNCTION snowconvert_public.int_to_time_udf(input_1 NUMERIC) RETURNS TIME AS (
PARSE_TIME('%H%M%S', FORMAT('%06d', CAST(input_1 AS INT64)))
);
