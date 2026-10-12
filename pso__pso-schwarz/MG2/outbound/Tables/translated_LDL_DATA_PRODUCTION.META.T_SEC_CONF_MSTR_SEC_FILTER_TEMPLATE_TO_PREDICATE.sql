CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_conf_mstr_sec_filter_template_to_predicate (
mstr_proj_nr STRING(32) NOT NULL
OPTIONS(description='The Project ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_sec_filter_template_name STRING(255) NOT NULL
OPTIONS(description='The name of the security filter (also kind of Identifier)'),
mstr_predicate_name STRING(255) NOT NULL OPTIONS(description='The name of predicate (behaves like identifier)'),
conf_tmsp TIMESTAMP OPTIONS(description='The timestamp, the configuration is updated or inserted'),
PRIMARY KEY (mstr_proj_nr, mstr_sec_filter_template_name, mstr_predicate_name) NOT ENFORCED
) OPTIONS(description='The configuration table which contains the relationship which security filter to its predicates');