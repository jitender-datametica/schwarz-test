CREATE TABLE IF NOT EXISTS ldl_data_meta.t_sec_mstr_fil_sync_log_2 (
sf_role_user_name STRING(255) NOT NULL
OPTIONS(description='The Snowflake Role or User name which is synchoronized to MicroStrategy Project'),
mstr_env_name STRING(255) NOT NULL OPTIONS(description='The Environment (D/Q/P) where the synchoronization ran already'),
mstr_proj_nr STRING(32) NOT NULL
OPTIONS(description='The Project ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_sec_filter_template_name STRING(255) NOT NULL
OPTIONS(description='The name of the security filter (also kind of Identifier)'),
mstr_security_filter_name STRING(255) NOT NULL
OPTIONS(description='The complete name of the security filter that is created on MicroStrategy Project'),
mstr_security_filter_nr STRING(32) NOT NULL
OPTIONS(description='The Security Filter ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_data_user_grp_name STRING(255) NOT NULL
OPTIONS(description='The complete data user group name that is created for MicroStrategy Project'),
mstr_data_user_grp_nr STRING(32) NOT NULL
OPTIONS(description='The data user group ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_siam_user_grp_name STRING(255) NOT NULL
OPTIONS(description='The complete siam user group name that is created for MicroStrategy Project'),
mstr_siam_user_grp_nr STRING(32) NOT NULL
OPTIONS(description='The siam user group ID, which represents the GUID from MicroStrategy-Metadata'),
log_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp, the log event  is inserted into the table'),
sync_status_cd STRING(20) NOT NULL
OPTIONS(description='The status_2 (OK/ERR) if the synchoronization is successful or not'),
sync_error_msg_txt STRING(1000) OPTIONS(description='The Error Message if the synchoronization is unsuccessful'),
log_valid_fg BOOL NOT NULL
OPTIONS(description='The current valid entry to identify current status_2 of synchoronization for a snowflake group/user project'),
PRIMARY KEY (sf_role_user_name, mstr_env_name, mstr_proj_nr, mstr_sec_filter_template_name, log_tmsp, log_valid_fg)
NOT ENFORCED
)
OPTIONS(description='Log table which contains the information, when the security filters are synchoronized from snowflake to mstr project');