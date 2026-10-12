CREATE OR REPLACE VIEW DBP_VIEW.V_L_GP_TEILSORTIMENT_2 AS 
    SELECT 
        mandant_id,
        gp_id,
        gp_teilsortiment_id,
        einkaufsorganisation_id,
        zahlungsziel_id,
        zek_id
FROM DBP_DATA.L_GP_TEILSORTIMENT_2 ;