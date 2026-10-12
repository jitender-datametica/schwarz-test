CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_transportauftrag_abbruch (transport_beleg_id, mandant_id,
lagernummer_id, wup_id, nb_id, abbr_pos_id, dat_abbr, zeit_abbr, abbruch_dt, ebene_wechsel_fg) AS SELECT
 transport_beleg_id,
 mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 abbr_pos_id,
 dat_abbr,
 zeit_abbr,
 DATETIME(dat_abbr, CAST(TRIM(CAST(zeit_abbr AS STRING)) AS TIME)) AS abbruch_dt,
 ebene_wechsel_fg
FROM kfl_production_dbp_view.v_transportauftrag_abbruch;