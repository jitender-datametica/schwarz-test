CREATE OR REPLACE VIEW DBP_VIEW.V_L_LISTUNGSSTUFE_2 AS 
    SELECT 
        mandant_id,
        listungsstufe_kz,
        listungsstufe_bez
FROM DBP_DATA.L_LISTUNGSSTUFE_2 ;