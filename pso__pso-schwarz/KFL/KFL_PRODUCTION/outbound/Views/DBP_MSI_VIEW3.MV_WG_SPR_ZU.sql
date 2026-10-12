-- 20230717 staeblern Umstellung auf Session Variable
 -- 05.08.2018, AP0021792, mkub1811: OWG Umstellung

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_wg_spr_zu(USERID STRING) AS SELECT V01.wg_id,
 V01.spr_id,
 V01.arthiertyp_id,
 V01.mandant_id,
 V01.wg_bez,
 V01.wg_id_bez
FROM kfl_production_dbp_msi_view3.tbl_mv_wg_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu(USERID) AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.arthiertyp_id = 2
 AND V01.wg_id >= - 3 -- 17.07.10: Filterung der Korrektur- WG aus VIS/MIS;;;