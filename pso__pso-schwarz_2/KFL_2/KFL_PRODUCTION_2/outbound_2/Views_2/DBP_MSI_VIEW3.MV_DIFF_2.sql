CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_diff_2 (mandant_id, diff_id) AS SELECT mandant_id,
 diff_id
FROM kfl_production_dbp_view.v_l_kz_differenz_2;