CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr_materialized.mv_mitarbeiter_status_spr_zu_1 (mandant_id,
ma_status_id, ma_status_bez) AS SELECT V01.mandant_id,
 V01.ma_status_id,
 V01.ma_status_bez
FROM kfl_production_dbp_msi_view_shr_materialized.tbl_mv_mitarbeiter_status_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id;