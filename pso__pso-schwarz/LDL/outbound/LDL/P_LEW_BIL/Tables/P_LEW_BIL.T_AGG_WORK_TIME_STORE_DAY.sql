CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_work_time_store_day (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE,
work_time_gross_hr NUMERIC(18,5),
work_time_net_hr NUMERIC(18,5),
break_hr NUMERIC(18,5),
perform_relev_absence_hr NUMERIC(18,5),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dwh_cal_dt;