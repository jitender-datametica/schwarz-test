CREATE TABLE P_LEW_CORE.T_JOB_ROLE_HIST_1 (
   client_id                           NUMBER(38,0)     COMMENT 'Surrogate Key CLIENT.',
   job_role_sid                        NUMBER(38, 0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the job role.',
   reports_to_job_role_sid             NUMBER(38,0)     COMMENT 'The unique identifier (surrogate key) for the job role to which this role reports.',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Article is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_JOB_ROLE_HIST PRIMARY KEY (job_role_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'A job role is a position within the organization with a defined scope and responsibility. Typically, a job role is filled by one employee.';
