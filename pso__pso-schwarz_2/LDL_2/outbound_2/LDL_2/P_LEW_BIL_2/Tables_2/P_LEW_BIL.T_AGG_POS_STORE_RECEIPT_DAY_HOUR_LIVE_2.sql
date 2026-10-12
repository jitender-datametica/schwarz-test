CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_pos_store_receipt_day_hour_live_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE NOT NULL,
receipt_tmsp_hour BIGNUMERIC(38,0) NOT NULL,
lidl_plus_fg BIGNUMERIC(38,0) NOT NULL,
turnover_relevant_fg BIGNUMERIC(38,0),
is_year_seq BIGNUMERIC(38,0),
cnt_receipt_sales BIGNUMERIC(38,0),
total_net_val NUMERIC(18,5),
dwh_created DATETIME NOT NULL,
PRIMARY KEY (client_id, loc_sid_store, dwh_cal_dt, receipt_tmsp_hour, lidl_plus_fg) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id;