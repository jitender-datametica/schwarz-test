CREATE OR REPLACE FUNCTION snowconvert_public.period_end_udf(period_val STRING) RETURNS DATETIME
AS (
CAST(SUBSTR(period_val, STRPOS(period_val, '*') + 1) AS DATETIME)
);