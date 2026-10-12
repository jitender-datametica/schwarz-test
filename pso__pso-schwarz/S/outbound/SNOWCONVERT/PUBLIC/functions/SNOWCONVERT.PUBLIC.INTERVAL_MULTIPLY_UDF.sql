CREATE OR REPLACE FUNCTION snowconvert_public.interval_multiply_udf(INPUT_PART STRING, INPUT_VALUE STRING, INPUT_MULT INT64) RETURNS STRING
AS (
(
CASE WHEN INPUT_PART = 'YEAR TO MONTH'
THEN snowconvert_public.months2interval_udf(INPUT_PART, CAST(snowconvert_public.interval2months_udf(INPUT_VALUE) * INPUT_MULT AS INT64))
ELSE snowconvert_public.seconds2interval_udf(INPUT_PART, CAST(snowconvert_public.interval2seconds_udf(INPUT_PART, INPUT_VALUE) * INPUT_MULT AS INT64))
END
)
);