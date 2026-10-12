CREATE TABLE META.T_SEC_MSTR_FIL_SYNC_LOG_1 (
    sf_role_user_name                   VARCHAR(255)    NOT NULL COMMENT 'The Snowflake Role or User name which is synchoronized to MicroStrategy Project' 
 ,  mstr_env_name                       VARCHAR(255)    NOT NULL COMMENT 'The Environment (D/Q/P) where the synchoronization ran already' 
 ,  mstr_proj_nr                        VARCHAR(32)     NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata' 
 ,  mstr_sec_filter_template_name       VARCHAR(255)    NOT NULL COMMENT 'The name of the security filter (also kind of Identifier)' 
 ,  mstr_security_filter_name           VARCHAR(255)    NOT NULL COMMENT 'The complete name of the security filter that is created on MicroStrategy Project' 
 ,  mstr_security_filter_nr             VARCHAR(32)     NOT NULL COMMENT 'The Security Filter ID, which represents the GUID from MicroStrategy-Metadata' 
 ,  mstr_data_user_grp_name             VARCHAR(255)    NOT NULL COMMENT 'The complete data user group name that is created for MicroStrategy Project' 
 ,  mstr_data_user_grp_nr               VARCHAR(32)     NOT NULL COMMENT 'The data user group ID, which represents the GUID from MicroStrategy-Metadata' 
 ,  mstr_siam_user_grp_name             VARCHAR(255)    NOT NULL COMMENT 'The complete siam user group name that is created for MicroStrategy Project' 
 ,  mstr_siam_user_grp_nr               VARCHAR(32)     NOT NULL COMMENT 'The siam user group ID, which represents the GUID from MicroStrategy-Metadata' 
 ,  log_tmsp                            TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the log event  is inserted into the table' 
 ,  sync_status_cd                      VARCHAR(20)     NOT NULL COMMENT 'The status_1 (OK/ERR) if the synchoronization is successful or not' 
 ,  sync_error_msg_txt                  VARCHAR(1000)   COMMENT 'The Error Message if the synchoronization is unsuccessful' 
 ,  log_valid_fg                        BOOLEAN         NOT NULL COMMENT 'The current valid entry to identify current status_1 of synchoronization for a snowflake group/user project' 
 ,  CONSTRAINT PK_T_SEC_MSTR_FIL_SYNC_LOG PRIMARY KEY (sf_role_user_name, mstr_env_name, mstr_proj_nr, mstr_sec_filter_template_name, log_tmsp, log_valid_fg) NOT ENFORCED
 )  COMMENT= 'Log table which contains the information, when the security filters are synchoronized from snowflake to mstr project';