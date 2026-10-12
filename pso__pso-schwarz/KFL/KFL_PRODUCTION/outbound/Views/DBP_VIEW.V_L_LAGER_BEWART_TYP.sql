CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lager_bewart_typ AS SELECT lager_bewart_typ_id,
 mandant_id,
 hist_fg
FROM kfl_production_dbp_data.l_lager_bewart_typ;