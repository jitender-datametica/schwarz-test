CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbs_phase_zu_1 AS SELECT mandant_id,
 ausliefergruppe_id,
 anz_tage_vor_aktion,
 wbs_phase_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.wbs_phase_zu_1;