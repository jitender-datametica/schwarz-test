-- 2022-10-28, AP0133256,SPEC0166769,dknop, initial
 -- 2023-07-17, staeblern Umstellung auf Session Variable

-- 2022-11-24, AP0133256,SPEC0166769,dknop, updating logic, previous was giving duplications

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_tp_objekt_spr_zu_1(USERID STRING) AS
SELECT V01.tp_objekt_id,
 V01.mandant_id,
 V01.tp_objekt_bez
FROM kfl_production_dbp_view.v_tp_objekt_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_1 AS V03 ON V01.mandant_id = V03.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_log.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id
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
       END)) = 1
  /* v01.tp_objekt_id
,v01.mandant_id
,v01.tp_objekt_bez

FROM KFL_PRODUCTION.dbp_view.v_tp_objekt_spr_zu_1 v01

GROUP BY v01.tp_objekt_id,v01.mandant_id,v01.tp_objekt_bez */;