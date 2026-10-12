CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_transportauftrag_abbruch (transport_beleg_id,
mandant_id, lagernummer_id, wup_id, nb_id, abbr_pos_id, dat_abbr, zeit_abbr, abbruch_dt, ebene_wechsel_fg) AS SELECT
 transport_beleg_id,
 mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 abbr_pos_id,
 dat_abbr,
 zeit_abbr -- , TO_TIME(TO_VARCHAR(COALESCE(zeit_abbr,'00:00:00'))) AS zeit_abbr

 -- , (CAST(CAST(dat_abbr AS STRING(11) )||COALESCE(CAST(zeit_abbr AS STRING(8) ),'00:00:00') AS timestamp_ntz(9))) AS abbruch_dt

 ,
 DATETIME(dat_abbr, CAST(TRIM(CAST(zeit_abbr AS STRING)) AS TIME)) AS abbruch_dt,
 ebene_wechsel_fg
FROM kfl_production_dbp_view.v_transportauftrag_abbruch;