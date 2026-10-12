CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_oso_employees_2 (
orgaunitid INTEGER NOT NULL,
countrycode STRING(4),
organumber INTEGER,
type0 STRING(50),
wh_name STRING(255),
parentorgaunitid INTEGER,
id STRING(50),
parent_id STRING(50),
adname STRING(50),
firstname STRING(50),
lastname STRING(50),
deputyemployeeid STRING(50),
mail STRING(250),
phone STRING(20),
empl_role STRING(50),
workforceid STRING(50),
child_empl_list JSON,
extraction_timestamp TIMESTAMP,
dwh_created_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse. '),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20)
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);