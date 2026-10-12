CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_PERSONALTEILBEREICH_WUP_ZU_2 AS 
    SELECT 
        mandant_id
        ,personalteilbereich_id
        ,wup_id
        ,nb_id


FROM DBP_MSI_DATA.ts_personalteilbereich_wup_zu_2 ;