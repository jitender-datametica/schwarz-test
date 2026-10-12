CREATE OR REPLACE TABLE ldl_data_production_meta.t_dv_rwi_retail_by_store_day_vs_store_day_product_prev_1d (
bus_dt DATE,
int_org_sid INTEGER,
cash_register_net_val NUMERIC(29,2),
sum_cash_register_net_val NUMERIC(29,2),
failed INTEGER,
total INTEGER,
rule_code STRING(255),
rule_description STRING(255),
metric STRING(255),
dataelem STRING(255),
dataelem_value NUMERIC(29,2),
collection_time TIMESTAMP
);