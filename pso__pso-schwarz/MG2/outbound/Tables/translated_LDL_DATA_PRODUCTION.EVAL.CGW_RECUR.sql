CREATE OR REPLACE TABLE ldl_data_production_eval.cgw_recur (
accountid STRING(250),
igl_number STRING(100),
prev_account_id STRING(250),
prev_igl_number STRING(100),
prev_open_dt DATETIME,
prev_close_dt DATETIME,
level INTEGER
);