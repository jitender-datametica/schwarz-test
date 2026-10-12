CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_l_lagerort_2 (mandant_id, werk_id, lagerort_id) AS SELECT
 mandant_id,
 werk_id,
 lagerort_id
FROM kfl_production_dbp_view.v_flw_l_lagerort_2;