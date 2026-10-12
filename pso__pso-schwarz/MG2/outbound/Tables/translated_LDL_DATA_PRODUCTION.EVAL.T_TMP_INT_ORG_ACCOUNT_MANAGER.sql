CREATE OR REPLACE TABLE ldl_data_production_eval.t_tmp_int_org_account_manager (
client_id INTEGER,
wh_nr INTEGER,
account_manager_district STRING(16777216) COLLATE 'und:ci',
account_manager_name STRING(16777216) COLLATE 'und:ci',
account_manager_nr STRING(16777216),
country_cd STRING(160),
curr_cd STRING(160),
dwh_valid_from_tmsp DATETIME,
dwh_valid_to_tmsp DATETIME
);