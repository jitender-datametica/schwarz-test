CREATE OR REPLACE FUNCTION snowconvert_public.interval_add_udf(INPUT_PART1 STRING, INPUT_VALUE1 STRING, INPUT_PART2 STRING, INPUT_VALUE2 STRING, OP STRING, OUTPUT_PART STRING) RETURNS STRING
AS (
(
CASE 
    WHEN INPUT_PART1 = 'YEAR TO MONTH' OR INPUT_PART2 = 'YEAR TO MONTH' THEN
        CASE 
            WHEN OP = '+' THEN
                snowconvert_public.seconds2interval_udf(OUTPUT_PART, CAST(snowconvert_public.interval2months_udf(INPUT_VALUE1) + snowconvert_public.interval2months_udf(INPUT_VALUE2) AS INT64))
            WHEN OP = '-' THEN
                snowconvert_public.seconds2interval_udf(OUTPUT_PART, CAST(snowconvert_public.interval2months_udf(INPUT_VALUE1) - snowconvert_public.interval2months_udf(INPUT_VALUE2) AS INT64))
        END
    ELSE 
        CASE 
            WHEN OP = '+' THEN
                snowconvert_public.seconds2interval_udf(OUTPUT_PART, CAST(snowconvert_public.interval2seconds_udf(INPUT_PART1, INPUT_VALUE1) + snowconvert_public.interval2seconds_udf(INPUT_PART2, INPUT_VALUE2) AS INT64))
            WHEN OP = '-' THEN
                snowconvert_public.seconds2interval_udf(OUTPUT_PART, CAST(snowconvert_public.interval2seconds_udf(INPUT_PART1, INPUT_VALUE1) - snowconvert_public.interval2seconds_udf(INPUT_PART2, INPUT_VALUE2) AS INT64))
        END  
END
)
);