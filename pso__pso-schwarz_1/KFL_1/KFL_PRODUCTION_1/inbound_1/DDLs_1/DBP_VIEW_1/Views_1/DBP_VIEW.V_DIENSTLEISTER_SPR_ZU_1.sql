CREATE OR REPLACE VIEW DBP_VIEW.V_DIENSTLEISTER_SPR_ZU_1 AS 
    SELECT 
        mandant_id,
        dienstleister_id,
        spr_id,
        dienstleister_bez
FROM DBP_DATA.DIENSTLEISTER_SPR_ZU_1 ;