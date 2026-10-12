CREATE OR REPLACE FUNCTION snowconvert_public.period_ldiff_udf(PERIOD_1 STRING, PERIOD_2 STRING) RETURNS STRING
AS (
CASE 
    WHEN snowconvert_public.period_overlaps_udf(PERIOD_2, PERIOD_1) = TRUE 
         AND snowconvert_public.period_begin_udf(PERIOD_1) < snowconvert_public.period_begin_udf(PERIOD_2) 
    THEN
      CONCAT(
        SUBSTR(PERIOD_1, 1, STRPOS(PERIOD_1, '*') - 1), 
        '*', 
        SUBSTR(PERIOD_2, 1, STRPOS(PERIOD_2, '*') - 1)
      )
    ELSE
      NULL
  END
);