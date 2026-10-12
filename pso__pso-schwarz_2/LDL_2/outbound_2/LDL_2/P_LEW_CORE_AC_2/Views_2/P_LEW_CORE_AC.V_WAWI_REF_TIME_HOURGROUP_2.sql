CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_time_hourgroup_2 (time_halfhour_id, time_hour_id,
time_halfhour_display, time_hourgroup_id, time_hourgroup_display, time_total_id, time_total_display) AS SELECT
 time_halfhour_id,
 time_hour_id,
 time_halfhour_display,
 time_hourgroup_id,
 time_hourgroup_display,
 time_total_id,
 time_total_display
FROM ldl_p_lew_core.t_wawi_ref_time_hourgroup_2;