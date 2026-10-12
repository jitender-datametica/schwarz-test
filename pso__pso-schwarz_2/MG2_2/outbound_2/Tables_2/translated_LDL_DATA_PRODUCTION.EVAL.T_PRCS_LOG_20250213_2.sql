CREATE OR REPLACE TABLE ldl_data_production_eval.t_prcs_log_20250213_2 (
AGGREGATE STRING(100) COLLATE 'und:ci' NOT NULL,
dwh_node_cd STRING(20) COLLATE 'und:ci' NOT NULL,
country_cd STRING(2) COLLATE 'und:ci',
dwh_cal_dt DATE NOT NULL,
loc_sid BIGNUMERIC(38,0),
recalc_fg BIGNUMERIC(38,0) NOT NULL,
status_2 BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
create_tmsp DATETIME NOT NULL,
update_tmsp DATETIME,
start_tmsp DATETIME,
end_tmsp DATETIME
);