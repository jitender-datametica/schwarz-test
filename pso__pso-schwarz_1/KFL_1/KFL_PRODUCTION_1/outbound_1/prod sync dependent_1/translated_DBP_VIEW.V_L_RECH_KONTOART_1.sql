CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_rech_kontoart_1 (mandant_id, rech_kontoart_id, system_id) AS SELECT
 mandant_id,
 rech_kontoart_id,
 system_id
FROM kfl_production_dbp_data.l_rech_kontoart_1;