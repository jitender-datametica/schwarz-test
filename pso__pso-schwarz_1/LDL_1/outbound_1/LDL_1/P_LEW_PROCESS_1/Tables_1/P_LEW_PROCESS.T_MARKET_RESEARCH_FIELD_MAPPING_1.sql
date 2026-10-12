CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_market_research_field_mapping_1 (
country_cd STRING(2) NOT NULL
OPTIONS(description='The code which identifies a country_1 (as defined by a provider of market research data'),
file_name_prefix STRING(20) NOT NULL
OPTIONS(description='File name prefix which differentiates the files among delivery files for the same country_1'),
topic STRING(100) NOT NULL OPTIONS(description='Data topic (typically: field name)'),
hierarchy_level_name STRING(100) NOT NULL OPTIONS(description='Hierarchy_1 level name'),
target_expression STRING(200) NOT NULL OPTIONS(description='Name space code for source system key'),
remark STRING(200) OPTIONS(description='Remark for this entry'),
error_msg STRING(200) OPTIONS(description='Error message on violation of this entry'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (country_cd, topic, hierarchy_level_name) NOT ENFORCED
) OPTIONS(description='Mapping table for XSIGHT fields');