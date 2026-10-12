CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_gp_fehlerart_2 (system_id, mandant_id, gp_fehlerart_id) AS SELECT
 system_id,
 mandant_id,
 gp_fehlerart_id
FROM kfl_production_dbp_data.l_gp_fehlerart_2;