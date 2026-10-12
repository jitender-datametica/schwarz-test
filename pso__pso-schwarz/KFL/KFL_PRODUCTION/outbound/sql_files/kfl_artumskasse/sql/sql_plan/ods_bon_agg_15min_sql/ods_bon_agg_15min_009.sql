-- [OK] statement is translated correctly (syntax and type checks are fine)

DROP TABLE IF EXISTS dbp_etl.ods_bon_sign_on_off_time;

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

CREATE TABLE IF NOT EXISTS dbp_etl.ods_bon_sign_on_off_time(
  wup_id INTEGER NOT NULL,
  mandant_id INTEGER NOT NULL,
  kassensystem_name STRING(10),
  kasse_nr INTEGER,
  kasse_typ_id INTEGER,
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL);

-- [not OK] statement is not translated correctly-----------------------------------------------------------------
-- WARNING : MSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS width PRECEDING)
-- WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.

INSERT INTO dbp_etl.ods_bon_sign_on_off_time
  (
    wup_id,
    mandant_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    start_time,
    end_time)
    (
      SELECT
        t1.wup_id,
        t1.mandant_id,
        t1.kassensystem_name,
        t1.kasse_nr,
        t1.kasse_typ_id,
        t1.bon_ende AS start_time,
        MAX(
          COALESCE(
            t2.bon_ende,
            t3.bon_ende,
            PARSE_DATETIME(
              '%F %H:%M:%S', CAST(DATE(t1.bon_ende) AS STRING) || ' 23:59:59')))
          AS end_time
      FROM
        (
          SELECT
            wup_id,
            bon_dat,
            mandant_id,
            kassensystem_name,
            kasse_nr,
            kasse_typ_id,
            bon_ende,
            bon_nr  -- ,MSum(bon_nr,2,bon_nr DESC)-bon_nr  folgeBon  --original from TD
              ,
            (
              LEAD(bon_nr)
                OVER (
                  PARTITION BY wup_id, mandant_id, kasse_nr, bon_dat
                  ORDER BY bon_nr IS NULL DESC, bon_nr DESC
                ))
              - bon_nr AS folgebon,
            CASE
              WHEN
                (
                  LEAD(bon_nr)
                    OVER (
                      PARTITION BY wup_id, mandant_id, kasse_nr, bon_dat
                      ORDER BY bon_nr IS NULL DESC, bon_nr DESC
                    ))
                  - bon_nr
                = 0
                THEN 99999999
              ELSE
                (
                  LEAD(bon_nr)
                    OVER (
                      PARTITION BY wup_id, mandant_id, kasse_nr, bon_dat
                      ORDER BY bon_nr IS NULL DESC, bon_nr DESC
                    ))
                - bon_nr
              END AS folge_bon_nr
          FROM dbp_etl.ods_bon_sign_on_off
          WHERE
            transaction_name IN (
              'SignOnTransaction             ')  -- GROUP BY wup_id,mandant_id,kasse_nr,bon_dat
        ) AS t1
      LEFT JOIN
        (
          SELECT *
          FROM dbp_etl.ods_bon_sign_on_off
          WHERE transaction_name IN ('SignOffTransaction            ')
        ) AS t2
        ON
          t1.wup_id = t2.wup_id
          AND t1.mandant_id = t2.mandant_id
          AND t1.kassensystem_name = t2.kassensystem_name
          AND t1.kasse_nr = t2.kasse_nr
          AND t2.bon_nr
            BETWEEN t1.bon_nr
            AND t1.folge_bon_nr
          AND t1.bon_dat = t2.bon_dat
      LEFT JOIN
        (
          SELECT *
          FROM dbp_etl.ods_bon_sign_on_off
          WHERE transaction_name IN ('SignOnTransaction           ')
        ) AS t3
        ON
          t1.wup_id = t3.wup_id
          AND t1.mandant_id = t3.mandant_id
          AND t1.kassensystem_name = t3.kassensystem_name
          AND t1.kasse_nr = t3.kasse_nr
          AND t1.folge_bon_nr = t3.bon_nr
          AND t1.bon_dat = t3.bon_dat
      GROUP BY
        t1.mandant_id,
        t1.wup_id,
        t1.kassensystem_name,
        t1.kasse_nr,
        t1.kasse_typ_id,
        start_time
    );

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
-- WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
-- WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

CREATE OR REPLACE TABLE dbp_etl._kill_zombies_${TRANSIENT_TABLE_SUFFIX}
AS
SELECT
  wup_id,
  mandant_id,
  kasse_nr,
  DATE(start_time) AS dat
FROM dbp_etl.ods_bon_sign_on_off_time
WHERE
  LPAD(CAST(EXTRACT(HOUR FROM start_time) AS STRING), 2, '0')
      || ':' || LPAD(CAST(EXTRACT(MINUTE FROM start_time) AS STRING), 2, '0')
      || ':' || LPAD(CAST(EXTRACT(SECOND FROM start_time) AS STRING), 2, '0')
    = '00:00:00'
  AND LPAD(CAST(EXTRACT(HOUR FROM end_time) AS STRING), 2, '0')
    || ':'
    || LPAD(CAST(EXTRACT(MINUTE FROM end_time) AS STRING), 2, '0')
    || ':'
    || LPAD(CAST(EXTRACT(SECOND FROM end_time) AS STRING), 2, '0') = '23:59:59';
