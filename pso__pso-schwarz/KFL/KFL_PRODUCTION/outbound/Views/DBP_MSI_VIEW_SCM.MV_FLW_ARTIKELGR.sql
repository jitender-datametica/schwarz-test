CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_flw_artikelgr AS SELECT mandant_id,
 art_id,
 art_gruppe_id,
 art_gruppe_bez,
 art_klasse_id,
 art_klasse_bez,
 art_rohstoff_id,
 art_rohstoff_bez
FROM kfl_production_dbp_view.v_art_art_gruppe_flw AS V0;