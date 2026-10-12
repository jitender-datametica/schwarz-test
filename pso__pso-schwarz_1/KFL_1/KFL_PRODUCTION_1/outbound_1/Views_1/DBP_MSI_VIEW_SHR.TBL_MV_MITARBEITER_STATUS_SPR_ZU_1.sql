CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.tbl_mv_mitarbeiter_status_spr_zu_1 (mandant_id, ma_status_id,
ma_status_bez, spr_id) AS SELECT mandant_id,
 ma_status_id,
 ma_status_bez,
 spr_id
FROM kfl_production_dbp_view.v_mitarbeiter_status_spr_zu_1 AS V01;