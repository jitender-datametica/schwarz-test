CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lager_bewgrund_1 AS SELECT grund_id,
 lager_bewart_id,
 mandant_id,
 hist_fg,
 retourenart_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_lager_bewgrund_1;