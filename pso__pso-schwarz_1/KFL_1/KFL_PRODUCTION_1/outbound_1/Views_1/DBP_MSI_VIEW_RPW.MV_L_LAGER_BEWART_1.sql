CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_lager_bewart_1 (mandant_id, lager_bewart_id, system_id) AS
SELECT mandant_id,
 lager_bewart_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_lager_bewart_1
WHERE mandant_id = 1;