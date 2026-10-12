CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_WBS_RUNDUNGSPROFILE_1 AS 
    SELECT 
        mandant_id,
        rundungsprofil_id,
        wbs_relevant_fg,
        aufrundung_ab_prozent,
        abrundung_bis_prozent,
        rundung_ziel_einh_id

FROM DBP_MSI_DATA.TS_WBS_RUNDUNGSPROFILE_1 ;