CREATE OR REPLACE VIEW DBP_VIEW.V_MARKTBESTAND_ERP_ZU_1 AS 
    SELECT 
        mandant_id
        ,bestand_id
        ,ek_netto
        ,ek_netto_bnk
        ,vk_netto
        ,wrg_id
        ,ek_nettonetto
        ,einstandspreis


FROM DBP_DATA.marktbestand_erp_zu_1 ;