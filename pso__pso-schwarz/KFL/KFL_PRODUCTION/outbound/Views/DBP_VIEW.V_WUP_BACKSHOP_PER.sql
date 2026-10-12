CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_backshop_per AS SELECT wup_id,
 nb_id,
 mandant_id,
 ofen_typ_id,
 dat_von,
 dat_bis,
 anz_ofen,
 gp_backen_bez
FROM kfl_production_dbp_data.wup_backshop_per;