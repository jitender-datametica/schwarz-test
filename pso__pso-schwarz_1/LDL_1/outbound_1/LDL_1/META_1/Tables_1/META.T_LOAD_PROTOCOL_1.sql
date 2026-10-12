/* --------------------------------------------------------------------------------
   DDL for table: t_load_protocol_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_meta.t_load_protocol_1 (
load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the execution of an ETL job.'),
etl_job_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the ETL job'),
start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the ETL job was started.'),
end_tmsp TIMESTAMP
OPTIONS(description='The point in time when the ETL job terminated (either successfully or with an error).'),
rerun_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the ETL job was run again after a failure.'),
restart_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the job was restarted.'),
job_exec_status_cd STRING(20) NOT NULL OPTIONS(description='The return code of the ETL job.'),
read_rec_cnt BIGNUMERIC(38,0) OPTIONS(description='The number of records which have been read by the ETL job.'),
written_rec_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of records which have been written to the target data structure by the ETL job.'),
rejected_rec_cnt BIGNUMERIC(38,0) OPTIONS(description='The number of records which have been rejected by the ETL job.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (load_id) NOT ENFORCED
)
OPTIONS(description='The load protocol tracks the execution of ETL jobs. Whenever a job is run, it is logged in this entity. ');