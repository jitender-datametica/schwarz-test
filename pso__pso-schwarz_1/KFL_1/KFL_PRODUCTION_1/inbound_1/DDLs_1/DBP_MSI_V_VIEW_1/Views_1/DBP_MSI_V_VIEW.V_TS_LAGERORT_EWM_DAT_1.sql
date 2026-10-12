CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_LAGERORT_EWM_DAT_1 AS 
    SELECT 
        mandant_id
        ,lagerort_id
        ,lagernummer_id
        ,wup_id
        ,nb_id
        ,dat


FROM DBP_MSI_DATA.ts_lagerort_ewm_dat_1 ;