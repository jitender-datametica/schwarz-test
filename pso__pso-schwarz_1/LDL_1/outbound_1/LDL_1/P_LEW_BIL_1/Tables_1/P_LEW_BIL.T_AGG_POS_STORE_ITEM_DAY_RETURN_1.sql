CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_pos_store_item_day_return_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE NOT NULL,
return_qty NUMERIC(18,5),
return_reason_cd BIGNUMERIC(38,0),
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dwh_cal_dt;