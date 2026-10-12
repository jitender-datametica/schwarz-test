CREATE OR REPLACE VIEW DBP_VIEW.V_L_SOK_ABTEILUNG AS 
    SELECT 
        mandant_id,
        sok_abteilung_id,
        food_nonfood_kategorie_id
FROM DBP_DATA.L_SOK_ABTEILUNG ;