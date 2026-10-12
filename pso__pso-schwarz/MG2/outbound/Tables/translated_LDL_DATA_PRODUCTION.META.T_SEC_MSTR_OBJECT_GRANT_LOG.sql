CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_mstr_object_grant_log (
mstr_obj_sid INTEGER NOT NULL
OPTIONS(description='The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups'),
mstr_bus_user_grp_sid INTEGER NOT NULL
OPTIONS(description='The surrogate key of business user groups will be created in MicroStrategy Environment'),
mstr_env_name STRING(255) NOT NULL OPTIONS(description='The Environment (D/Q/P) where the synchoronization ran already'),
log_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp, the log event  is inserted into the table'),
mstr_proj_nr STRING(32) NOT NULL
OPTIONS(description='The Project ID, which represents the GUID from MicroStrategy-Metadata'),
sync_type_cd STRING(20) OPTIONS(description='The type of the synchronisation as revode or grant'),
sync_status_cd STRING(20) NOT NULL
OPTIONS(description='The status (OK/ERR) if the synchoronization is successful or not'),
sync_error_msg_txt STRING(1000) OPTIONS(description='The Error Message if the synchoronization is unsuccessful'),
log_valid_fg BOOL NOT NULL
OPTIONS(description='The current valid entry to identify current status of synchoronization for a snowflake group/user project'),
PRIMARY KEY (mstr_obj_sid, mstr_bus_user_grp_sid, mstr_env_name, log_tmsp) NOT ENFORCED
)
OPTIONS(description='Log table which contains the information, when the grants on objects are synchoronized from snowflake to mstr project');