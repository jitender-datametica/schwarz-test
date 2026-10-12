CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lager_bewart_typ (mandant_id, lager_bewart_typ_id, hist_fg)
AS SELECT mandant_id,
 lager_bewart_typ_id,
 hist_fg
FROM kfl_production_dbp_view.v_l_lager_bewart_typ
WHERE hist_fg = 0;