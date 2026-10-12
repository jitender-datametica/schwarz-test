CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_mstr_grant_run_log_steps_1 (
mstr_obj_sid INTEGER NOT NULL
OPTIONS(description='The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups'),
mstr_bus_user_grp_sid INTEGER NOT NULL
OPTIONS(description='The surrogate key of business user groups will be created in MicroStrategy Environment'),
mstr_env_name STRING(255) NOT NULL OPTIONS(description='The Environment (D/Q/P) where the synchoronization ran already'),
log_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp, the log event  is inserted into the table'),
python_proc_name STRING(255) NOT NULL
OPTIONS(description='The name of the python procedure where the log entiries are coming'),
python_proc_step_name STRING(255) NOT NULL
OPTIONS(description='The current step in the python procedure where the log entiries are coming'),
python_proc_param_txt STRING(2048) NOT NULL
OPTIONS(description='The parameters provided to python procedure as json format'),
mstr_proj_nr STRING(32) NOT NULL
OPTIONS(description='The Project ID, which represents the GUID from MicroStrategy-Metadata'),
log_type_cd STRING(20) NOT NULL OPTIONS(description='The level of logging I -> Information E-> Error ...'),
python_proc_status_cd STRING(20) NOT NULL
OPTIONS(description='The status_1 of python procedure if run is successful or not'),
PRIMARY KEY (mstr_obj_sid, mstr_bus_user_grp_sid, mstr_env_name, python_proc_name, python_proc_step_name, log_tmsp)
NOT ENFORCED
)
OPTIONS(description='Log table which contains the information for all steps in Python script. The table is valuable later for debugging in case of error');