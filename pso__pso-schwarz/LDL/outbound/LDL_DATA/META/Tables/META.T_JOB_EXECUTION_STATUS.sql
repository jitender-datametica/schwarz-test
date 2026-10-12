/* --------------------------------------------------------------------------------
   DDL for table: t_job_execution_status
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_job_execution_status (
job_exec_status_cd STRING(20) NOT NULL OPTIONS(description='The return code of the ETL job.'),
job_exec_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the return code of the ETL job.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (job_exec_status_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the return codes of an ETL job. Return codes indicate, whether the job has terminated successfully or if it has run into an error.');