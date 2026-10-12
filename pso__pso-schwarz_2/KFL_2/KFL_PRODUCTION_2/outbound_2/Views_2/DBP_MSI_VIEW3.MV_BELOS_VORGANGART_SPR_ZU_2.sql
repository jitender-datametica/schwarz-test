-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_belos_vorgangart_spr_zu_2(USERID STRING) AS SELECT V01.belos_vorgangart_bez,
 V01.belos_vorgangart_id,
 V01.belos_vorgangart_kbez,
 V01.mandant_id,
 V01.spr_id
FROM kfl_production_dbp_view.v_belos_vorgangart_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_2(USERID) AS V02 ON V01.spr_id = V02.spr_id;