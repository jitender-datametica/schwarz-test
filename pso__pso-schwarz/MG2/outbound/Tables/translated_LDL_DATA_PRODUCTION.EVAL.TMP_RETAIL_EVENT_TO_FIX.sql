CREATE OR REPLACE TABLE ldl_data_production_eval.tmp_retail_event_to_fix (
client_id INTEGER NOT NULL,
loc_sid INTEGER NOT NULL,
register_id INTEGER NOT NULL,
receipt_id INTEGER NOT NULL,
dwh_cal_dt DATE NOT NULL,
receipt_tmsp DATETIME NOT NULL,
receipt_bus_dt DATE NOT NULL
);