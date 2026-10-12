CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_handling_unit_status_2 (mandant_id, hu_status_id) AS SELECT
 mandant_id,
 hu_status_id
FROM kfl_production_dbp_view.v_l_handling_unit_status_2;