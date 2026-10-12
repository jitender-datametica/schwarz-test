CREATE OR REPLACE FUNCTION snowconvert_public.teradata_datediff_divided_interval_to_varchar(TS1 TIMESTAMP, TS2 TIMESTAMP, DIVN INT64) RETURNS STRING
AS (
(
    WITH diff AS (
      SELECT TIMESTAMP_DIFF(TS1, TS2, SECOND) AS total_sec
    )
    SELECT
      CASE WHEN SIGN(total_sec) >= 0 -- datediff is positive
      THEN
          CONCAT(
              CAST(CAST(total_sec / (60*60*24*DIVN) AS INT64) AS STRING), ' ', -- days
              IF(MOD(CAST(total_sec / (60*60*DIVN) AS INT64),24) < 10,
                 CONCAT('0', CAST(MOD(CAST(total_sec / (60*60*DIVN) AS INT64),24) AS STRING)), -- add zero if hour < 10
                 CAST(MOD(CAST(total_sec / (60*60*DIVN) AS INT64),24) AS STRING)), ':', -- hours
              IF(MOD(CAST(total_sec / (60*DIVN) AS INT64),60) < 10,
                 CONCAT('0', CAST(MOD(CAST(total_sec / (60*DIVN) AS INT64),60) AS STRING)), -- add zero if min < 10
                 CAST(MOD(CAST(total_sec / (60*DIVN) AS INT64),60) AS STRING)), ':', -- minutes
              IF(MOD(CAST(total_sec / DIVN AS INT64),60) < 10,
                 CONCAT('0', CAST(MOD(CAST(total_sec / DIVN AS INT64),60) AS STRING)), -- add zero if sec < 10
                 CAST(MOD(CAST(total_sec / DIVN AS INT64),60) AS STRING)) -- seconds
          )
      ELSE -- datediff is negative
          CONCAT(
              '-',
              CAST(CAST(ABS(total_sec) / (60*60*24*DIVN) AS INT64) AS STRING), ' ', -- days
              IF(MOD(CAST(ABS(total_sec) / (60*60*DIVN) AS INT64),24) < 10,
                 CONCAT('0', CAST(MOD(CAST(ABS(total_sec) / (60*60*DIVN) AS INT64),24) AS STRING)), -- add zero if hour < 10
                 CAST(MOD(CAST(ABS(total_sec) / (60*60*DIVN) AS INT64),24) AS STRING)), ':', -- hours
              IF(MOD(CAST(ABS(total_sec) / (60*DIVN) AS INT64),60) < 10,
                 CONCAT('0', CAST(MOD(CAST(ABS(total_sec) / (60*DIVN) AS INT64),60) AS STRING)), -- add zero if min < 10
                 CAST(MOD(CAST(ABS(total_sec) / (60*DIVN) AS INT64),60) AS STRING)), ':', -- minutes
              IF(MOD(CAST(ABS(total_sec) / DIVN AS INT64),60) < 10,
                 CONCAT('0', CAST(MOD(CAST(ABS(total_sec) / DIVN AS INT64),60) AS STRING)), -- add zero if sec < 10
                 CAST(MOD(CAST(ABS(total_sec) / DIVN AS INT64),60) AS STRING)) -- seconds
          )
      END
    FROM diff
  )
);