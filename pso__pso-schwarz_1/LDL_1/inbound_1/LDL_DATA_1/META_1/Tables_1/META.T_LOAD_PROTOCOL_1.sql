/* --------------------------------------------------------------------------------
   DDL for table: t_load_protocol_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_LOAD_PROTOCOL_1 (
   load_id                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the execution of an ETL job.',
   etl_job_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the ETL job',
   start_tmsp                          TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time when the ETL job was started.',
   end_tmsp                            TIMESTAMP_TZ(9) COMMENT 'The point in time when the ETL job terminated (either successfully or with an error).',
   rerun_fg                            BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the ETL job was run again after a failure.',
   restart_fg                          BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the job was restarted.',
   job_exec_status_cd                  VARCHAR(20)     NOT NULL COMMENT 'The return code of the ETL job.',
   read_rec_cnt                        NUMBER(38, 0)   COMMENT 'The number of records which have been read by the ETL job.',
   written_rec_cnt                     NUMBER(38, 0)   COMMENT 'The number of records which have been written to the target data structure by the ETL job.',
   rejected_rec_cnt                    NUMBER(38, 0)   COMMENT 'The number of records which have been rejected by the ETL job.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_LOAD_PROTOCOL PRIMARY KEY (load_id) NOT ENFORCED
 )  COMMENT= 'The load protocol tracks the execution of ETL jobs. Whenever a job is run, it is logged in this entity. ';