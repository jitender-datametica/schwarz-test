CREATE OR REPLACE TABLE ldl_data_production_etl_process.t_tcache_saphana_cv_cube_ker_values_cdwh_snap (
extraction_ts DATETIME,
extraction_date DATE,
source_system STRING(100000),
bic_zmlila STRING(100000) NOT NULL,
load_id FLOAT64,
vlxmlcntr STRING(100000) NOT NULL,
calmonth STRING(100000),
vlxecukyl STRING(100000),
kalk_repr_ist NUMERIC(17,2),
kalk_repr_plan NUMERIC(17,2),
kalkulation_ist NUMERIC(17,2),
kalkulation_plan NUMERIC(17,2),
steuern_ist NUMERIC(17,2),
steuern_plan NUMERIC(17,2),
rvg_ist NUMERIC(17,2),
rvg_plan NUMERIC(17,2),
nrv_ist NUMERIC(17,2),
nrv_plan NUMERIC(17,2),
spedition_ist NUMERIC(17,2),
spedition_plan NUMERIC(17,2),
whrgdiff_ist NUMERIC(17,2),
whrgdiff_plan NUMERIC(17,2),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);