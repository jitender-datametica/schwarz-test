CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_best_beleg_status (best_beleg_status_id, mandant_id,
system_id) AS SELECT best_beleg_status_id,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_best_beleg_status
WHERE mandant_id = 1;