/* --------------------------------------------------------------------------------
   DDL for table: t_query_resource_usage_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_query_resource_usage_1 (
query_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the query.'),
query_resource_usg_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the type of resource which is consumed by the execution of a query. E.g. CPU, I/O, disk, ...'),
query_resource_usg_meas BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The amount of the resource which was used by the query.'),
uom_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the unit_1 of measure.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (query_sid, query_resource_usg_type_cd) NOT ENFORCED
)
OPTIONS(description='This measure entity tracks the resource consumption of a query. The type of resource (e.g. CPU, I/O, disk, ...) is defined by the Query Resource Type.');