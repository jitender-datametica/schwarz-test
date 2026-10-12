CREATE OR REPLACE VIEW DBP_VIEW.V_ART_NIELSEN_ART_WG_ZU_2 AS 
    SELECT 
        mandant_id,
        art_nielsen_id,
        art_id,
        kjwo,
        wg_id,
        wug_id,
        wg_quelle_bez,
        wg_quelle_hierarchie_lvl_id

FROM DBP_DATA.ART_NIELSEN_ART_WG_ZU_2 ;