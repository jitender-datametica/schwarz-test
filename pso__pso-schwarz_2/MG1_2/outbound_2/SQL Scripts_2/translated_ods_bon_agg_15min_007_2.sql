--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ETL.ODS_BON_SIGN_ON_OFF_2;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS KFL_PRODUCTION_DBP_ETL.ODS_BON_SIGN_ON_OFF_2 (
BON_DAT DATE NOT NULL,
WUP_ID INTEGER NOT NULL,
MANDANT_ID BIGNUMERIC NOT NULL,
KASSENSYSTEM_NAME STRING,
KASSE_NR SMALLINT,
KASSE_TYP_ID BIGNUMERIC,
TRANSACTION_NAME STRING,
BON_ENDE DATETIME NOT NULL,
BON_NR INTEGER NOT NULL
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO KFL_PRODUCTION_DBP_ETL.ODS_BON_SIGN_ON_OFF_2 (BON_DAT, WUP_ID, MANDANT_ID, KASSENSYSTEM_NAME, KASSE_NR,
 KASSE_TYP_ID, TRANSACTION_NAME, BON_ENDE, BON_NR)
(SELECT BON_DAT,
  CAST(WUP_ID AS INTEGER) AS WUP_ID,
  MANDANT_ID,
  KASSENSYSTEM_NAME,
  CAST(KASSE_NR AS SMALLINT) AS KASSE_NR,
  KASSE_TYP_ID,
   CASE
   WHEN TRANSACTION_NAME = 'OperatorLock                  '
   THEN 'SignOffTransaction            '
   WHEN TRANSACTION_NAME = 'OperatorUnlock                '
   THEN 'SignOnTransaction             '
   WHEN TRANSACTION_NAME = 'PosLockTransaction            '
   THEN 'SignOffTransaction            '
   WHEN TRANSACTION_NAME = 'PosUnlockTransaction          '
   THEN 'SignOnTransaction             '
   ELSE TRANSACTION_NAME
   END AS TRANSACTION_NAME,
  BON_ENDE,
  CAST(BON_NR AS INTEGER) AS BON_NR
 FROM KFL_PRODUCTION_DBP_ODS.ODS_BON_TRANSACTION_2
 WHERE TRANSACTION_NAME IN ('SignOffTransaction            ', 'SignOnTransaction             ',
    'OperatorLock                  ', 'OperatorUnlock                ', 'PosUnlockTransaction          ',
    'PosLockTransaction            ')
  AND (MANDANT_ID, WUP_ID, KASSENSYSTEM_NAME, KASSE_NR, BON_DAT) IN (SELECT (MANDANT_ID, CAST(WUP_ID AS BIGNUMERIC),
      KASSENSYSTEM_NAME, CAST(KASSE_NR AS BIGNUMERIC), BON_DAT)
    FROM KFL_PRODUCTION_DBP_ETL.BON_AGG_KASSENBERICHTE_2)
  AND KASSENSYSTEM_NAME NOT IN ('KPOS'));


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO KFL_PRODUCTION_DBP_ETL.ODS_BON_SIGN_ON_OFF_2 (BON_DAT, WUP_ID, MANDANT_ID, KASSENSYSTEM_NAME, KASSE_NR,
 KASSE_TYP_ID, TRANSACTION_NAME, BON_ENDE, BON_NR)
(SELECT BON_DAT,
  CAST(WUP_ID AS INTEGER) AS WUP_ID,
  MANDANT_ID,
  KASSENSYSTEM_NAME,
  CAST(KASSE_NR AS SMALLINT) AS KASSE_NR,
  KASSE_TYP_ID,
   CASE
   WHEN TRANSACTION_NAME = 'OperatorLock                  '
   THEN 'SignOffTransaction            '
   WHEN TRANSACTION_NAME = 'OperatorUnlock                '
   THEN 'SignOnTransaction             '
   WHEN TRANSACTION_NAME = 'PosLockTransaction            '
   THEN 'SignOffTransaction            '
   WHEN TRANSACTION_NAME = 'PosUnlockTransaction          '
   THEN 'SignOnTransaction             '
   ELSE TRANSACTION_NAME
   END AS TRANSACTION_NAME_,
  BON_ENDE,
  ROW_NUMBER() OVER (PARTITION BY CAST(WUP_ID AS STRING), CAST(KASSE_NR AS STRING), BON_DAT ORDER BY WUP_ID IS NULL,
     WUP_ID, KASSE_NR IS NULL, KASSE_NR, BON_ENDE IS NULL, BON_ENDE, CASE
      WHEN TRANSACTION_NAME = 'OperatorLock                  '
      THEN 'SignOffTransaction            '
      WHEN TRANSACTION_NAME = 'OperatorUnlock                '
      THEN 'SignOnTransaction             '
      WHEN TRANSACTION_NAME = 'PosLockTransaction            '
      THEN 'SignOffTransaction            '
      WHEN TRANSACTION_NAME = 'PosUnlockTransaction          '
      THEN 'SignOnTransaction             '
      ELSE TRANSACTION_NAME
      END IS NULL DESC, CASE
      WHEN TRANSACTION_NAME = 'OperatorLock                  '
      THEN 'SignOffTransaction            '
      WHEN TRANSACTION_NAME = 'OperatorUnlock                '
      THEN 'SignOnTransaction             '
      WHEN TRANSACTION_NAME = 'PosLockTransaction            '
      THEN 'SignOffTransaction            '
      WHEN TRANSACTION_NAME = 'PosUnlockTransaction          '
      THEN 'SignOnTransaction             '
      ELSE TRANSACTION_NAME
      END DESC) AS BON_NR
 FROM KFL_PRODUCTION_DBP_ODS.ODS_BON_TRANSACTION_2
 WHERE TRANSACTION_NAME IN ('SignOffTransaction            ', 'SignOnTransaction             ',
    'OperatorLock                  ', 'OperatorUnlock                ', 'PosUnlockTransaction          ',
    'PosLockTransaction            ')
  AND (MANDANT_ID, WUP_ID, KASSENSYSTEM_NAME, KASSE_NR, BON_DAT) IN (SELECT (MANDANT_ID, CAST(WUP_ID AS BIGNUMERIC),
      KASSENSYSTEM_NAME, CAST(KASSE_NR AS BIGNUMERIC), BON_DAT)
    FROM KFL_PRODUCTION_DBP_ETL.BON_AGG_KASSENBERICHTE_2)
  AND KASSENSYSTEM_NAME IN ('KPOS'));


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ' ...)





CREATE OR REPLACE TABLE DEFAULTSCHEMA._fake_entries_$_2{TRANSIENT_TABLE_SUFFIX} AS
SELECT BON_DAT,
 WUP_ID,
 MANDANT_ID,
 KASSENSYSTEM_NAME,
 KASSE_NR,
 KASSE_TYP_ID,
 'SignOnTransaction             ' AS TRANSACTION_NAME,
 --   ,to_timestamp((to_date(bon_ende, 'yyyy-mm_2-dd') || ' 00:00:00')) AS bon_ende
 PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(DATE(BON_ENDE) AS STRING), 1, 20)) AS BON_ENDE,
  BON_NR - 1 AS BON_NR
FROM KFL_PRODUCTION_DBP_ETL.ODS_BON_SIGN_ON_OFF_2
WHERE (MANDANT_ID, WUP_ID, KASSENSYSTEM_NAME, KASSE_NR, BON_DAT, BON_NR) IN (SELECT (MANDANT_ID, WUP_ID,
     KASSENSYSTEM_NAME, KASSE_NR, BON_DAT, MIN(BON_NR))
   FROM KFL_PRODUCTION_DBP_ETL.ODS_BON_SIGN_ON_OFF_2
   GROUP BY MANDANT_ID,
    WUP_ID,
    KASSENSYSTEM_NAME,
    KASSE_NR,
    BON_DAT)
 AND TRANSACTION_NAME IN ('SignOffTransaction            ', 'OperatorLock                  ',
   'PosLockTransaction            ');


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table '...)


CREATE OR REPLACE TABLE DEFAULTSCHEMA._not_applicable_$_2{TRANSIENT_TABLE_SUFFIX} AS
SELECT DATE_ADD(A.BON_DAT, INTERVAL 1 DAY) AS BON_DAT,
 A.WUP_ID,
 A.MANDANT_ID,
 A.KASSENSYSTEM_NAME,
 A.KASSE_NR,
 A.KASSE_TYP_ID,
 A.TRANSACTION_NAME,
 A.BON_ENDE,
 A.BON_NR
FROM KFL_PRODUCTION_DBP_ETL.ODS_BON_SIGN_ON_OFF_2 AS A
 INNER JOIN (SELECT MANDANT_ID,
   WUP_ID,
   KASSENSYSTEM_NAME,
   KASSE_NR,
   BON_DAT,
   MAX(BON_NR) AS MIN_BON_NR
  FROM KFL_PRODUCTION_DBP_ETL.ODS_BON_SIGN_ON_OFF_2
  GROUP BY BON_DAT,
   WUP_ID,
   MANDANT_ID,
   KASSENSYSTEM_NAME,
   KASSE_NR) AS t0 ON A.MANDANT_ID = t0.MANDANT_ID AND A.WUP_ID = t0.WUP_ID AND A.KASSENSYSTEM_NAME = t0.KASSENSYSTEM_NAME
       AND A.KASSE_NR = t0.KASSE_NR AND A.BON_DAT = t0.BON_DAT AND A.BON_NR = t0.MIN_BON_NR
WHERE A.TRANSACTION_NAME = 'SignOffTransaction';


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


DELETE FROM DEFAULTSCHEMA._fake_entries_$_2{TRANSIENT_TABLE_SUFFIX}
WHERE (MANDANT_ID, WUP_ID, KASSENSYSTEM_NAME, KASSE_NR, BON_DAT) IN (SELECT (MANDANT_ID, WUP_ID, KASSENSYSTEM_NAME,
    KASSE_NR, BON_DAT)
  FROM DEFAULTSCHEMA._not_applicable_$_2{TRANSIENT_TABLE_SUFFIX});


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO KFL_PRODUCTION_DBP_ETL.ODS_BON_SIGN_ON_OFF_2 (BON_DAT, WUP_ID, MANDANT_ID, KASSENSYSTEM_NAME, KASSE_NR,
 KASSE_TYP_ID, TRANSACTION_NAME, BON_ENDE, BON_NR)
(SELECT *
 FROM DEFAULTSCHEMA._fake_entries_$_2{TRANSIENT_TABLE_SUFFIX});


DROP TABLE IF EXISTS DEFAULTSCHEMA._fake_entries_$_2{TRANSIENT_TABLE_SUFFIX};


DROP TABLE IF EXISTS DEFAULTSCHEMA._not_applicable_$_2{TRANSIENT_TABLE_SUFFIX};