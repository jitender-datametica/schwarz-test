CREATE TABLE META.T_SEC_CONF_MSTR_PROJECT_2 (
    mstr_proj_nr                        VARCHAR(32)     NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata' 
  , mstr_proj_name                      VARCHAR(255)    NOT NULL COMMENT 'The Name of the Project default metadata language' 
  , mstr_security_filter_folder_nr      VARCHAR(32)     NOT NULL COMMENT 'The Folder ID where the security filters will be created in (represents the GUID from MicroStrategy-Metadata' 
  , mstr_security_filter_prefix_txt     VARCHAR(255)    NOT NULL COMMENT 'The prefix of security filters, which always be added at beginning during creation' 
  , mstr_data_user_grp_prefix_txt       VARCHAR(255)    NOT NULL COMMENT 'The prefix of data user group, which always be added at beginning during creation ' 
  , mstr_siam_user_grp_prefix_txt       VARCHAR(255)    NOT NULL COMMENT 'The prefix of siam user group name, which always be added at beginning during creation' 
  , mstr_siam_user_grp_lvl_cd           VARCHAR(20)     NOT NULL COMMENT 'The column is currently not in use, it is reserved to know, level of organisation unit_2, where security filters can be necessary' 
  , conf_tmsp                           TIMESTAMP_LTZ(9) COMMENT 'The timestamp, the configuration is updated or inserted' 
  , CONSTRAINT PK_T_SEC_CONF_MSTR_PROJECT PRIMARY KEY (mstr_proj_nr) NOT ENFORCED
 )  COMMENT= 'The configuration table which contains the information about the projects for row level security synch.';