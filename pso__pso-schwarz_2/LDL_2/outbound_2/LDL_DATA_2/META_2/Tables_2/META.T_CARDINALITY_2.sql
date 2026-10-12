/* --------------------------------------------------------------------------------
   DDL for table: t_cardinality_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_cardinality_2 (
cardinality_cd STRING(5) NOT NULL OPTIONS(description='A code identifying the cardinality, i.e. 1:1, 1:n or n:m'),
cardinality_name STRING(100) NOT NULL
OPTIONS(description='The full text name for the cardinality, i.e. one-to-one, one-to-many or many-to-many.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cardinality_cd) NOT ENFORCED
)
OPTIONS(description='The cardinality of a relationship defines, how many instances of the one data structures are related with how many instances of the other data structures. Cardinalities may be 1:1, 1:n and n:m.');