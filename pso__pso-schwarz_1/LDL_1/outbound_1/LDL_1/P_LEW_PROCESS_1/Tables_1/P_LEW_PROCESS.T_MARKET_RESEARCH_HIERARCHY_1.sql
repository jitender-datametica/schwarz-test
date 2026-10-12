CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_market_research_hierarchy_1 (
country_cd STRING(2) NOT NULL
OPTIONS(description='The code which identifies a country_1 (as defined by a provider of market research data'),
file_name_prefix STRING(20) NOT NULL
OPTIONS(description='File name prefix which differentiates the files among delivery files for the same country_1'),
hierarchy_number BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Hierarchy_1 number'),
hierarchy_level BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Hierarchy_1 level'),
dimension STRING(100) NOT NULL OPTIONS(description='Dimension'),
hierarchy_level_name STRING(100) NOT NULL OPTIONS(description='Hierarchy_1 level name'),
column_name STRING(100) NOT NULL OPTIONS(description='Column name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (country_cd, dimension, hierarchy_number, hierarchy_level) NOT ENFORCED
) OPTIONS(description='Mapping table for XSIGHT fields');