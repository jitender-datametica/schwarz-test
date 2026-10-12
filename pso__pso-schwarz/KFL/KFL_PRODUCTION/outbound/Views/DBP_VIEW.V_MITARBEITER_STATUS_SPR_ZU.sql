CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mitarbeiter_status_spr_zu AS SELECT mandant_id,
 ma_status_id,
 spr_id,
 ma_status_bez
FROM kfl_production_dbp_data.mitarbeiter_status_spr_zu;