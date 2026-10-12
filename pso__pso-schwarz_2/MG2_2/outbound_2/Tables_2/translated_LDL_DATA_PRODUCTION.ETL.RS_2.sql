CREATE OR REPLACE TABLE ldl_data_production_etl.rs_2 (
bus_dt DATE,
int_org_sid INTEGER,
int_org_type_cd STRING(5),
country_org_cd STRING(2),
curr_cd STRING(3),
eod_turnover_gross_val NUMERIC(29,5),
eod_turnover_net_val NUMERIC(29,5),
eod_receipt_cnt INTEGER
);