CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_besch_best_akte_zu AS SELECT bvv_akte_id,
 best_beleg_id,
 mandant_id,
 in_lief_id
FROM kfl_production_dbp_data.in_besch_best_akte_zu;