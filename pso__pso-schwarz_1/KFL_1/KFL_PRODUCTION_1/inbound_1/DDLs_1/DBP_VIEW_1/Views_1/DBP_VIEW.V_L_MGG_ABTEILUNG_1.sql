CREATE OR REPLACE VIEW DBP_VIEW.V_L_MGG_ABTEILUNG_1 AS 
    SELECT 
        mandant_id,
        mgg_abteilung_id,
        food_nonfood_kategorie_id
FROM DBP_DATA.L_MGG_ABTEILUNG_1 ;