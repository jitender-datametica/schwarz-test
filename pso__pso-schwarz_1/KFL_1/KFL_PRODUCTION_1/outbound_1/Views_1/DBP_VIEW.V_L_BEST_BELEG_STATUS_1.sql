CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_best_beleg_status_1 AS SELECT system_id,
 mandant_id,
 best_beleg_status_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_best_beleg_status_1;