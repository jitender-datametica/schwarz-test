CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_tarifart (mandant_id, tarifart_id) AS SELECT mandant_id,
 tarifart_id
FROM kfl_production_dbp_view.v_l_tarifart AS V01;