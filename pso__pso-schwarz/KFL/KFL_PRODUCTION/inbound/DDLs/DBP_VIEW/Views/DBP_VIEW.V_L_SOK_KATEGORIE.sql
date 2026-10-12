CREATE OR REPLACE VIEW DBP_VIEW.V_L_SOK_KATEGORIE AS 
    SELECT 
        mandant_id,
        sok_kategorie_id,
        sok_fima_baustein_id
FROM DBP_DATA.L_SOK_KATEGORIE ;