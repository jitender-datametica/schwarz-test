CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_time_hourgroup_1 (
time_halfhour_id BIGNUMERIC(38,0) NOT NULL,
time_hour_id BIGNUMERIC(38,0) NOT NULL,
time_halfhour_display STRING(35) COLLATE 'und:ci' NOT NULL,
time_hourgroup_id BIGNUMERIC(38,0) NOT NULL,
time_hourgroup_display STRING(35) COLLATE 'und:ci' NOT NULL,
time_total_id BIGNUMERIC(38,0) NOT NULL,
time_total_display STRING(35) COLLATE 'und:ci' NOT NULL
);