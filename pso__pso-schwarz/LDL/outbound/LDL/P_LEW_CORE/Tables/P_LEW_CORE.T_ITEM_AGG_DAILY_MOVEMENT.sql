CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_agg_daily_movement (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
storage_loc_cd STRING(20) NOT NULL,
inflow_qty NUMERIC(18,5),
outflow_qty NUMERIC(18,5),
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (item_sid, loc_sid, storage_loc_cd, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt;