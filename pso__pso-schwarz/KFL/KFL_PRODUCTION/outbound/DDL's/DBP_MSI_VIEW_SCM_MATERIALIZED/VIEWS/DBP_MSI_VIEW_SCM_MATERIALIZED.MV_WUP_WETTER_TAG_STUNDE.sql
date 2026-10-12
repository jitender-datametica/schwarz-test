CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_wup_wetter_tag_stunde (mandant_id, wup_id, nb_id
, dat, zeit_stunde, datzeit_letztes_update, temperatur, wetterzustand_id, windgeschwindigkeit, regenrisiko) AS SELECT *
FROM kfl_production_dbp_view.v_wup_wetter_tag_stunde;