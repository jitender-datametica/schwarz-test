CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WBS_CUSTOMIZING_L_MANDANT_ZEITSLOTS_1 AS -- vorher dbp_msi_view_scm.MV_wbs_processboard_l_slots
-- Zeitslost fuer das Processboard !!! 
SELECT 
    MANDANT_ID, 
    ZEITSLOT_ID,
    ZEITSLOT_BEZ 
FROM DBP_VIEW.V_WBS_L_MANDANT_ZEITSLOTS_1 ;