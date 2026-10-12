CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_l_fakturaart_1 (fakturaart_id, mandant_id) AS SELECT
 fakturaart_id,
 mandant_id
FROM kfl_production_dbp_view.v_flw_l_fakturaart_1;