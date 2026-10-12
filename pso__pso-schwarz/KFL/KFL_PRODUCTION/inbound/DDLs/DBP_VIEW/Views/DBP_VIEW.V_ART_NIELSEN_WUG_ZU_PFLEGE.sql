CREATE OR REPLACE VIEW DBP_VIEW.V_art_nielsen_wug_zu_pflege AS 
    SELECT 
        mandant_id,
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

FROM DBP_DATA.art_nielsen_wug_zu_pflege
;