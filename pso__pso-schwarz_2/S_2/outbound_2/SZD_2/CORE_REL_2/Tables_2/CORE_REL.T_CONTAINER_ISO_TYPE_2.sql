/* --------------------------------------------------------------------------------
   DDL for table: T_CONTAINER_ISO_TYPE_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_container_iso_type_2 (
container_iso_type_cd STRING(50) NOT NULL
OPTIONS(description='The type code that define a container like "22G0", "42G0" or "42R1" and others'),
container_iso_type_descr STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - A textual description of the type of container'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (container_iso_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity -The minor dimension that contains the list of iso types of a container - Source - VMT');