--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.mis_q_kunden_abw_avg  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL,
      dat DATE NOT NULL,
      Bonanzahl Decimal(18,2),
      Bonanzahl_AVG Decimal(18,2),
      Abweichung_prz Decimal(6,2))
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.mis_q_kunden_abw_avg
(
  mandant_id
  ,wup_id
  ,nb_id
  ,dat
  ,Bonanzahl
  ,Bonanzahl_AVG
  ,Abweichung_prz
)
SELECT 
  mandant_id
  ,wup_id
  ,nb_id
  ,dat
  ,Bonanzahl
  ,CASE 
    WHEN
      ( Bonanzahl_AVG_SUM = 0 or KundenAvg_fg_SUM = 0 )
    THEN
      NULL
    ELSE
      Bonanzahl_AVG_SUM/KundenAvg_fg_SUM
  END AS Bonanzahl_AVG
  ,CASE
  WHEN
    ( Bonanzahl_AVG IS NULL or Bonanzahl_AVG = 0 )
  THEN
    NULL
  ELSE
    ((Bonanzahl-Bonanzahl_AVG) /Bonanzahl_AVG)
  END AS Abweichung_prz
FROM
  (
  SELECT
    mandant_id
    ,wup_id
    ,nb_id
    ,dat
    ,SUM(Bonanzahl*Kunden_fg) Bonanzahl
    ,SUM(Bonanzahl*KundenAvg_fg) Bonanzahl_AVG_SUM
    ,SUM(KundenAvg_fg) as  KundenAvg_fg_SUM
  FROM
    DBP_ETL.mis_q_kunden
  GROUP BY
    mandant_id
    ,wup_id
    ,nb_id
    ,dat
  )dt1
WHERE
  Abweichung_prz NOT BETWEEN -0.5 AND 0.5
;

