-- [OK] statement is translated correctly (syntax and type checks are fine)

DROP TABLE IF EXISTS dbp_etl.bon_agg_kassierzeiten_1;

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

CREATE TABLE IF NOT EXISTS dbp_etl.bon_agg_kassierzeiten_1(
  mandant_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  kassensystem_name STRING(10),
  kasse_nr INTEGER NOT NULL,
  kasse_typ_id INTEGER,
  bon_dat DATE NOT NULL,
  bon_beginn DATETIME,
  bon_ende DATETIME,
  scan_ende DATETIME);

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

INSERT INTO dbp_etl.bon_agg_kassierzeiten_1
  (
    mandant_id,
    wup_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    bon_dat,
    bon_beginn,
    bon_ende,
    scan_ende)
    (
      SELECT
        K.mandant_id AS mandant_id,
        K.wup_id AS wup_id,
        T.kassensystem_name,
        K.kasse_nr AS kasse_nr,
        K.kasse_typ_id AS kasse_typ_id,
        K.bon_dat,
        K.bon_beginn AS bon_beginn,
        K.bon_ende AS bon_ende,
        MAX(
          COALESCE(
            COALESCE(
              COALESCE(V.start_bon_zeile, R.start_bon_zeile),
              F.start_bon_zeile),
            K.bon_beginn)) AS scan_ende
      FROM dbp_ods.ods_bon_kopf_1 AS K
      LEFT JOIN dbp_ods.ods_bon_transaction_1 AS T
        ON
          K.bon_id = T.bon_id
          AND K.wup_id = T.wup_id
          AND K.mandant_id
            = T.mandant_id
      LEFT JOIN dbp_ods.ods_bon_verkauf_1 AS V
        ON
          K.bon_id = V.bon_id
          AND K.wup_id = V.wup_id
          AND K.mandant_id
            = V.mandant_id
      LEFT JOIN dbp_ods.ods_bon_retoure_1 AS R
        ON
          K.bon_id = R.bon_id
          AND K.wup_id = R.wup_id
          AND K.mandant_id
            = R.mandant_id
      LEFT JOIN dbp_ods.ods_bon_financial_1 AS F
        ON
          K.bon_id = F.bon_id
          AND K.wup_id = F.wup_id
          AND K.mandant_id
            = F.mandant_id
      WHERE
        K.reactivated_fg = 0
        AND K.bon_dat
          BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 15 DAY)
          AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND V.bon_dat
          BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 15 DAY)
          AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND T.bon_dat
          BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 15 DAY)
          AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
        AND (K.mandant_id, K.wup_id, T.kassensystem_name, K.kasse_nr, K.bon_dat)
          IN (
            SELECT (mandant_id, wup_id, kassensystem_name, kasse_nr, bon_dat)
            FROM dbp_etl.bon_agg_kassenberichte_1
          )
      GROUP BY
        mandant_id,
        wup_id,
        T.kassensystem_name,
        kasse_nr,
        kasse_typ_id,
        K.bon_dat,
        bon_beginn,
        bon_ende
    );

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

INSERT INTO dbp_etl.bon_agg_kassierzeiten_1
  (
    mandant_id,
    wup_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    bon_dat,
    bon_beginn,
    bon_ende,
    scan_ende)
    (
      SELECT
        mandant_id,
        wup_id,
        kassensystem_name,
        kasse_nr,
        kasse_typ_id,
        bon_dat,
        bon_beginn,
        bon_ende,
        scan_ende
      FROM
        (
          SELECT
            mandant_id,
            wup_id,
            kassensystem_name,
            kasse_nr,
            kasse_typ_id,
            bon_dat,
            bon_beginn,
            PARSE_DATETIME(
              '%F %H:%M:%S', FORMAT_DATETIME('%F', bon_beginn) || ' 23:59:59')
              AS scan_ende,
            bon_ende
          FROM dbp_etl.bon_agg_kassierzeiten_1
          WHERE DATE(scan_ende) > DATE(bon_beginn)
          UNION ALL
          SELECT
            mandant_id,
            wup_id,
            kassensystem_name,
            kasse_nr,
            kasse_typ_id,
            bon_dat,
            PARSE_DATETIME(
              '%F %H:%M:%S', FORMAT_DATETIME('%F', scan_ende) || ' 00:00:00')
              AS bon_beginn,
            scan_ende,
            bon_ende
          FROM dbp_etl.bon_agg_kassierzeiten_1
          WHERE DATE(scan_ende) > DATE(bon_beginn)
          UNION ALL
          SELECT
            mandant_id,
            wup_id,
            kassensystem_name,
            kasse_nr,
            kasse_typ_id,
            bon_dat,
            bon_beginn,
            scan_ende,
            PARSE_DATETIME(
              '%F %H:%M:%S', FORMAT_DATETIME('%F', scan_ende) || ' 23:59:59')
              AS bon_ende
          FROM dbp_etl.bon_agg_kassierzeiten_1
          WHERE DATE(scan_ende) < DATE(bon_ende)
          UNION ALL
          SELECT
            mandant_id,
            wup_id,
            kassensystem_name,
            kasse_nr,
            kasse_typ_id,
            bon_dat,
            bon_beginn,
            PARSE_DATETIME(
              '%F %H:%M:%S', FORMAT_DATETIME('%F', bon_ende) || ' 00:00:00')
              AS scan_ende,
            bon_ende
          FROM dbp_etl.bon_agg_kassierzeiten_1
          WHERE DATE(scan_ende) < DATE(bon_ende)
        ) AS t7
    );

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

CREATE OR REPLACE TABLE dbp_etl._zeit_$_1{TRANSIENT_TABLE_SUFFIX}
AS
SELECT
  zeit_stunde,
  zeit_minute,
  CASE
    WHEN zeit_stunde < 10
      THEN '0' || TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 39))
    ELSE TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 39))
    END
    || ':'
    || CASE
      WHEN zeit_minute < 10
        THEN '0' || TRIM(SUBSTR(CAST(zeit_minute AS STRING), 1, 39))
      ELSE TRIM(SUBSTR(CAST(zeit_minute AS STRING), 1, 39))
      END
    || ':00' AS start_time,
  CASE
    WHEN zeit_stunde < 10
      THEN '0' || TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 39))
    ELSE TRIM(SUBSTR(CAST(zeit_stunde AS STRING), 1, 39))
    END || ':' || CASE
      WHEN zeit_minute = 0
        THEN '14:59'
      WHEN zeit_minute = 15
        THEN '29:59'
      WHEN zeit_minute = 30
        THEN '44:59'
      WHEN zeit_minute = 45
        THEN '59:59'
      ELSE NULL
      END AS end_time
FROM dbp_data.zeit_1;
