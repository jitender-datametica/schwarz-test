CREATE TABLE META.T_SEC_MSTR_RUN_LOG_STEPS_2 (
    sf_role_user_name                   VARCHAR(255)    NOT NULL COMMENT 'The Snowflake Role or User name which is synchoronized to MicroStrategy Project' 
 ,  mstr_env_name                       VARCHAR(255)    NOT NULL COMMENT 'The Environment (D/Q/P) where the synchoronization ran already' 
 ,  mstr_proj_nr                        VARCHAR(32)     NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata' 
 ,  mstr_sec_filter_template_name       VARCHAR(255)    NOT NULL COMMENT 'The name of the security filter (also kind of Identifier)' 
 ,  python_proc_name                    VARCHAR(255)    NOT NULL COMMENT 'The name of the python procedure where the log entiries are coming' 
 ,  python_proc_step_name               VARCHAR(255)    NOT NULL COMMENT 'The current step in the python procedure where the log entiries are coming' 
 ,  python_proc_param_txt               VARCHAR(2048)   NOT NULL COMMENT 'The parameters provided to python procedure as json format' 
 ,  log_lvl_cd                          VARCHAR(20)     NOT NULL COMMENT 'The level of logging I -> Information E-> Error ...' 
 ,  python_proc_status_cd               VARCHAR(20)     NOT NULL COMMENT 'The status_2 of python procedure if run is successful or not' 
 ,  log_tmsp                            TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the log event  is inserted into the table' 
 ,  CONSTRAINT PK_T_SEC_MSTR_RUN_LOG_STEPS PRIMARY KEY (sf_role_user_name, mstr_env_name, mstr_proj_nr, mstr_sec_filter_template_name, python_proc_name, python_proc_step_name, log_tmsp) NOT ENFORCED
 )  COMMENT= 'Log table which contains the information for all steps in Python script. The table is valuable later for debugging in case of error';
