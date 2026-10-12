CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_fakturaart_1 AS SELECT mandant_id,
 fakturaart_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_l_fakturaart_1;