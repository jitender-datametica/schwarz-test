CREATE OR REPLACE TABLE ldl_data_production_etl.t_cash_register_event_classification_bkp_20250214_2 (
cash_register_event_sid INTEGER,
cash_register_event_nr STRING(20),
scenario_id INTEGER,
country_org_cd STRING(2),
store_sid INTEGER,
bus_dt DATE,
cashier_nr STRING(20),
cash_register_event_cnt INTEGER,
cash_register_event_affected_line_cnt INTEGER,
cash_register_event_affected_net_val NUMERIC(29,5),
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_load_id INTEGER,
dwh_node_cd STRING(20),
cust_sid INTEGER,
cust_ident_type_cd STRING(20)
);