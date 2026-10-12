CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_wbs_art_aktion_markt_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 aktion_id,
 angebot_id,
 dat_von,
 dat_bis,
 gk_fg,
 menge_mindestplatzierung_bme,
 top_gk_fg,
 fixmenge_wfl_bme
FROM kfl_production_dbp_data.ts_wbs_art_aktion_markt_1;