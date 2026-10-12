CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_wetter_tag_stunde_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 zeit_stunde,
 datzeit_letztes_update,
 temperatur,
 wetterzustand_id,
 windgeschwindigkeit,
 regenrisiko
FROM kfl_production_dbp_data.wup_wetter_tag_stunde_2;