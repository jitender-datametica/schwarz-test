CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_upi_eclient_day_item (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dwh_cal_dt DATE DEFAULT DATE '8888-12-31' NOT NULL,
item_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
effective_client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
luxembourg_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
PRIMARY KEY (dwh_cal_dt, item_sid, effective_client_id) NOT ENFORCED
);