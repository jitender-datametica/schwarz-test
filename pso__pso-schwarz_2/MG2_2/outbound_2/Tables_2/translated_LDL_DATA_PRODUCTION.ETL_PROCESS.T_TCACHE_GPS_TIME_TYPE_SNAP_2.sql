CREATE OR REPLACE TABLE ldl_data_production_etl_process.t_tcache_gps_time_type_snap_2 (
bic_zmlila STRING(1000),
wh_id INTEGER,
missingtype_id INTEGER,
missingtype_short_desc STRING(1000),
missingtype_desc STRING(1000),
sap_cd STRING(1000),
presence_fg INTEGER,
missingtype_perf_rel_fg INTEGER,
extraction_ts TIMESTAMP,
active_from DATE NOT NULL,
active_to DATE NOT NULL,
processed_fg INTEGER,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);