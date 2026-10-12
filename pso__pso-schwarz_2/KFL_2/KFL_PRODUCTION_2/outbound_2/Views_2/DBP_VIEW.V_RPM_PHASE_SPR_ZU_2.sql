CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_phase_spr_zu_2 AS SELECT rpm_phase_id,
 rpm_projekt_typ_id,
 spr_id,
 rpm_phase_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rpm_phase_spr_zu_2;