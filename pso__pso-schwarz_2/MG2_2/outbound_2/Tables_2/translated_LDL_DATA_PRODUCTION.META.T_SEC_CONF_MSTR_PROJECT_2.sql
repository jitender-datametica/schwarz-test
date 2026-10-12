CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_conf_mstr_project_2 (
mstr_proj_nr STRING(32) NOT NULL
OPTIONS(description='The Project ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_proj_name STRING(255) NOT NULL OPTIONS(description='The Name of the Project default metadata language'),
mstr_security_filter_folder_nr STRING(32) NOT NULL
OPTIONS(description='The Folder ID where the security filters will be created in (represents the GUID from MicroStrategy-Metadata'),
mstr_security_filter_prefix_txt STRING(255) NOT NULL
OPTIONS(description='The prefix of security filters, which always be added at beginning during creation'),
mstr_data_user_grp_prefix_txt STRING(255) NOT NULL
OPTIONS(description='The prefix of data user group, which always be added at beginning during creation '),
mstr_siam_user_grp_prefix_txt STRING(255) NOT NULL
OPTIONS(description='The prefix of siam user group name, which always be added at beginning during creation'),
mstr_siam_user_grp_lvl_cd STRING(20) NOT NULL
OPTIONS(description='The column is currently not in use, it is reserved to know, level of organisation unit_2, where security filters can be necessary'),
conf_tmsp TIMESTAMP OPTIONS(description='The timestamp, the configuration is updated or inserted'),
PRIMARY KEY (mstr_proj_nr) NOT ENFORCED
)
OPTIONS(description='The configuration table which contains the information about the projects for row level security synch.');