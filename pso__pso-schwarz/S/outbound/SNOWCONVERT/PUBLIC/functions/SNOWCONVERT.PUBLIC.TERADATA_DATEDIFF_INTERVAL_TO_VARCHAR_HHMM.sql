CREATE OR REPLACE FUNCTION snowconvert_public.teradata_datediff_interval_to_varchar_hhmm(TS1 TIMESTAMP, TS2 TIMESTAMP) RETURNS STRING
AS (
(
  CASE WHEN SIGN(TIMESTAMP_DIFF(TS1, TS2, SECOND)) >= 0 -- datediff is positive
       THEN
           IF(FLOOR(TIMESTAMP_DIFF(TS1, TS2, SECOND)/(60*60)) < 10, 
               CAST('0' || CAST(FLOOR(TIMESTAMP_DIFF(TS1, TS2, SECOND)/(60*60)) AS STRING) AS STRING),                        -- add zero if hour < 10
               CAST(            FLOOR(TIMESTAMP_DIFF(TS1, TS2, SECOND)/(60*60)) AS STRING))            || ':' || -- hours
           IF(MOD(CAST(FLOOR(TIMESTAMP_DIFF(TS1, TS2, SECOND)/(60)) AS INT64), 60) < 10,
               CAST('0' || CAST(MOD(CAST(FLOOR(TIMESTAMP_DIFF(TS1, TS2, SECOND)/(60)) AS INT64), 60) AS STRING) AS STRING),                   -- add zero if min < 10
               CAST(            MOD(CAST(FLOOR(TIMESTAMP_DIFF(TS1, TS2, SECOND)/(60)) AS INT64), 60) AS STRING))                 -- minutes
       ELSE -- datediff is negative
           '-' ||
           IF(FLOOR(TIMESTAMP_DIFF(TS2, TS1, SECOND)/(60*60)) < 10, 
               CAST('0' || CAST(FLOOR(TIMESTAMP_DIFF(TS2, TS1, SECOND)/(60*60)) AS STRING) AS STRING),                        -- add zero if hour < 10
               CAST(            FLOOR(TIMESTAMP_DIFF(TS2, TS1, SECOND)/(60*60)) AS STRING))             || ':' || -- hours
           IF(MOD(CAST(FLOOR(TIMESTAMP_DIFF(TS2, TS1, SECOND)/(60)) AS INT64), 60) < 10,
               CAST('0' || CAST(MOD(CAST(FLOOR(TIMESTAMP_DIFF(TS2, TS1, SECOND)/(60)) AS INT64), 60) AS STRING) AS STRING),                    -- add zero if min < 10
               CAST(            MOD(CAST(FLOOR(TIMESTAMP_DIFF(TS2, TS1, SECOND)/(60)) AS INT64), 60) AS STRING))                  -- minutes
  END
)
);