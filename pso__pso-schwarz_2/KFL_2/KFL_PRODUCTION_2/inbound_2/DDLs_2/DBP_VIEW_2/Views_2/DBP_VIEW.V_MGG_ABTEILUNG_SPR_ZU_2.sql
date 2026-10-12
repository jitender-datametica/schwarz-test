CREATE OR REPLACE VIEW DBP_VIEW.V_MGG_ABTEILUNG_SPR_ZU_2 AS 
    SELECT 
        mandant_id,
        mgg_abteilung_id,
        spr_id,
        mgg_abteilung_bez
FROM DBP_DATA.MGG_ABTEILUNG_SPR_ZU_2 ;