CREATE OR REPLACE FUNCTION snowconvert_public.teradata_datediff_interval_to_varchar_dh(TS1 TIMESTAMP, TS2 TIMESTAMP) RETURNS STRING
AS (
(
  CASE WHEN SIGN(TIMESTAMP_DIFF(TS1, TS2, SECOND)) >= 0 -- datediff is positive
       THEN
           CAST(FLOOR(TIMESTAMP_DIFF(TS1, TS2, SECOND)/(60*60*24)) AS STRING)                                            || ' ' || -- days
           CAST(MOD(CAST(FLOOR(TIMESTAMP_DIFF(TS1, TS2, SECOND)/(60*60)) AS INT64), 24) AS STRING)                                       -- hours
       ELSE -- datediff is negative
           '-' ||
           CAST(FLOOR(TIMESTAMP_DIFF(TS2, TS1, SECOND)/(60*60*24)) AS STRING)                                            || ' ' || -- days
           CAST(MOD(CAST(FLOOR(TIMESTAMP_DIFF(TS2, TS1, SECOND)/(60*60)) AS INT64), 24) AS STRING)                                       -- hours
  END
)
);