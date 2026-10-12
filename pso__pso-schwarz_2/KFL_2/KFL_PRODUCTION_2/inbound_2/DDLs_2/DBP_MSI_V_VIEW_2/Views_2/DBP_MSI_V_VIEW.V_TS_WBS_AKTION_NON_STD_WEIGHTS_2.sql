CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_WBS_AKTION_NON_STD_WEIGHTS_2 AS 
    SELECT 
        mandant_id
        ,werbe_typ_id
        ,kjwo
        ,dat_quelle
        ,dat_ziel
        ,gewichtung_prz
        ,dat_von_orig
        ,dat_bis_orig


FROM DBP_MSI_DATA.ts_wbs_aktion_non_std_weights_2 ;