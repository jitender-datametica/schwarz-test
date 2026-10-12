CREATE OR REPLACE TABLE szd_production_core_rel.t_customs_tariff_code_type_definition_1 (
customs_tariff_code_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs tariff code type.'),
customs_tariff_category_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs tariff category.'),
definition_seq INTEGER NOT NULL OPTIONS(description='The sequence number of the definition.'),
lower_bound STRING(250) NOT NULL
OPTIONS(description='The lowest customs tariff code for this customs tariff code type.'),
upper_bound STRING(250) NOT NULL
OPTIONS(description='The highest customs tariff code for this customs tariff code type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (customs_tariff_code_type_cd, customs_tariff_category_cd, definition_seq) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Defines the patterns and ranges of customs tariff codes for the customs tariff code types. - Source - Manual');