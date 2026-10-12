CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mandant_1 (mandant_id, mandant_bez, mandant_kbez,
mandant_sort_id) AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez,
 mandant_sort_id
FROM kfl_production_dbp_view.v_mandant_1;