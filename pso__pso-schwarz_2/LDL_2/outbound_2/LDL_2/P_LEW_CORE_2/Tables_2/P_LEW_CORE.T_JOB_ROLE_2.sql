CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_job_role_2 (
client_id BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CLIENT.'),
job_role_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the job role.'),
job_role_type_cd STRING(100) NOT NULL OPTIONS(description='The code identifying the type of job role.'),
job_role_name STRING(100) NOT NULL OPTIONS(description='The name by which the job role is known.'),
loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key LOCATION_2 (eindeutig ueber alle Laender / Mandanten hinweg).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (job_role_sid) NOT ENFORCED
)
OPTIONS(description='A job role is a position within the organization with a defined scope and responsibility. Typically, a job role is filled by one employee.');