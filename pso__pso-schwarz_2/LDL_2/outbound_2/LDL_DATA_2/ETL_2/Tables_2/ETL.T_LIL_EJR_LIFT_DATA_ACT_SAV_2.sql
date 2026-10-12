CREATE TABLE IF NOT EXISTS ldl_data_etl.t_lil_ejr_lift_data_act_sav_2 (
data_src_id BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
rtl_id BIGNUMERIC(38,0) NOT NULL,
rtl_lvl BIGNUMERIC(38,0) NOT NULL,
period_id BIGNUMERIC(38,0) NOT NULL,
period_sid BIGNUMERIC(38,0),
period_name STRING(100) COLLATE 'und:ci',
period_name_py STRING(100) COLLATE 'und:ci',
gfk_cat_id BIGNUMERIC(38,0) NOT NULL,
promotion_brand_id BIGNUMERIC(38,0) NOT NULL,
curr_cd STRING(20) NOT NULL,
meas_id BIGNUMERIC(38,0) NOT NULL,
val NUMERIC(18,5),
py_val NUMERIC(18,5),
prot_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (data_src_id, client_id, rtl_id, rtl_lvl, period_id, gfk_cat_id, promotion_brand_id, curr_cd, meas_id)
NOT ENFORCED
) CLUSTER BY client_id;