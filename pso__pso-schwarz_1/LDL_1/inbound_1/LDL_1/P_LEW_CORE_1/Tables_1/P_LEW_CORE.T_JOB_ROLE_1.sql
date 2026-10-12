CREATE TABLE P_LEW_CORE.T_JOB_ROLE_1 (
   client_id                           NUMBER(38,0)     COMMENT 'Surrogate Key CLIENT.',
   job_role_sid                        NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for the job role.',
   job_role_type_cd                    VARCHAR(100)     NOT NULL COMMENT 'The code identifying the type of job role.',
   job_role_name                       VARCHAR(100)     NOT NULL COMMENT 'The name by which the job role is known.',
   loc_sid                             NUMBER(38,0)     COMMENT 'Surrogate Key LOCATION_1 (eindeutig ueber alle Laender / Mandanten hinweg).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_JOB_ROLE PRIMARY KEY (job_role_sid) NOT ENFORCED 
)  COMMENT = 'A job role is a position within the organization with a defined scope and responsibility. Typically, a job role is filled by one employee.';
