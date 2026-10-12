CREATE OR REPLACE VIEW DBP_VIEW.V_IN_LAGERBESTAND_PER_1 AS 
    SELECT 
        mandant_id
        ,in_art_id
        ,werk_id
        ,in_lagerort_id
        ,dat_von
        ,dat_bis
        ,menge_lgbest_frei_bme
        ,menge_lgbest_umlag_bme
        ,menge_lgbest_qual_bme
        ,menge_lgbest_nf_charge_bme
        ,menge_lgbest_gesp_bme
        ,menge_lgbest_ret_gesp_bme


FROM DBP_DATA.in_lagerbestand_per_1 ;