CREATE OR REPLACE VIEW DBP_VIEW.V_FOOD_NONFOOD_KATEGORIE_SPR_ZU_1 AS 
    SELECT 
        mandant_id,
        food_nonfood_kategorie_id,
        spr_id,
        food_nonfood_kategorie_bez
FROM DBP_DATA.FOOD_NONFOOD_KATEGORIE_SPR_ZU_1 ;