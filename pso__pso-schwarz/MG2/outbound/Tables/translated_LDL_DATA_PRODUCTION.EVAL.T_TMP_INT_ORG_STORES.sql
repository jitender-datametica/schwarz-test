CREATE OR REPLACE TABLE ldl_data_production_eval.t_tmp_int_org_stores (
root_loc_sid INTEGER,
root_client_id INTEGER,
root_store_nr INTEGER,
curr_loc_sid INTEGER,
curr_store_nr INTEGER,
curr_store_name STRING(100) COLLATE 'und:ci',
curr_opening_dt DATE,
curr_real_opening_dt DATE,
curr_closing_dt DATE,
building_sid INTEGER,
building_nr STRING(20) COLLATE 'und:ci',
dwh_valid_from_tmsp DATETIME,
dwh_valid_to_tmsp DATETIME
);