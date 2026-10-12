CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_dispo_range_wh_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
range_zone_id BIGNUMERIC(38,0) NOT NULL,
range_plan_id BIGNUMERIC(38,0) NOT NULL,
range_desc STRING(20) COLLATE 'und:ci' NOT NULL,
range_time_from TIME NOT NULL,
range_time_until TIME NOT NULL,
range_wh_day_0 BIGNUMERIC(38,0),
range_wh_day_1 BIGNUMERIC(38,0),
range_wh_day_2 BIGNUMERIC(38,0),
range_wh_day_3 BIGNUMERIC(38,0),
range_wh_day_4 BIGNUMERIC(38,0),
range_wh_day_5 BIGNUMERIC(38,0),
range_wh_day_6 BIGNUMERIC(38,0),
dat_dayend DATE,
load_id BIGNUMERIC(38,0) NOT NULL
);