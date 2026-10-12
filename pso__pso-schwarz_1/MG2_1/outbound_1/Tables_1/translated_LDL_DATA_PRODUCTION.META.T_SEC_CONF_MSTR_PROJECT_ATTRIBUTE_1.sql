CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_conf_mstr_project_attribute_1 (
mstr_attr_unique_nr STRING(512) NOT NULL
OPTIONS(description='The Unique Id of the row via concetanation of Project ID,Attribute ID and Attribute form name'),
mstr_proj_nr STRING(32) NOT NULL
OPTIONS(description='The Project ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_attr_nr STRING(32) NOT NULL
OPTIONS(description='The Attribute ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_attr_name STRING(255) NOT NULL
OPTIONS(description='The Name of the attribute in default metadata language of project'),
mstr_attr_form_name STRING(255) NOT NULL
OPTIONS(description='The Name of the attribute form name in default metadata language of project'),
mstr_attr_form_name_datatype_cd STRING(255) NOT NULL
OPTIONS(description='The Data type of the attribute form like string, number (it is set via list from frontend)'),
conf_tmsp TIMESTAMP OPTIONS(description='The timestamp, the configuration is updated or inserted'),
PRIMARY KEY (mstr_attr_unique_nr) NOT ENFORCED
)
OPTIONS(description='The configuration table which contains the necessary attributes/attribute forms to create security filters');