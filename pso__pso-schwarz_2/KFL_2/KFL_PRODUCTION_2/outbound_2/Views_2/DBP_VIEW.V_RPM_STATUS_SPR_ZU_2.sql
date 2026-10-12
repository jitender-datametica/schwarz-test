CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_status_spr_zu_2 AS SELECT rpm_status_id,
 spr_id,
 rpm_status_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rpm_status_spr_zu_2;