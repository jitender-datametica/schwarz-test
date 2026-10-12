CREATE OR REPLACE TABLE ldl_data_production_eval.t_tmp_int_org_sales_manager_2 (
client_id INTEGER,
wh_nr INTEGER,
country_cd STRING(160),
curr_cd STRING(160),
account_manager_district STRING(16777216) COLLATE 'und:ci',
sales_manager_district STRING(16777216) COLLATE 'und:ci',
sales_manager_name STRING(16777216) COLLATE 'und:ci',
sales_manager_nr STRING(16777216),
dwh_valid_from_tmsp DATETIME,
dwh_valid_to_tmsp DATETIME
);