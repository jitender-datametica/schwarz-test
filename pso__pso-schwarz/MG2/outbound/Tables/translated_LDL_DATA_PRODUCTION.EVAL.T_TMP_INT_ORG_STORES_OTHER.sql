CREATE OR REPLACE TABLE ldl_data_production_eval.t_tmp_int_org_stores_other (
rel_type STRING(14),
wh_type_id INTEGER,
client_id INTEGER,
country_cd STRING(160),
curr_cd STRING(160),
store_nr INTEGER,
store_name STRING(100) COLLATE 'und:ci',
dwh_valid_from_tmsp DATE,
dwh_valid_to_tmsp DATETIME,
wh_nr INTEGER,
wh_name STRING(100) COLLATE 'und:ci',
opening_dt DATE,
real_opening_dt DATE,
closing_dt DATE,
open_on_holidays_fg INTEGER
);