CREATE OR REPLACE FUNCTION snowconvert_public.period_contains_udf(period_1 STRING, date1 DATETIME) RETURNS BOOL
AS (
CASE WHEN 
    (date1 >= snowconvert_public.period_begin_udf(period_1) AND date1 <= snowconvert_public.period_end_udf(period_1))
  THEN
    TRUE
  ELSE
    FALSE
  END
);