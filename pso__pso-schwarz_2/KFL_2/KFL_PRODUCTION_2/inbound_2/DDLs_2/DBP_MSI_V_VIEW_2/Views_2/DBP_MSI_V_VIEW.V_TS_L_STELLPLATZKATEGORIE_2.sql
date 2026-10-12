CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_L_STELLPLATZKATEGORIE_2 AS 
    SELECT 
        sammel_ladung_fg
        ,anz_stellplatz_von
        ,anz_stellplatz_bis
        ,stellplatzkategorie


FROM DBP_MSI_DATA.ts_l_stellplatzkategorie_2 ;