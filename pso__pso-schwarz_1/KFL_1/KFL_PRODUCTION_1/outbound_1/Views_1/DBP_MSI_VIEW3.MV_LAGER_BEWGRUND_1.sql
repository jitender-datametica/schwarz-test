CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_lager_bewgrund_1 (grund_id, lager_bewart_id, mandant_id) AS SELECT
 grund_id,
 lager_bewart_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_lager_bewgrund_1;