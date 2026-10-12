/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CONTAINER_MILESTONE_RESULT
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_container_milestone_result (
container_milestone_result_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - A milestone is an event in the container lifecycle. Table contains the list of the possible event results'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (container_milestone_result_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - A milestone is an event in the container lifecycle. Table contains the list of the result of possible event results. - Source - VMT');