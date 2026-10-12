CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_wbs_phase_1 AS SELECT mandant_id,
 wbs_phase_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.l_wbs_phase_1;