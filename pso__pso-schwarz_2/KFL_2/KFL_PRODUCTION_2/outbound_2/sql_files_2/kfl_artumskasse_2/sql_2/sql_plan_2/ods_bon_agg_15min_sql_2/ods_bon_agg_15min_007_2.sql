-- [OK] statement is translated correctly (syntax and type checks are fine)

DROP TABLE IF EXISTS dbp_etl.ods_bon_sign_on_off_2;

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
-- WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.

CREATE TABLE IF NOT EXISTS dbp_etl.ods_bon_sign_on_off_2(
  bon_dat DATE NOT NULL,
  wup_id INTEGER NOT NULL,
  mandant_id INTEGER NOT NULL,
  kassensystem_name STRING(10),
  kasse_nr INTEGER,
  kasse_typ_id INTEGER,
  transaction_name STRING(30) COLLATE 'und:ci',
  bon_ende DATETIME NOT NULL,
  bon_nr INTEGER NOT NULL);

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

INSERT INTO dbp_etl.ods_bon_sign_on_off_2
  (
    bon_dat,
    wup_id,
    mandant_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    transaction_name,
    bon_ende,
    bon_nr)
    (
      SELECT
        bon_dat,
        wup_id,
        mandant_id,
        kassensystem_name,
        kasse_nr,
        kasse_typ_id,
        CASE
          WHEN transaction_name = 'OperatorLock                  '
            THEN 'SignOffTransaction            '
          WHEN transaction_name = 'OperatorUnlock                '
            THEN 'SignOnTransaction             '
          WHEN transaction_name = 'PosLockTransaction            '
            THEN 'SignOffTransaction            '
          WHEN transaction_name = 'PosUnlockTransaction          '
            THEN 'SignOnTransaction             '
          ELSE transaction_name
          END AS transaction_name,
        bon_ende,
        bon_nr
      FROM dbp_ods.ods_bon_transaction_2
      WHERE
        transaction_name IN (
          'SignOffTransaction            ', 'SignOnTransaction             ',
          'OperatorLock                  ', 'OperatorUnlock                ',
          'PosUnlockTransaction          ', 'PosLockTransaction            ')
        AND (mandant_id, wup_id, kassensystem_name, kasse_nr, bon_dat)
          IN (
            SELECT (mandant_id, wup_id, kassensystem_name, kasse_nr, bon_dat)
            FROM dbp_etl.bon_agg_kassenberichte_2
          )
        AND kassensystem_name NOT IN ('KPOS')
    );

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

INSERT INTO dbp_etl.ods_bon_sign_on_off_2
  (
    bon_dat,
    wup_id,
    mandant_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    transaction_name,
    bon_ende,
    bon_nr)
    (
      SELECT
        bon_dat,
        wup_id,
        mandant_id,
        kassensystem_name,
        kasse_nr,
        kasse_typ_id,
        CASE
          WHEN transaction_name = 'OperatorLock                  '
            THEN 'SignOffTransaction            '
          WHEN transaction_name = 'OperatorUnlock                '
            THEN 'SignOnTransaction             '
          WHEN transaction_name = 'PosLockTransaction            '
            THEN 'SignOffTransaction            '
          WHEN transaction_name = 'PosUnlockTransaction          '
            THEN 'SignOnTransaction             '
          ELSE transaction_name
          END AS transaction_name_,
        bon_ende,
        ROW_NUMBER()
          OVER (
            PARTITION BY wup_id, kasse_nr, bon_dat
            ORDER BY
              wup_id IS NULL, wup_id, kasse_nr IS NULL, kasse_nr, bon_ende
              IS NULL, bon_ende, CASE
                WHEN transaction_name = 'OperatorLock                  '
                  THEN 'SignOffTransaction            '
                WHEN transaction_name = 'OperatorUnlock                '
                  THEN 'SignOnTransaction             '
                WHEN transaction_name = 'PosLockTransaction            '
                  THEN 'SignOffTransaction            '
                WHEN transaction_name = 'PosUnlockTransaction          '
                  THEN 'SignOnTransaction             '
                ELSE transaction_name
                END
              IS NULL DESC, CASE
                WHEN transaction_name = 'OperatorLock                  '
                  THEN 'SignOffTransaction            '
                WHEN transaction_name = 'OperatorUnlock                '
                  THEN 'SignOnTransaction             '
                WHEN transaction_name = 'PosLockTransaction            '
                  THEN 'SignOffTransaction            '
                WHEN transaction_name = 'PosUnlockTransaction          '
                  THEN 'SignOnTransaction             '
                ELSE transaction_name
                END DESC
          ) AS bon_nr
      FROM dbp_ods.ods_bon_transaction_2
      WHERE
        transaction_name IN (
          'SignOffTransaction            ', 'SignOnTransaction             ',
          'OperatorLock                  ', 'OperatorUnlock                ',
          'PosUnlockTransaction          ', 'PosLockTransaction            ')
        AND (mandant_id, wup_id, kassensystem_name, kasse_nr, bon_dat)
          IN (
            SELECT (mandant_id, wup_id, kassensystem_name, kasse_nr, bon_dat)
            FROM dbp_etl.bon_agg_kassenberichte_2
          )
        AND kassensystem_name IN ('KPOS')
    );

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
-- WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

CREATE OR REPLACE TABLE dbp_etl._fake_entries_$_2{TRANSIENT_TABLE_SUFFIX}
AS
-- ,to_timestamp((to_date(bon_ende, 'yyyy-mm_2-dd') || ' 00:00:00')) AS bon_ende
SELECT
  bon_dat,
  wup_id,
  mandant_id,
  kassensystem_name,
  kasse_nr,
  kasse_typ_id,
  'SignOnTransaction             ' AS transaction_name,
  PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(DATE(bon_ende) AS STRING), 1, 20))
    AS bon_ende,
  bon_nr - 1 AS bon_nr
FROM dbp_etl.ods_bon_sign_on_off_2
WHERE
  (mandant_id, wup_id, kassensystem_name, kasse_nr, bon_dat, bon_nr)
    IN (
      SELECT
        (mandant_id, wup_id, kassensystem_name, kasse_nr, bon_dat, MIN(bon_nr))
      FROM dbp_etl.ods_bon_sign_on_off_2
      GROUP BY
        mandant_id,
        wup_id,
        kassensystem_name,
        kasse_nr,
        bon_dat
    )
  AND transaction_name IN (
    'SignOffTransaction            ',
    'OperatorLock                  ',
    'PosLockTransaction            ');

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
-- WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)

CREATE OR REPLACE TABLE dbp_etl._not_applicable_$_2{TRANSIENT_TABLE_SUFFIX}
AS
SELECT
  DATE_ADD(A.bon_dat, INTERVAL 1 DAY) AS bon_dat,
  A.wup_id,
  A.mandant_id,
  A.kassensystem_name,
  A.kasse_nr,
  A.kasse_typ_id,
  A.transaction_name,
  A.bon_ende,
  A.bon_nr
FROM dbp_etl.ods_bon_sign_on_off_2 AS A
INNER JOIN
  (
    SELECT
      mandant_id,
      wup_id,
      kassensystem_name,
      kasse_nr,
      bon_dat,
      MAX(bon_nr) AS min_bon_nr
    FROM dbp_etl.ods_bon_sign_on_off_2
    GROUP BY
      bon_dat,
      wup_id,
      mandant_id,
      kassensystem_name,
      kasse_nr
  ) AS t0
  ON
    A.mandant_id = t0.mandant_id
    AND A.wup_id = t0.wup_id
    AND A.kassensystem_name = t0.kassensystem_name
    AND A.kasse_nr = t0.kasse_nr
    AND A.bon_dat = t0.bon_dat
    AND A.bon_nr = t0.min_bon_nr
WHERE A.transaction_name = 'SignOffTransaction';

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

DELETE FROM dbp_etl._fake_entries_$_2{TRANSIENT_TABLE_SUFFIX}
WHERE
  (mandant_id, wup_id, kassensystem_name, kasse_nr, bon_dat)
  IN (
    SELECT (mandant_id, wup_id, kassensystem_name, kasse_nr, bon_dat)
    FROM dbp_etl._not_applicable_$_2{TRANSIENT_TABLE_SUFFIX}
  );

-- [~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

INSERT INTO dbp_etl.ods_bon_sign_on_off_2
  (
    bon_dat,
    wup_id,
    mandant_id,
    kassensystem_name,
    kasse_nr,
    kasse_typ_id,
    transaction_name,
    bon_ende,
    bon_nr)
    (SELECT * FROM dbp_etl._fake_entries_$_2{TRANSIENT_TABLE_SUFFIX});

DROP TABLE IF EXISTS dbp_etl._fake_entries_$_2{TRANSIENT_TABLE_SUFFIX};

DROP TABLE IF EXISTS dbp_etl._not_applicable_$_2{TRANSIENT_TABLE_SUFFIX};
