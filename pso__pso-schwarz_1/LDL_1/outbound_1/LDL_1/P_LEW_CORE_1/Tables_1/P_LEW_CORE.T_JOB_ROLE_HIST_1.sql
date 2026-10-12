CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_job_role_hist_1 (
client_id BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CLIENT.'),
job_role_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the job role.'),
reports_to_job_role_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the job role to which this role reports.'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Article is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (job_role_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='A job role is a position within the organization with a defined scope and responsibility. Typically, a job role is filled by one employee.');