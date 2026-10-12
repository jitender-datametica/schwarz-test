DROP TABLE IF EXISTS ldl_data_production_eval.tmp_retail_event_to_fix_hash_key_1;
CREATE OR REPLACE TABLE ldl_data_production_eval.tmp_retail_event_to_fix_hash_key_1 (
retail_event_sid INTEGER NOT NULL,
cashier_hash STRING(32),
auth_by_hash STRING(32),
mis_cashier_id INTEGER,
mis_authority_cd STRING(100),
country_cd STRING(2),
mis_orig_store_nr INTEGER,
mis_dwh_cal_dt DATE,
mis_register_id INTEGER,
mis_receipt_id INTEGER,
mis_client_id INTEGER,
mis_loc_sid INTEGER,
PRIMARY KEY (retail_event_sid) NOT ENFORCED
) CLUSTER BY country_cd, mis_dwh_cal_dt;