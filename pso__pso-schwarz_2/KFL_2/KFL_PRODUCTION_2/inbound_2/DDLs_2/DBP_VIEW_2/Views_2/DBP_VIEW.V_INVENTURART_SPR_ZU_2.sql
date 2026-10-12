CREATE OR REPLACE VIEW DBP_VIEW.V_INVENTURART_SPR_ZU_2 AS 
    SELECT 
        mandant_id,
        spr_id,
        inventurart_id,
        inventurart_bez
FROM DBP_DATA.INVENTURART_SPR_ZU_2 ;