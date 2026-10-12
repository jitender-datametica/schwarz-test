CREATE OR REPLACE FUNCTION snowconvert_public.period_overlaps_udf(PERIOD_1 STRING, PERIOD_2 STRING) RETURNS BOOL
AS (
CASE 
    WHEN 
      (snowconvert_public.period_end_udf(PERIOD_1) >= snowconvert_public.period_begin_udf(PERIOD_2) AND
       snowconvert_public.period_begin_udf(PERIOD_1)  < snowconvert_public.period_end_udf(PERIOD_2))
      OR
      (snowconvert_public.period_begin_udf(PERIOD_1) >= snowconvert_public.period_begin_udf(PERIOD_2) AND
       snowconvert_public.period_begin_udf(PERIOD_1) < snowconvert_public.period_end_udf(PERIOD_2))
    THEN
      TRUE
    ELSE
      FALSE
  END
);