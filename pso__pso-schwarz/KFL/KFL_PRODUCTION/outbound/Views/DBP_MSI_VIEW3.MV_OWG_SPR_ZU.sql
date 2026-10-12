-- 20230717 staeblern Umstellung auf Session Variable
 CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_owg_spr_zu(USERID STRING) AS SELECT V01.owg_id,
 V01.owg_bez,
 V01.owg_id_bez,
 V01.mandant_id,
 V01.arthiertyp_id,
 V01.spr_id
FROM kfl_production_dbp_msi_view3.tbl_mv_owg_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu(USERID) AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.arthiertyp_id = 2;