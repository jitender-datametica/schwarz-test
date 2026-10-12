CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_mitarbeiter_statu_spr_zu_pl_2 (mandant_id, ma_status_id,
ma_status_bez) AS SELECT mandant_id,
 ma_status_id,
 ma_status_bez
FROM kfl_production_dbp_view.v_mitarbeiter_status_spr_zu_2 AS V01
WHERE spr_id = 90;