DROP TABLE IF EXISTS ldl_p_lew_bil.t_agg_pos_store_receipt_day_hour_live_mth;
CREATE OR REPLACE TABLE ldl_p_lew_bil.t_agg_pos_store_receipt_day_hour_live_mth (
client_id INTEGER NOT NULL,
loc_sid_store INTEGER NOT NULL,
dwh_cal_dt DATE NOT NULL,
receipt_tmsp_hour INTEGER NOT NULL,
lidl_plus_fg INTEGER NOT NULL,
turnover_relevant_fg INTEGER,
is_year_seq INTEGER,
cnt_receipt_sales INTEGER,
total_net_val NUMERIC(29,5),
dwh_created DATETIME NOT NULL,
receipt_tmsp_half_hour INTEGER DEFAULT 0 NOT NULL,
PRIMARY KEY (client_id, loc_sid_store, dwh_cal_dt, receipt_tmsp_hour, receipt_tmsp_half_hour, lidl_plus_fg) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id;