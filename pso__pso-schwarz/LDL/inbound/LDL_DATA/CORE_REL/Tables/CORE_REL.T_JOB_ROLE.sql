CREATE TABLE core_rel.T_JOB_ROLE (
   job_role_sid                        NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the job role.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   job_role_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code identifying the type of job role.',
   job_role_name                       VARCHAR(100)    NOT NULL COMMENT 'The name by which the job role is known.',
   int_org_sid                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization, for which this job role is defined.',
   reports_to_job_role_sid             NUMBER(38,0)    COMMENT 'The unique identifier (surrogate key) for the job role to which this role reports.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_JOB_ROLE PRIMARY KEY (job_role_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'A job role is a position within the organization with a defined scope and resonsibility. Typically, a job role is filled by one employee.';
