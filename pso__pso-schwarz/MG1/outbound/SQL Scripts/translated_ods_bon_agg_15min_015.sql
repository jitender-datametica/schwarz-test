--[OK] statement is translated correctly (syntax and type checks are fine)

DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ETL.ODS_BON_AGG_15MIN_SCANZEIT;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


CREATE TABLE IF NOT EXISTS KFL_PRODUCTION_DBP_ETL.ODS_BON_AGG_15MIN_SCANZEIT (
DAT DATE NOT NULL,
ZEIT_STUNDE BIGNUMERIC NOT NULL,
ZEIT_15MIN BIGNUMERIC NOT NULL,
MANDANT_ID BIGNUMERIC NOT NULL,
WUP_ID INTEGER NOT NULL,
KASSENSYSTEM_NAME STRING,
KASSE_NR SMALLINT NOT NULL,
KASSE_TYP_ID BIGNUMERIC NOT NULL,
SCANZEIT INTEGER NOT NULL
);


--[OK] statement is translated correctly-----------------------------------------------------------------





      
INSERT INTO KFL_PRODUCTION_DBP_ETL.ODS_BON_AGG_15MIN_SCANZEIT (DAT, ZEIT_STUNDE, ZEIT_15MIN, MANDANT_ID, WUP_ID, KASSENSYSTEM_NAME, KASSE_NR, KASSE_TYP_ID, SCANZEIT)
  SELECT
      DT1.BON_DAT,
      DT1.ZEIT_STUNDE,
      DT1.ZEIT_MINUTE,
      DT1.MANDANT_ID,
      DT1.WUP_ID,
      DT1.KASSENSYSTEM_NAME,
      DT1.KASSE_NR,
      DT1.KASSE_TYP_ID,
      -- ,Sum(
      -- Cast((
      -- (CASE WHEN zeit_scheibe_ende<=end_time THEN zeit_scheibe_ende ELSE end_time END-CASE WHEN zeit_scheibe_start>=start_time THEN zeit_scheibe_start ELSE start_time END) Second(4)) AS INTEGER)
      -- ) AS  scanzeit
      sum(ERROR_UNIMPLEMENTED( DT1.SECOND, CASE
        WHEN DT1.ZEIT_SCHEIBE_START >= DT1.START_TIME THEN DT1.ZEIT_SCHEIBE_START
        ELSE DT1.START_TIME
      END, CASE
        WHEN DT1.ZEIT_SCHEIBE_ENDE <= DT1.END_TIME THEN DT1.ZEIT_SCHEIBE_ENDE
        ELSE DT1.END_TIME
      END)) AS SCANZEIT
    FROM
      (
        SELECT
            T1.MANDANT_ID,
            T1.WUP_ID,
            T1.KASSENSYSTEM_NAME,
            T1.KASSE_NR,
            T1.KASSE_TYP_ID,
            T2.ZEIT_STUNDE,
            T2.ZEIT_MINUTE,
            CAST( T1.BON_BEGINN as DATE) AS BON_DAT,
            CAST(concat(format('YYYY-MM-% 3.0f', T1.BON_BEGINN), ' ', T2.START_TIME) as DATETIME) AS ZEIT_SCHEIBE_START,
            CAST(concat(format('YYYY-MM-% 3.0f', T1.SCAN_ENDE), ' ', T2.END_TIME) as DATETIME) + INTERVAL 1 SECOND AS ZEIT_SCHEIBE_ENDE,
            start_time AS START_TIME,
            end_time AS END_TIME
          FROM
            (
              SELECT
                  BON_AGG_KASSIERZEITEN.MANDANT_ID,
                  BON_AGG_KASSIERZEITEN.WUP_ID,
                  BON_AGG_KASSIERZEITEN.KASSENSYSTEM_NAME,
                  BON_AGG_KASSIERZEITEN.KASSE_NR,
                  BON_AGG_KASSIERZEITEN.KASSE_TYP_ID,
                  BON_AGG_KASSIERZEITEN.BON_DAT,
                  BON_AGG_KASSIERZEITEN.BON_BEGINN,
                  BON_AGG_KASSIERZEITEN.SCAN_ENDE,
                  BON_AGG_KASSIERZEITEN.BON_ENDE
                FROM
                  KFL_PRODUCTION_DBP_ETL.BON_AGG_KASSIERZEITEN
                WHERE CAST( BON_AGG_KASSIERZEITEN.BON_BEGINN as DATE) = CAST( BON_AGG_KASSIERZEITEN.SCAN_ENDE as DATE)
                 AND BON_AGG_KASSIERZEITEN.BON_BEGINN < BON_AGG_KASSIERZEITEN.SCAN_ENDE
            ) AS T1
            INNER JOIN _zeit_${TRANSIENT_TABLE_SUFFIX} AS T2 ON CAST(concat(format('YYYY-MM-% 3.0f', T1.SCAN_ENDE), ' ', T2.END_TIME) as DATETIME) + INTERVAL 1 SECOND >= T1.SCAN_ENDE
             AND CAST(concat(format('YYYY-MM-% 3.0f', T1.BON_BEGINN), ' ', T2.START_TIME) as DATETIME) <= T1.SCAN_ENDE
             OR CAST(concat(format('YYYY-MM-% 3.0f', T1.SCAN_ENDE), ' ', T2.END_TIME) as DATETIME) + INTERVAL 1 SECOND >= T1.BON_BEGINN
             AND CAST(concat(format('YYYY-MM-% 3.0f', T1.BON_BEGINN), ' ', T2.START_TIME) as DATETIME) <= T1.BON_BEGINN
            CROSS JOIN UNNEST(ARRAY[
              CAST(substr(CAST( T1.SCAN_ENDE as STRING), 1, 19) as DATETIME)
            ]) AS end_time
            CROSS JOIN UNNEST(ARRAY[
              CAST(substr(CAST( T1.BON_BEGINN as STRING), 1, 19) as DATETIME)
            ]) AS start_time
          WHERE start_time < end_time
      ) AS DT1
    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8
;
