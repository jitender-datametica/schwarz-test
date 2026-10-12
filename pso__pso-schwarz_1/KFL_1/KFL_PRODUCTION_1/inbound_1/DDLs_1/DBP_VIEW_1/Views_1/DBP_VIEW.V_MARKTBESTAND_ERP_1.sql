CREATE OR REPLACE VIEW DBP_VIEW.V_MARKTBESTAND_ERP_1 AS 
    SELECT 
        mandant_id
        ,art_id
        ,wup_id
        ,nb_id
        ,dat
        ,bestand_id
        ,bezugsweg_id
        ,relevant_fg
        ,menge_lgbest_erp_frei_bme
        ,menge_lgbest_erp_qual_bme
        ,menge_lgbest_erp_gesp_bme
        ,fortschreibung_fg
FROM DBP_DATA.marktbestand_erp_1 ;