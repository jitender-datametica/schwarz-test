CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lager_bewgrund_hist_2 (mandant_id, grund_id, lager_bewart_id,
hist_fg, retourenart_id) AS SELECT mandant_id,
 grund_id,
 lager_bewart_id,
 hist_fg,
 retourenart_id
FROM kfl_production_dbp_view.v_l_lager_bewgrund_2 AS V01
WHERE hist_fg = 1;