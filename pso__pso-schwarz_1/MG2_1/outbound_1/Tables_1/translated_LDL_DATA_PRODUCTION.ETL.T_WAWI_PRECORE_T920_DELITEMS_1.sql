CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t920_delitems_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c920_batchnr INTEGER,
c920_batchdate DATETIME,
c920_batchitemnr INTEGER NOT NULL,
c920_itemnr_short STRING(18),
c920_state INTEGER,
c920_closed INTEGER,
c920_moddate DATETIME,
c920_moduser STRING(8),
c920_itemdesc STRING(100),
c920_errortable STRING(30),
c920_error_message STRING(1000),
c920_released_by STRING(8),
c920_created_by STRING(8),
c920_idvalue BIGNUMERIC(29,10),
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