CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_lager_bewart_typ (lager_bewart_typ_id, mandant_id, hist_fg) AS
SELECT lager_bewart_typ_id,
 mandant_id,
 hist_fg
FROM kfl_production_dbp_view.v_l_lager_bewart_typ
WHERE hist_fg = 0;