CREATE OR REPLACE FUNCTION snowconvert_public.date_to_int_udf(input_1 TIMESTAMP) RETURNS INT64
AS (
(EXTRACT(YEAR FROM input_1) - 1900) * 10000 + 
  EXTRACT(MONTH FROM input_1) * 100 + 
  EXTRACT(DAY FROM input_1)
);