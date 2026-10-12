CREATE OR REPLACE VIEW DBP_VIEW.V_TS_BELOS_ADRESSE_WUP_ZU_1 AS 
    SELECT 
        mandant_id
        ,belos_adresse_id
        ,wup_id
        ,nb_id


FROM DBP_DATA.ts_belos_adresse_wup_zu_1 ;