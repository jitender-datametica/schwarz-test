CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_lager_bewart_2 AS SELECT mandant_id,
 lager_bewart_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_l_lager_bewart_2;