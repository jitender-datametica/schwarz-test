CREATE OR REPLACE VIEW DBP_VIEW.V_SOK_FIMA_BAUSTEIN_SPR_ZU_1 AS 
    SELECT 
        mandant_id,
        sok_fima_baustein_id,
        spr_id,
        sok_fima_baustein_bez
FROM DBP_DATA.SOK_FIMA_BAUSTEIN_SPR_ZU_1 ;