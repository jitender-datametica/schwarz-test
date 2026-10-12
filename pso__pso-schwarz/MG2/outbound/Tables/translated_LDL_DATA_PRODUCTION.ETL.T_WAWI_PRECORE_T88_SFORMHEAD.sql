CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t88_sformhead (
ctrcode STRING(2) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c88_formcount BIGNUMERIC(29,10) NOT NULL,
c88_storeno INTEGER NOT NULL,
c88_formtype INTEGER NOT NULL,
c88_formdate DATETIME NOT NULL,
c88_warehouseno INTEGER,
c88_towarehouse INTEGER,
c88_tostore INTEGER,
c88_pl_pv_date DATETIME,
c88_pl_bereich STRING(4),
c88_global INTEGER,
c88_correct_count INTEGER,
c88_moddate DATETIME,
c88_moduser STRING(8),
c88_checksumvalue BIGNUMERIC(29,10),
c88_formno STRING(20),
c88_whnr INTEGER NOT NULL,
c88_adr_export_flag INTEGER NOT NULL,
c88_adr_export_date DATETIME,
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