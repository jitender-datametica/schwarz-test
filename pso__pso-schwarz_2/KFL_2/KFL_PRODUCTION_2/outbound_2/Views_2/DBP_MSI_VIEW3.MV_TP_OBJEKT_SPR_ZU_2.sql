-- 2020.11.04 [nwag2310] if no record in user language is available, display the text maintained in default language

-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_tp_objekt_spr_zu_2(USERID STRING) AS SELECT V01.mandant_id,
 V01.tp_objekt_id,
 V01.spr_id,
 V01.tp_objekt_bez
FROM kfl_production_dbp_view.v_tp_objekt_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_2 AS V03 ON V01.mandant_id = V03.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_2(USERID) AS V02 ON V01.spr_id = V02.spr_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.tp_objekt_id AS STRING) ORDER BY CASE
       WHEN V02.spr_id IS NOT NULL
       THEN 1
       WHEN V03.spr_id = V01.spr_id
       THEN 2
       ELSE 3
       END IS NULL, CASE
       WHEN V02.spr_id IS NOT NULL
       THEN 1
       WHEN V03.spr_id = V01.spr_id
       THEN 2
       ELSE 3
       END)) = 1;