/* --------------------------------------------------------------------------------
   DDL for table: T_CONTAINER_MILESTONE_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_container_milestone_2 (
container_milestone_cd STRING(50) NOT NULL
OPTIONS(description='A milestone is an event in the container lifecycle. Table contains the list of the possible events'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (container_milestone_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - A milestone is an event in the container lifecycle. Table contains the list of the possible events - Source - VMT');