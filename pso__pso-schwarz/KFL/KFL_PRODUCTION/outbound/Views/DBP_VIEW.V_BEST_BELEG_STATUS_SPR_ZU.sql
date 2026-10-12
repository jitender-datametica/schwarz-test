CREATE OR REPLACE VIEW kfl_production_dbp_view.v_best_beleg_status_spr_zu AS SELECT system_id,
 mandant_id,
 best_beleg_status_id,
 spr_id,
 best_beleg_status_bez
FROM kfl_production_dbp_data.best_beleg_status_spr_zu;