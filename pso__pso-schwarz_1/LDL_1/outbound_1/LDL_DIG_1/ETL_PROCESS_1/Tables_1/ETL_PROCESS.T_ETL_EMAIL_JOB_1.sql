/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_EMAIL_JOB_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 14. Juni 2022 11:33:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_email_job_1 (
job_id BIGNUMERIC NOT NULL OPTIONS(description='The jobid number of the respective engagement event job '),
email_name STRING(100)
OPTIONS(description='The name of the email for specific event job (email name associated with jobid) '),
email_subject STRING(4000) OPTIONS(description='The descriptive subject name of the email'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (job_id) NOT ENFORCED
) OPTIONS(description='The ETL lookup table based on the source- emails_job_last5days to get email_name');