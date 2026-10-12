CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_nl_listung_kmo AS 
    SELECT 
        nl_listung_kmo_id 
        ,mandant_id 
        ,listung_art 
        ,sm_id_selected 
        ,ksm_id_selected 
        ,sm_id 
        ,ksm_id 
        ,gtin 
        ,ost_basis 
        ,ost_gross 
        ,sued_ost 
        ,sued_west 
        ,west 
        ,nord 
        ,kl_owg_id 
        ,wg_id 
        ,art_nielsen_bez 
        ,umsatz_artikel 
        ,durchschnitt_anz_maerkte 
        ,durchschnitt_preis 
        ,anz_wochen 
        ,anz_maerkte 
        ,umsatz_hr 
        ,absatz_hr 
        ,kjwo_update
FROM DBP_MSI_DATA.nl_listung_kmo;