/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CUSTOMS_TARIFF_NUMBER
   generated from Powerdesigner on Mittwoch, 2. August 2023 11:09:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_customs_tariff_number (
customs_classification_scheme_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the customs classification scheme.'),
customs_tariff_number_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the type of the customs tariff number.'),
customs_tariff_number_descr STRING(250) OPTIONS(description='The name of the type of the customs tariff number.'),
food_nonfood_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the Food/Nonfood Type.'),
food_nonfood_type_name STRING(100) NOT NULL OPTIONS(description='The name of the Food/Nonfood Type.'),
alcoholic_beverage_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the Alcoholic Beverage Type.'),
alcoholic_beverage_type_name STRING(100) NOT NULL OPTIONS(description='The name of the Alcoholic Beverage Type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (customs_classification_scheme_cd, customs_tariff_number_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - Contains the customs tariff numbers for a classification schema. - Source - Manual');