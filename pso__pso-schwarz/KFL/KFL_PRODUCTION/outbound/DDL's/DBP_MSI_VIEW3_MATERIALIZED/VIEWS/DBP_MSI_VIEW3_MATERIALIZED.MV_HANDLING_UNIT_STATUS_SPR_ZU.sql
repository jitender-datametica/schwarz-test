-- 06.07.2017, AP0006317 - srom0404, kein deutscher Text für Ausland in SAP Tabelle

-- 20230717 staeblern Umstellung auf Session Variable

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_handling_unit_status_spr_zu(USERID STRING) AS SELECT T2.mandant_id,
 T2.hu_status_id,
 T2.hu_status_bez,
 T2.spr_id
FROM kfl_production_dbp_msi_view3_materialized.tbl_mv_handling_unit_status_spr_zu AS T2
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu(USERID) AS V04 ON T2.spr_id = V04.spr_id;