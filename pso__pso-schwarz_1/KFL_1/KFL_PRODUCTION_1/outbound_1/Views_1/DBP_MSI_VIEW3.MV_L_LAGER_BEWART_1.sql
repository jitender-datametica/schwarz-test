CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_lager_bewart_1 (lager_bewart_id, mandant_id, system_id) AS SELECT
 lager_bewart_id,
 mandant_id,
 system_id
FROM kfl_production_dbp_view.v_l_lager_bewart_1;