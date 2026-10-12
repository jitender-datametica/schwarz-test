CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_conf_mstr_filter_predicate_2 (
mstr_proj_nr STRING(32) NOT NULL
OPTIONS(description='The Project ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_predicate_name STRING(255) NOT NULL OPTIONS(description='The name of predicate (behaves like identifier)'),
predicate_type_cd STRING(20) NOT NULL
OPTIONS(description='The type of predicate automic when it is real condition is and complex when it is built on two other predicates'),
mstr_predicate_left_child_name STRING(255)
OPTIONS(description='The name of the predicate on left side for complex predicates : <LEFT Predicate> <AND/OR> <RIGHT Predicate>'),
mstr_predicate_right_child_name STRING(255)
OPTIONS(description='The name of the predicate on right side for complex predicates : <LEFT Predicate> <AND/OR> <RIGHT Predicate>'),
predicate_function_nr STRING(255)
OPTIONS(description='The function for the automic predicates like Equals, Greater, In ... '),
mstr_attr_unique_nr STRING(512)
OPTIONS(description='The Unique Id of the row via concetanation of Project ID,Attribute ID and Attribute form name'),
mstr_attr_nr STRING(32) OPTIONS(description='The Attribute ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_attr_name STRING(255) OPTIONS(description='The Name of the attribute in default metadata language of project'),
mstr_attr_form_name STRING(255)
OPTIONS(description='The Name of the attribute form name in default metadata language of project'),
mstr_attr_form_name_datatype_cd STRING(255)
OPTIONS(description='The Data type of the attribute form like string, number (it is set via list from frontend)'),
predicate_param_name STRING(255)
OPTIONS(description='The predicate is created for varios values and this column specifies how the value of a condition is set in predicate. E.g. to determine Iso code value for a country_2 of a predicate as in Land_2@ISO= DE '),
conf_tmsp TIMESTAMP OPTIONS(description='The timestamp, the configuration is updated or inserted'),
PRIMARY KEY (mstr_proj_nr, mstr_predicate_name) NOT ENFORCED
)
OPTIONS(description='The configuration table which contains the information about a predicate of security filter, how a filter condition will be created');