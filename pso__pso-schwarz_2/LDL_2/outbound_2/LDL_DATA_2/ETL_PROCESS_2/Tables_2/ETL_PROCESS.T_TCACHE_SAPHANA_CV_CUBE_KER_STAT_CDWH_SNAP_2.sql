CREATE TABLE IF NOT EXISTS ldl_data_etl_process.t_tcache_saphana_cv_cube_ker_stat_cdwh_snap_2 (
extraction_ts DATETIME,
extraction_date DATE,
source_system STRING(100000),
bic_zmlila STRING(100000),
calmonth STRING(100000),
load_id FLOAT64,
gxxmlklag STRING(100000),
vlxmlcntr STRING(100000),
unit_2 STRING(100000),
ist FLOAT64,
plan FLOAT64,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);