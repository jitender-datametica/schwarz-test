CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lager_bewgrund_spr_zu_2 (grund_id, spr_id, lager_bewart_id, mandant_id,
hist_fg, grund_bez, td_update, td_insert) AS SELECT grund_id,
 spr_id,
 lager_bewart_id,
 mandant_id,
 hist_fg,
 grund_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lager_bewgrund_spr_zu_2;