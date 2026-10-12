CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_time_1 AS SELECT time_hour_id,
 time_hour_display,
 time_halfhour_id,
 time_halfhour_display
FROM ldl_p_lew_core_ac.v_wawi_ref_time_1 AS RT;