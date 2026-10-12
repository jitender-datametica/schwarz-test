CREATE OR REPLACE VIEW DBP_VIEW.V_MGG_GRUPPE_SPR_ZU_1 AS 
    SELECT 
        mandant_id,
        mgg_gruppe_id,
        spr_id,
        mgg_gruppe_bez
FROM DBP_DATA.MGG_GRUPPE_SPR_ZU_1 ;