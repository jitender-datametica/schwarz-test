CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_sort_klass_2 (mandant_id, klassifizierung_id) AS SELECT
 mandant_id,
 klassifizierung_id
FROM kfl_production_dbp_view.v_l_sort_klass_2;