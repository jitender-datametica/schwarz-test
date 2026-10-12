CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_lager_bewgrund_2 (mandant_id, system_id, grund_id,
lager_bewart_id, retourenart_id) AS SELECT mandant_id,
 7 AS system_id,
 grund_id,
 lager_bewart_id,
 retourenart_id
FROM kfl_production_dbp_view.v_l_lager_bewgrund_2
WHERE mandant_id = 1;