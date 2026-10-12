CREATE OR REPLACE TABLE szd_production_core.t_dim_customs_declaration_type_2 (
customs_declaration_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the type of the customs declaration'),
customs_declaration_type_descr STRING(250) NOT NULL
OPTIONS(description='The name of the type of the customs declaration.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (customs_declaration_type_cd) NOT ENFORCED
) OPTIONS(description='Minor Dimension - Defines the types of declaration categories. - Source - Manual');