CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_ptm_pze4_ptm_plantimeday_1 (
int_org_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
bic_zmlila STRING(20) NOT NULL,
wh_no STRING(20),
store INTEGER NOT NULL,
cal_dt DATE NOT NULL,
turnover NUMERIC(18,5),
plan_hours NUMERIC(18,5),
performance NUMERIC(18,5),
inventory NUMERIC(18,5),
training NUMERIC(18,5),
workingdays NUMERIC(18,5),
holidays NUMERIC(18,5),
lastmodification TIMESTAMP,
day_end_dat DATE,
extraction_date DATE,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);