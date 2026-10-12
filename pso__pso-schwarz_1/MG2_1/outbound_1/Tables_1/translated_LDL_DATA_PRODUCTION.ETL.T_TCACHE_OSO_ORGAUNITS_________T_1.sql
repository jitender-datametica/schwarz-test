CREATE OR REPLACE TABLE ldl_data_production_etl.t_tcache_oso_orgaunits_________t_1 (
orgaunitid INTEGER NOT NULL,
parentorgaunitid INTEGER,
countrycode STRING(4),
organumber INTEGER,
name STRING(255),
type0 STRING(50),
storeid STRING(90),
address_1 JSON,
phone STRING(90),
openingdate STRING(22),
testorgaunit BOOL,
temporaryclosings JSON,
status_1 STRING(30),
timezone STRING(30),
locale STRING(90),
employeeid STRING(90),
employees JSON,
taxdata JSON,
region_1 JSON,
closingdate STRING(22),
extraction_timestamp TIMESTAMP,
dwh_created_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20)
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);