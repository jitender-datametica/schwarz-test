/* --------------------------------------------------------------------------------
   DDL for table: t_etl_job_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_meta.t_etl_job_2 (
etl_job_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the ETL job'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
etl_job_name STRING(100) NOT NULL
OPTIONS(description='The name under which the ETL job is stored (not including the path name).'),
etl_job_version_nr STRING(20)
OPTIONS(description='In case the ETL job gets modified later on, this number can be used to distinguish the various versions.'),
path_name STRING(100) OPTIONS(description='The full path to the ETL job.'),
etl_job_descr STRING(250) OPTIONS(description='A free text detailing the purpose and structure of the ETL job.'),
etl_job_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the type of ETL job, e.g. SQL script or Ab Initio graph.'),
etl_appl_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the group of ETL jobs that form an application.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (etl_job_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='An ETL job is a piece of software that is used to extract data from a source system, transform it or to load it into the data warehouse. ETL jobs may use any technology, such as SQL or Ab Initio graphs. A job may consist of several steps.');