CREATE OR REPLACE FUNCTION snowconvert_public.period(period_start DATETIME, period_end DATETIME) RETURNS STRING
AS (
CAST(period_start AS STRING) || '*' || CAST(period_end AS STRING)
);