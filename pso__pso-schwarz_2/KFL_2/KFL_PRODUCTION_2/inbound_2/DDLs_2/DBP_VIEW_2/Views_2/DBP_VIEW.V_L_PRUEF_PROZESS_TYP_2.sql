CREATE OR REPLACE VIEW DBP_VIEW.V_L_PRUEF_PROZESS_TYP_2 AS 
    SELECT 
        mandant_id,
        pruef_prozess_typ_kz,
        pruef_prozess_typ_bez
FROM DBP_DATA.L_PRUEF_PROZESS_TYP_2 ;