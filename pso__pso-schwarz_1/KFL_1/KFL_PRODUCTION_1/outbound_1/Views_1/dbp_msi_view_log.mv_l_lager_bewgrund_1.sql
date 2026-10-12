CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lager_bewgrund_1 (grund_id, lager_bewart_id, mandant_id,
hist_fg, retourenart_id) AS SELECT grund_id,
 lager_bewart_id,
 mandant_id,
 hist_fg,
 retourenart_id
FROM kfl_production_dbp_view.v_l_lager_bewgrund_1 AS V01
WHERE hist_fg = 0;