CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_conf_mstr_sec_filter_template_2 (
mstr_proj_nr STRING(32) NOT NULL
OPTIONS(description='The Project ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_sec_filter_template_name STRING(255) NOT NULL
OPTIONS(description='The name of the security filter (also kind of Identifier)'),
mstr_sec_filter_extension_txt STRING(255) NOT NULL
OPTIONS(description='The name extension of security filter, which will be append to prefix defined at project level'),
sf_role_user_lvl_cd STRING(20) NOT NULL
OPTIONS(description='The level of the organisation unit_2 COUNTRY_2/SALES_2 COMPANY/SALES_2 MANAGER... that the security filter is used'),
conf_tmsp TIMESTAMP OPTIONS(description='The timestamp, the configuration is updated or inserted'),
PRIMARY KEY (mstr_proj_nr, mstr_sec_filter_template_name) NOT ENFORCED
)
OPTIONS(description='The configuration table which contains the relationship which security filter is set to which organisation unit_2');