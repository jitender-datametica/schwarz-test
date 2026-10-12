CREATE OR REPLACE TABLE szd_production_core.t_dim_declarant_type_2 (
declarant_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the type of declarant.'),
declarant_type_name STRING(100) NOT NULL OPTIONS(description='The name of the type of the declarant.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (declarant_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - Defines what types of parties can act as declarants to a customs authority. - Source - Manual');