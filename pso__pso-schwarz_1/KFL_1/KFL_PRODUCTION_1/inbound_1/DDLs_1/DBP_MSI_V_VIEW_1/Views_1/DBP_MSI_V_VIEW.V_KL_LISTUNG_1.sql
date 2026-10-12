CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_kl_listung_1 AS 
    SELECT 
        kl_listung_id
        ,mandant_id
        ,listung_art
        ,art_id
        ,wup_id
        ,sm_id_selected
        ,sm_id
        ,ost_basis
        ,ost_gross
        ,sued_ost
        ,sued_west
        ,west
        ,nord
        ,umsatz_hr
        ,absatz_hr
        ,rohertrag_hr
        ,kjwo_update
        ,erweiterung_fg
        ,reduktion_fg
        ,list_kz
FROM DBP_MSI_DATA.kl_listung_1 ;