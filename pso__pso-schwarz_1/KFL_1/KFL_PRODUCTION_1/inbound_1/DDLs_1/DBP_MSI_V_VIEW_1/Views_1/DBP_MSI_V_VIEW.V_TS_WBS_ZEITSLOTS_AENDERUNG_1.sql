CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_WBS_ZEITSLOTS_AENDERUNG_1 AS 
    SELECT 
        mandant_id
        ,auslieferungsgruppe_id
        ,dat
        ,zeitslot_id


FROM DBP_MSI_DATA.ts_wbs_zeitslots_aenderung_1 ;