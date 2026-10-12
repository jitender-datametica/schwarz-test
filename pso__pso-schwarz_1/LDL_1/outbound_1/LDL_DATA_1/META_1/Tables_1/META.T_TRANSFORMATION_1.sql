/* --------------------------------------------------------------------------------
   DDL for table: t_transformation_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_transformation_1 (
transform_cd STRING(20) NOT NULL
OPTIONS(description='A code identifying the set of rules and algorithms which define, how a data object is converted into another data object.'),
transform_name STRING(100) NOT NULL
OPTIONS(description='The name for the set of rules and algorithms which define, how a data object is converted into another data object.'),
transform_descr STRING(250)
OPTIONS(description='A textual description which describes how the transformation is to be used.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (transform_cd) NOT ENFORCED
)
OPTIONS(description='The transformation defines the set of rules and algorithms which are used to convert one data object into another one. This may include joins, filters and aggregations as well as calculations or formatting operations. Transformations may be defined on the level of data objects or for data elements.');