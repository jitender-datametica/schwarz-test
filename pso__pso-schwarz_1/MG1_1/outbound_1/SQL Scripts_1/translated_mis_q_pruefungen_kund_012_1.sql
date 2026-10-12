--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.



CREATE TABLE IF NOT EXISTS KFL_PRODUCTION_DBP_ETL.MIS_Q_KUNDEN_ABW_AVG_1 (
MANDANT_ID BIGNUMERIC NOT NULL,
WUP_ID INTEGER NOT NULL,
NB_ID SMALLINT NOT NULL,
DAT DATE NOT NULL,
BONANZAHL NUMERIC(18,2),
BONANZAHL_AVG NUMERIC(18,2),
ABWEICHUNG_PRZ NUMERIC(6,2)
);


--[OK] statement is translated correctly (syntax and type checks are fine)

INSERT INTO KFL_PRODUCTION_DBP_ETL.MIS_Q_KUNDEN_ABW_AVG_1 (MANDANT_ID, WUP_ID, NB_ID, DAT, BONANZAHL, BONANZAHL_AVG, ABWEICHUNG_PRZ)
  SELECT
      DT1.MANDANT_ID,
      DT1.WUP_ID,
      DT1.NB_ID,
      DT1.DAT,
      DT1.BONANZAHL,
      bonanzahl_avg AS BONANZAHL_AVG,
      abweichung_prz AS ABWEICHUNG_PRZ
    FROM
      (
        SELECT
            MANDANT_ID,
            cast(WUP_ID as int64) as WUP_ID,
            cast(NB_ID as int64) as NB_ID,
            DAT,
            cast(sum(BONANZAHL * KUNDEN_FG) as int64) AS BONANZAHL,
            cast(sum(BONANZAHL * KUNDENAVG_FG)as numeric) AS BONANZAHL_AVG_SUM,
            cast(sum(KUNDENAVG_FG) as int64) AS KUNDENAVG_FG_SUM
          FROM
            KFL_PRODUCTION_DBP_ETL.MIS_Q_KUNDEN_1
          GROUP BY 1, 2, 3, 4
      ) AS DT1
      CROSS JOIN UNNEST(ARRAY[
        CASE
          WHEN DT1.BONANZAHL_AVG_SUM = NUMERIC '0'
           OR DT1.KUNDENAVG_FG_SUM = NUMERIC '0' THEN NULL
          ELSE DT1.BONANZAHL_AVG_SUM / DT1.KUNDENAVG_FG_SUM
        END
      ]) AS bonanzahl_avg
      CROSS JOIN UNNEST(ARRAY[
        CASE
          WHEN bonanzahl_avg IS NULL
           OR bonanzahl_avg = NUMERIC '0' THEN NULL
          ELSE (DT1.BONANZAHL - bonanzahl_avg) / bonanzahl_avg
        END
      ]) AS abweichung_prz
    WHERE NOT abweichung_prz BETWEEN -NUMERIC '0.5' AND NUMERIC '0.5'
;
