CREATE OR REPLACE FUNCTION snowconvert_public.period_intersect_udf(period_1 STRING, period_2 STRING) RETURNS STRING
AS (
CASE WHEN 
    LEAST(snowconvert_public.period_end_udf(period_1), snowconvert_public.period_end_udf(period_2)) < GREATEST(snowconvert_public.period_begin_udf(period_1), snowconvert_public.period_begin_udf(period_2))
    THEN NULL
  ELSE
    snowconvert_public.period(
        GREATEST(snowconvert_public.period_begin_udf(period_1), snowconvert_public.period_begin_udf(period_2)), 
        LEAST(snowconvert_public.period_end_udf(period_1), snowconvert_public.period_end_udf(period_2))
    )
  END
);