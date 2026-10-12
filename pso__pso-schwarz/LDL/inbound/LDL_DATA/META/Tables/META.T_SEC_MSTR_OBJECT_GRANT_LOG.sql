CREATE TABLE META.T_SEC_MSTR_OBJECT_GRANT_LOG (
   mstr_obj_sid                        NUMERIC(38,0)   NOT NULL COMMENT 'The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups' 
 , mstr_bus_user_grp_sid               NUMERIC(38,0)   NOT NULL COMMENT 'The surrogate key of business user groups will be created in MicroStrategy Environment' 
 , mstr_env_name                       VARCHAR(255)    NOT NULL COMMENT 'The Environment (D/Q/P) where the synchoronization ran already' 
 , log_tmsp                            TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the log event  is inserted into the table' 
 , mstr_proj_nr                        VARCHAR(32)     NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata' 
 , sync_type_cd                        VARCHAR(20)     COMMENT 'The type of the synchronisation as revode or grant' 
 , sync_status_cd                      VARCHAR(20)     NOT NULL COMMENT 'The status (OK/ERR) if the synchoronization is successful or not' 
 , sync_error_msg_txt                  VARCHAR(1000)   COMMENT 'The Error Message if the synchoronization is unsuccessful' 
 , log_valid_fg                        BOOLEAN         NOT NULL COMMENT 'The current valid entry to identify current status of synchoronization for a snowflake group/user project' 
 , CONSTRAINT PK_T_SEC_MSTR_OBJECT_GRANT_LOG PRIMARY KEY (mstr_obj_sid, mstr_bus_user_grp_sid, mstr_env_name, log_tmsp) NOT ENFORCED
 )  COMMENT= 'Log table which contains the information, when the grants on objects are synchoronized from snowflake to mstr project';