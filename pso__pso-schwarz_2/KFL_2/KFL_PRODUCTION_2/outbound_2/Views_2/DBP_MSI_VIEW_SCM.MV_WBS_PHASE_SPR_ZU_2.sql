CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_phase_spr_zu_2 AS SELECT mandant_id,
 spr_id,
 wbs_phase_id,
 wbs_phase_bez
FROM kfl_production_dbp_view.v_wbs_phase_spr_zu_2;