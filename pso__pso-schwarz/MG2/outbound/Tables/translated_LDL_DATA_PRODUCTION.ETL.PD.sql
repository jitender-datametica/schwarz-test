CREATE OR REPLACE TABLE ldl_data_production_etl.pd (
bus_dt DATE,
int_org_sid INTEGER,
country_org_sid INTEGER,
int_org_type_cd STRING(5),
country_org_cd STRING(2),
curr_cd STRING(3),
turnover_gross_val NUMERIC(29,5),
turnover_net_val NUMERIC(29,5),
exclude_vat_val NUMERIC(29,5)
);