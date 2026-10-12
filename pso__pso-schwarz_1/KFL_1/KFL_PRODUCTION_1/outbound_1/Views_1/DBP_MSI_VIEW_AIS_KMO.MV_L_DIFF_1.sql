CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_diff_1 (mandant_id, diff_id) AS SELECT mandant_id,
 diff_id
FROM kfl_production_dbp_view.v_l_kz_differenz_1
WHERE mandant_id <> 1;