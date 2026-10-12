CREATE TABLE P_LEW_CORE.T_REF_JOB_ROLE_TYPE_2 (
   job_role_type_cd                    VARCHAR(100)     NOT NULL COMMENT 'The code identifying the type of job role.',
   job_role_type_descr                 VARCHAR(250)     NOT NULL COMMENT 'A textual description for the type of job role.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_JOB_ROLE_TYPE PRIMARY KEY (job_role_type_cd) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the types of job roles. E.g. store manager, sales_2 manager, account_2 manager, etc.';
