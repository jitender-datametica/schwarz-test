-- 20230717 staeblern Umstellung auf Session Variable
 CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_wug_spr_zu(USERID STRING) AS SELECT V01.mandant_id,
 V01.wug_id,
 V01.arthiertyp_id,
 V01.wg_id,
 V01.spr_id,
 V01.wug_bez,
 SUBSTR(CAST(SUBSTR(CAST(V01.wug_id AS STRING), 1, 10) || ' ' || V01.wug_bez AS STRING), 1, 50) AS wug_id_bez
FROM kfl_production_dbp_view.v_wug_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu(USERID) AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.arthiertyp_id = 2;