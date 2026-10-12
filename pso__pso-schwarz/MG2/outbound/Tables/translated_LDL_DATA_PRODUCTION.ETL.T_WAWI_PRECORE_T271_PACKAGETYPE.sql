CREATE OR REPLACE TABLE ldl_data_production_etl.t_wawi_precore_t271_packagetype (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c271_packnr INTEGER NOT NULL,
c271_packdescript STRING(15),
c271_eks_link INTEGER,
c271_int_short STRING(10),
c271_int_desc STRING(15),
scn INTEGER DEFAULT 0,
extraction_tmsp DATETIME,
extraction_dt DATE,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);