CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_time_hourgroup_1 AS SELECT time_hour_id,
 time_halfhour_id,
 time_halfhour_display,
 time_hourgroup_id,
 time_hourgroup_display,
 time_total_id,
 time_total_display
FROM ldl_p_lew_core_ac.v_wawi_ref_time_hourgroup_1 AS THG;