CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_wetter_tag_stunde_2 (mandant_id, wup_id, nb_id, dat,
zeit_stunde, datzeit_letztes_update, temperatur, wetterzustand_id, windgeschwindigkeit, regenrisiko) AS SELECT V01.mandant_id
 ,
 WUP.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.dat,
 V01.zeit_stunde,
 V01.datzeit_letztes_update,
 V01.temperatur,
 V01.wetterzustand_id,
 V01.windgeschwindigkeit,
 V01.regenrisiko
FROM kfl_production_dbp_view.v_wup_wetter_tag_stunde_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;