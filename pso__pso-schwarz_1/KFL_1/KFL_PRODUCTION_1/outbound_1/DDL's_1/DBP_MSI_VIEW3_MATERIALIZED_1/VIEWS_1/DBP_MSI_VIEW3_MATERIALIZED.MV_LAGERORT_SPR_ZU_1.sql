-- AP0014173, Join auf user_spr_zu_1 hat es seit 2011 nur in Produktion gegeben, hier nachgezogen

-- AP0016637, srom0404, TRIM in lagerort_bez eingefügt

-- AP0013450, 10.07.2017, srom0404, Erweiterung um Anbindung Pflegetabelle für alternative Texte

-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_lagerort_spr_zu_1(USERID STRING) AS -- t1_1
 -- t2
 SELECT t1.mandant_id
 ,
 t1.lagerort_id,
 t1.wup_id,
 t1.nb_id,
 t1.spr_id -- lt. AP, soll der alternative Text genommen weerden, wenn dort einer vorhanden ist
,
   TRIM(SUBSTR(CAST(t1.wup_id AS STRING), 1, 39)) || ' ' || COALESCE(t2.lagerort_bez, t1.lagerort_bez) AS lagerort_bez,
 COALESCE(t2.lagerort_bez, t1.lagerort_bez) AS lagerort_bez_short,
 t1.lagerort_bez AS lagerort_bez_sap,
  CASE
  WHEN LENGTH(TRIM(t2.lagerort_bez)) = 0
  THEN '_BLANK'
  ELSE t2.lagerort_bez
  END AS lagerort_bez_altn
FROM (SELECT V01.mandant_id,
   V01.lagerort_id,
   V01.wup_id,
   V01.nb_id,
   V01.spr_id,
   V01.lagerort_bez
  FROM kfl_production_dbp_view.v_lagerort_spr_zu_1 AS V01
   INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id
  WHERE V01.lagerort_id NOT IN ('-1', '-2', '-3')) AS t1_1
 LEFT JOIN (SELECT V04.mandant_id,
   V04.lagerort_id,
   V04.wup_id,
   V04.nb_id,
   V04.spr_id,
   V04.lagerort_bez
  FROM kfl_production_dbp_msi_view3_materialized.ts_lagerort_altn_spr_zu_1 AS V04
   INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_1(USERID) AS V05 ON V04.spr_id = V05.spr_id) AS t2 ON t1.mandant_id
      = t2.mandant_id AND t1.wup_id = t2.wup_id AND t1.nb_id = t2.nb_id AND t1.lagerort_id = t2.lagerort_id;