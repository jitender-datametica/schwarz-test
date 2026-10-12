CREATE OR REPLACE TABLE biaid_tools_projects_production_fe_mstr_timesheets.t_etl_run_1 (
etl_run_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the ETL job execution, combined with SRC_FILE_NAME idetifies a row within the table uniquely'),
src_file_name STRING(500) NOT NULL OPTIONS(description='Name of the source file that cotains the data we are importing'),
job_type STRING(50)
OPTIONS(description=' Initial Load (if we import the timesheet entries for the first time) or Update if we load corrected values'),
file_needs_reload_fg BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Flag indicates if same file needs to be reloaded in another run. Set to 1 if you want to reload a file'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Point in time when this row was created in the database'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Point in time of the last update of this record'),
PRIMARY KEY (etl_run_id, src_file_name) NOT ENFORCED
) OPTIONS(description='A table that keeps track of ETL process executions');