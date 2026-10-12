/* --------------------------------------------------------------------------------
   DDL for table: t_job_execution_status_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_JOB_EXECUTION_STATUS_1 (
   job_exec_status_cd                  VARCHAR(20)     NOT NULL COMMENT 'The return code of the ETL job.',
   job_exec_status_descr               VARCHAR(250)    NOT NULL COMMENT 'A textual description for the return code of the ETL job.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_JOB_EXECUTION_STATUS PRIMARY KEY (job_exec_status_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the return codes of an ETL job. Return codes indicate, whether the job has terminated successfully or if it has run into an error.';
