CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TUPEL_MAT_FORECAST_1 AS 
    SELECT 
        id
        ,mandant_id
        ,a500_kjwo_update
        ,matching_id
        ,a51_listung_sst_pflege
        ,a52_listung_k_sst_pflege
        ,a426_ost_basis_pflege
        ,a427_ost_gross_pflege
        ,a428_sued_ost_pflege
        ,a429_sued_west_pflege
        ,a430_west_pflege
        ,a431_nord_pflege
        ,a411_stk_rohertrag_pflege
        ,a412_umsatz_brutto_hochrechnung
        ,a413_absatz_hochrechnung
        ,a414_rohertrag_hochrechnung
        ,a415_kannibalisierungsfaktor
        ,a50_listungsaktion
        ,listing_proposal_pflege
        ,execution_timestamp


FROM DBP_MSI_DATA.tupel_mat_forecast_1 ;