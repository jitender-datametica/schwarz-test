CREATE OR REPLACE VIEW DBP_VIEW.V_L_EIGENMARKE_HFM_KZ AS 
    SELECT 
        mandant_id
        ,eigenmarke_id
        ,hfm_markengruppe_kz
FROM DBP_DATA.L_EIGENMARKE_HFM_KZ ;