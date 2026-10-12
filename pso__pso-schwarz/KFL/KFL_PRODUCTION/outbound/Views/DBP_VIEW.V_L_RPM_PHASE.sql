CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_rpm_phase AS SELECT rpm_phase_id,
 rpm_projekt_typ_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_rpm_phase;