-- vorher DBP_MSI_VIEW_SCM_MATERIALIZED.MV_wbs_processboard_l_slots
 -- Zeitslost fuer das Processboard !!!

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_wbs_customizing_l_mandant_zeitslots_1 (mandant_id,
zeitslot_id, zeitslot_bez) AS SELECT mandant_id,
 zeitslot_id,
 zeitslot_bez
FROM kfl_production_dbp_view.v_wbs_l_mandant_zeitslots_1;