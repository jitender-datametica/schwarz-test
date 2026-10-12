/* --------------------------------------------------------------------------------
   DDL for table: t_system_partition
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_meta.t_system_partition (
sys_partition_cd STRING(20) NOT NULL
OPTIONS(description='The code which uniquely identifies the part or the instance of an IT system.'),
sys_name STRING(100) NOT NULL OPTIONS(description='The name of the IT system to which the partition belongs.'),
sys_partition_name STRING(100) NOT NULL
OPTIONS(description='The name for the part or the instance of an IT system. E.g. Wawi Germany.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (sys_partition_cd) NOT ENFORCED
) OPTIONS(description='A part or an instance of an IT system, which runs independently.E.g. a Wawi instance.');