CREATE TABLE meta.T_JOB_ROLE_KEY_TYPE_2 (
   job_role_key_type_cd                VARCHAR(20)     NOT NULL COMMENT 'The code for the type of natural key which identifies the Job Role.',
   job_role_key_type_name              VARCHAR(100)    NOT NULL COMMENT 'The name of the type of natural key which identifies the Job Role.',
   job_role_key_type_descr             VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_JOB_ROLE_KEY_TYPE PRIMARY KEY (job_role_key_type_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the type of natural key which identifies a Job Role.';
