CREATE OR REPLACE FUNCTION snowconvert_public.period_rdiff_udf(PERIOD_1 STRING, PERIOD_2 STRING) RETURNS STRING
AS (
CASE 
    -- Note: If your PERIOD_OVERLAPS_UDF returns a BOOL (like the one we just translated), 
    -- you should drop the quotes around TRUE, like this: = TRUE (or just remove the = TRUE entirely)
    WHEN snowconvert_public.period_overlaps_udf(PERIOD_2, PERIOD_1) = TRUE
         AND snowconvert_public.period_end_udf(PERIOD_1) > snowconvert_public.period_end_udf(PERIOD_2) 
    THEN
      CONCAT(
        SUBSTR(PERIOD_2, STRPOS(PERIOD_2, '*') + 1), 
        '*', 
        SUBSTR(PERIOD_1, STRPOS(PERIOD_1, '*') + 1)
      )
    ELSE
      NULL
  END
);