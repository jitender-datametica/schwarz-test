CREATE TABLE META.T_SEC_MSTR_GRANT_RUN_LOG_STEPS_2 (
   mstr_obj_sid                        NUMERIC(38,0)   NOT NULL COMMENT 'The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups' 
  , mstr_bus_user_grp_sid               NUMERIC(38,0)   NOT NULL COMMENT 'The surrogate key of business user groups will be created in MicroStrategy Environment' 
  , mstr_env_name                       VARCHAR(255)    NOT NULL COMMENT 'The Environment (D/Q/P) where the synchoronization ran already' 
  , log_tmsp                            TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the log event  is inserted into the table' 
  , python_proc_name                    VARCHAR(255)    NOT NULL COMMENT 'The name of the python procedure where the log entiries are coming' 
  , python_proc_step_name               VARCHAR(255)    NOT NULL COMMENT 'The current step in the python procedure where the log entiries are coming' 
  , python_proc_param_txt               VARCHAR(2048)   NOT NULL COMMENT 'The parameters provided to python procedure as json format' 
  , mstr_proj_nr                        VARCHAR(32)     NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata' 
  , log_type_cd                         VARCHAR(20)     NOT NULL COMMENT 'The level of logging I -> Information E-> Error ...' 
  , python_proc_status_cd               VARCHAR(20)     NOT NULL COMMENT 'The status_2 of python procedure if run is successful or not' 
  , CONSTRAINT PK_T_SEC_MSTR_GRANT_RUN_LOG_STEPS PRIMARY KEY (mstr_obj_sid, mstr_bus_user_grp_sid, mstr_env_name, python_proc_name, python_proc_step_name, log_tmsp) NOT ENFORCED
 )  COMMENT= 'Log table which contains the information for all steps in Python script. The table is valuable later for debugging in case of error';
