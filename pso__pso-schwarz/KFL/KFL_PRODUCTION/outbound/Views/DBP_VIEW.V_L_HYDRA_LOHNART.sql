CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_hydra_lohnart AS SELECT mandant_id,
 lohnart_id,
 lohnart_bez
FROM kfl_production_dbp_data.l_hydra_lohnart;