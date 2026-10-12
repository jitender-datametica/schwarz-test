CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_wup_wetter_tag_1 (mandant_id, wup_id, nb_id, dat,
datzeit_letztes_update, temperatur_min, temperatur_max, sonne_aufgang, sonne_untergang, dauer_sonnenschein, mond_aufgang
, mond_untergang, daemmerung_start, daemmerung_ende, mondphase_id, windrichtung_id, windrichtung_schema_id,
windgeschwindigkeit_max) AS SELECT *
FROM kfl_production_dbp_view.v_wup_wetter_tag_1;