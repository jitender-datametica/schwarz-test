-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_griffzone_typ_spr_zu(USERID STRING) AS SELECT V01.mandant_id,
 V01.griffzone_typ_id,
 V01.spr_id,
 V01.griffzone_typ_bez
FROM kfl_production_dbp_view.v_griffzone_typ_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu(USERID) AS V02 ON V01.spr_id = V02.spr_id;