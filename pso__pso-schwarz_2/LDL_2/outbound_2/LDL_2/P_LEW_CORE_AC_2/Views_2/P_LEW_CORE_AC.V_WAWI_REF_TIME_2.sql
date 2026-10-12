CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_time_2 (time_hour_id, time_hour_display, time_halfhour_id,
time_halfhour_display, time_total_id, time_total_display, load_id) AS SELECT time_hour_id,
 time_hour_display,
 time_halfhour_id,
 time_halfhour_display,
 time_total_id,
 time_total_display,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_time_2;