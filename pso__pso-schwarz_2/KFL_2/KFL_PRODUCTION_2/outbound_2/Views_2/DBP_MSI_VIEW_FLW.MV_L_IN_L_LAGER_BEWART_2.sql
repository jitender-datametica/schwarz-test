CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_l_lager_bewart_2 (lager_bewart_id, mandant_id) AS SELECT
 lager_bewart_id,
 mandant_id
FROM kfl_production_dbp_view.v_flw_l_lager_bewart_2 AS V01;