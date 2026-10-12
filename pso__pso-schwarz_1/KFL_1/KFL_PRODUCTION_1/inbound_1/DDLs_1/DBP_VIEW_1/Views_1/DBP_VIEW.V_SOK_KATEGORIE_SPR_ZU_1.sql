CREATE OR REPLACE VIEW DBP_VIEW.V_SOK_KATEGORIE_SPR_ZU_1 AS 
    SELECT 
        mandant_id,
        sok_kategorie_id,
        spr_id,
        sok_kategorie_bez
FROM DBP_DATA.SOK_KATEGORIE_SPR_ZU_1 ;