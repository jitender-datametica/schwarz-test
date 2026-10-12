CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_job_role_type (
job_role_type_cd STRING(100) NOT NULL OPTIONS(description='The code identifying the type of job role.'),
job_role_type_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the type of job role.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (job_role_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the types of job roles. E.g. store manager, sales manager, account manager, etc.');