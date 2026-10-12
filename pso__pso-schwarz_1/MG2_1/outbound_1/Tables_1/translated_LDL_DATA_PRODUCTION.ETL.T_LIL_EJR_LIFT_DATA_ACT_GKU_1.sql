DROP TABLE IF EXISTS ldl_data_production_etl.t_lil_ejr_lift_data_act_gku_1;
CREATE OR REPLACE TABLE ldl_data_production_etl.t_lil_ejr_lift_data_act_gku_1 (
data_src_id INTEGER NOT NULL,
client_id INTEGER NOT NULL,
rtl_id INTEGER NOT NULL,
rtl_lvl INTEGER NOT NULL,
period_id INTEGER NOT NULL,
period_sid INTEGER,
period_name STRING(100) COLLATE 'und:ci',
period_name_py STRING(100) COLLATE 'und:ci',
gfk_cat_id INTEGER NOT NULL,
promotion_brand_id INTEGER NOT NULL,
curr_cd STRING(20) NOT NULL,
meas_id INTEGER NOT NULL,
val NUMERIC(18,5),
py_val NUMERIC(18,5),
prot_fg INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (data_src_id, client_id, rtl_id, rtl_lvl, period_id, gfk_cat_id, promotion_brand_id, curr_cd, meas_id)
NOT ENFORCED
) CLUSTER BY client_id;