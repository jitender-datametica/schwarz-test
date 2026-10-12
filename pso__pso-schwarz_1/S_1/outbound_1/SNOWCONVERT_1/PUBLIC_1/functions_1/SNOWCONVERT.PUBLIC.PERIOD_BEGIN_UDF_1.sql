CREATE OR REPLACE FUNCTION snowconvert_public.period_begin_udf(period_val STRING) RETURNS DATETIME
AS (
CAST(SUBSTR(period_val, 1, STRPOS(period_val, '*') - 1) AS DATETIME)
);