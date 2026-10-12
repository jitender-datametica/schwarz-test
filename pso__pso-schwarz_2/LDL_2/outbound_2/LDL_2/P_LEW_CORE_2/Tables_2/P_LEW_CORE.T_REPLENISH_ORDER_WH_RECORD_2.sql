CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_replenish_order_wh_record_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
order_record_id STRING(20) COLLATE 'und:ci' NOT NULL,
order_seq_nr BIGNUMERIC(38,0) NOT NULL,
order_created_tmsp DATETIME,
order_updated_tmsp DATETIME,
order_status_cd BIGNUMERIC(38,0),
order_batch_id BIGNUMERIC(38,0),
sup_sid BIGNUMERIC(38,0) NOT NULL,
delivery_dt DATE NOT NULL,
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dwh_cal_dt;