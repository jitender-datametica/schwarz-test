CREATE TABLE IF NOT EXISTS ldl_data_meta.t_sec_conf_mstr_business_user_group (
mstr_bus_user_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The surrogate key of business user groups will be created in MicroStrategy Environment'),
mstr_bus_user_grp_nr STRING(32)
OPTIONS(description='The User Group ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_bus_user_grp_name STRING(255) NOT NULL
OPTIONS(description='The Name of the MicroStrategy User Group default metadata language'),
mstr_bus_user_grp_siam_name STRING(255) NOT NULL
OPTIONS(description='The Name of the MicroStrategy User Group in SIAM default metadata language'),
user_grp_type_cd STRING(20) NOT NULL
OPTIONS(description='The Type of the Business User Group, if it is Ressort or Functional Group.'),
conf_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp, the configuration is updated or inserted'),
PRIMARY KEY (mstr_bus_user_grp_sid) NOT ENFORCED
)
OPTIONS(description='The configuration table which contains the information about business user groups for object security');