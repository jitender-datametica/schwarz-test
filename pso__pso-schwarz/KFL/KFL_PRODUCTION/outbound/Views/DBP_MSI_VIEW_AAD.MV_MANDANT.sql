CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_mandant AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez,
 mandant_sort_id
FROM kfl_production_dbp_view.v_mandant;