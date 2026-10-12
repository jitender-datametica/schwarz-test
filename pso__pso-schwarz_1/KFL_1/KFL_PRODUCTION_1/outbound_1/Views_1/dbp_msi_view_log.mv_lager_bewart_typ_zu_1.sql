CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lager_bewart_typ_zu_1 (mandant_id, grund_id, lager_bewart_id,
hist_fg, lager_bewart_typ_id) AS SELECT mandant_id,
 grund_id,
 lager_bewart_id,
 hist_fg,
 lager_bewart_typ_id
FROM kfl_production_dbp_view.v_lager_bewart_typ_zu_1 AS V01
WHERE hist_fg = 0;