CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t931_vat_convert_1 (
ctrcode STRING(2) COLLATE 'und:ci' NOT NULL,
c931_storenr BIGNUMERIC(29,10) NOT NULL,
c931_vatcode_wawi BIGNUMERIC(29,10) NOT NULL,
c931_vatcode_converted BIGNUMERIC(29,10) NOT NULL,
c931_countrycode STRING(3) NOT NULL,
c931_moddate DATETIME,
c931_moduser STRING(8),
c931_type INTEGER NOT NULL,
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);