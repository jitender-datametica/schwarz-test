/* --------------------------------------------------------------------------------
   DDL for table: t_workload_class_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_meta.t_workload_class_2 (
workload_class_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the workload. E.g. customer segmentation queries, data mining, etc.'),
workload_class_descr STRING(250) NOT NULL
OPTIONS(description='A text field describing the structure and the purpose of the workload.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (workload_class_cd) NOT ENFORCED
)
OPTIONS(description='Queries the serve the same purpose can be grouped to a workload, e.g. based on the user who submits the query, the purpose of the query or the objects which get accessed.');