CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_mstr_run_log_steps_2 (
sf_role_user_name STRING(255) NOT NULL
OPTIONS(description='The Snowflake Role or User name which is synchoronized to MicroStrategy Project'),
mstr_env_name STRING(255) NOT NULL OPTIONS(description='The Environment (D/Q/P) where the synchoronization ran already'),
mstr_proj_nr STRING(32) NOT NULL
OPTIONS(description='The Project ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_sec_filter_template_name STRING(255) NOT NULL
OPTIONS(description='The name of the security filter (also kind of Identifier)'),
python_proc_name STRING(255) NOT NULL
OPTIONS(description='The name of the python procedure where the log entiries are coming'),
python_proc_step_name STRING(255) NOT NULL
OPTIONS(description='The current step in the python procedure where the log entiries are coming'),
python_proc_param_txt STRING(2048) NOT NULL
OPTIONS(description='The parameters provided to python procedure as json format'),
log_lvl_cd STRING(20) NOT NULL OPTIONS(description='The level of logging I -> Information E-> Error ...'),
python_proc_status_cd STRING(20) NOT NULL
OPTIONS(description='The status_2 of python procedure if run is successful or not'),
log_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp, the log event  is inserted into the table'),
PRIMARY KEY (sf_role_user_name, mstr_env_name, mstr_proj_nr, mstr_sec_filter_template_name, python_proc_name,
 python_proc_step_name, log_tmsp) NOT ENFORCED
)
OPTIONS(description='Log table which contains the information for all steps in Python script. The table is valuable later for debugging in case of error');