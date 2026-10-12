CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_nielsen_wug_zu_pflege_1 AS SELECT mandant_id,
 art_nielsen_id,
 art_nielsen_bez,
 fb_pflege_wg_id,
 fb_pflege_wug_id,
 nielsen_abteilung_bez,
 nielsen_wg_bez,
 nielsen_uwg1_bez,
 nielsen_uwg2_bez,
 kalk_vorschl_wg_id,
 kalk_vorschl_wug_id,
 datzeit_letzte_eintragung_fb_pflege
FROM kfl_production_dbp_data.art_nielsen_wug_zu_pflege_1;