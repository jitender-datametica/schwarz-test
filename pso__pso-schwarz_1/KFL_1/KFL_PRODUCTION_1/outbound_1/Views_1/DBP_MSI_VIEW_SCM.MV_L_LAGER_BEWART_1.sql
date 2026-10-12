CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_lager_bewart_1 (mandant_id, lager_bewart_id) AS SELECT
 mandant_id,
 lager_bewart_id
FROM kfl_production_dbp_view.v_l_lager_bewart_1 AS V01
WHERE system_id NOT IN (2, 17, 28, 32, 48, 53);