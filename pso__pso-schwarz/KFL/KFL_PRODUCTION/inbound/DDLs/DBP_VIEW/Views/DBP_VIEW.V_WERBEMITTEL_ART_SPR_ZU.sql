CREATE OR REPLACE VIEW DBP_VIEW.V_WERBEMITTEL_ART_SPR_ZU AS 
    SELECT 
        spr_id
        ,werbemittel_art_id
        ,werbemittel_art_bez


FROM DBP_DATA.werbemittel_art_spr_zu ;