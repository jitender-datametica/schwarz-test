CREATE OR REPLACE VIEW DBP_VIEW.V_AV_HERKUNFT_SPR_ZU_1 AS 
    SELECT 
        mandant_id
        ,spr_id
        ,av_herkunft_id
        ,av_herkunft_bez


FROM DBP_DATA.av_herkunft_spr_zu_1 ;