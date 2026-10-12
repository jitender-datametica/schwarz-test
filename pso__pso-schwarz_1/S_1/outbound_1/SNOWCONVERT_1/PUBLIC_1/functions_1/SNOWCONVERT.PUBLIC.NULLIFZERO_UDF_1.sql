CREATE OR REPLACE FUNCTION snowconvert_public.nullifzero_udf(val2 INT64) RETURNS INT64
AS (
NULLIF(val2, 0)
);