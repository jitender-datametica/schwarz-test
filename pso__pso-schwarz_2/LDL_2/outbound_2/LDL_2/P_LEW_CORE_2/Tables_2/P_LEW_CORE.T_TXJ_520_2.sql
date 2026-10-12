CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_txj_520_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
item_nr STRING(20) COLLATE 'und:ci' NOT NULL,
record_cd STRING(12) COLLATE 'und:ci' NOT NULL,
snapshot_tmsp DATETIME,
sales_qty NUMERIC(18,5),
sales_val NUMERIC(18,5),
returns_qty NUMERIC(18,5),
returns_val NUMERIC(18,5),
voids_qty NUMERIC(18,5),
voids_val NUMERIC(18,5),
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY dwh_cal_dt, client_id;