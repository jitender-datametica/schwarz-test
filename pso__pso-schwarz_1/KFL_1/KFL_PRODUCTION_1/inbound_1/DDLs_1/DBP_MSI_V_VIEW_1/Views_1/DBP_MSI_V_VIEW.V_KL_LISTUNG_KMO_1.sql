CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_kl_listung_kmo_1 AS 
    SELECT 
        kl_listung_kmo_id 
        ,mandant_id 
        ,listung_art 
        ,art_id 
        ,wup_id 
        ,sm_id_selected 
        ,ksm_id_selected 
        ,sm_id 
        ,ksm_id 
        ,umsatz_hr 
        ,absatz_hr 
        ,rohertrag_hr 
        ,erweiterung_fg 
        ,reduktion_fg 
        ,kjwo_update 
        ,list_kz
FROM DBP_MSI_DATA.kl_listung_kmo_1 ;