CREATE TABLE IF NOT EXISTS ldl_data_etl.t_tcache_oso_orgaunits_2 (
orgaunitid BIGNUMERIC(38,0) NOT NULL,
parentorgaunitid BIGNUMERIC(38,0),
countrycode STRING(4),
organumber BIGNUMERIC(38,0),
name STRING(255),
type0 STRING(50),
storeid STRING(90),
address_2 JSON,
phone STRING(90),
openingdate STRING(22),
testorgaunit BOOL,
temporaryclosings JSON,
status_2 STRING(30),
timezone STRING(30),
locale STRING(90),
employeeid STRING(90),
employees JSON,
taxdata JSON,
region_2 JSON,
closingdate STRING(22),
extraction_timestamp TIMESTAMP,
dwh_created_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20)
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);