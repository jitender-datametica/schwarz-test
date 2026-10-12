CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_item_elwis_list_type_store_day (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
store_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dwh_cal_dt DATE NOT NULL,
item_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
permissive_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
list_type_mark STRING(16777216),
list_type_label STRING(16777216),
deleted_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
PRIMARY KEY (client_id, store_sid, dwh_cal_dt, item_sid) NOT ENFORCED
);