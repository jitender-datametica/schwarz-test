/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_TARIFF_CODE_TYPE_REL_1
   generated from Powerdesigner on Montag, 31. Juli 2023 11:10:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_customs_tariff_code_type_rel_1 (
customs_classification_scheme_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the customs classification scheme.'),
customs_tariff_code_cd STRING(250) NOT NULL OPTIONS(description='The standardized customs tariff code number.'),
customs_tariff_code_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs tariff code type.'),
customs_tariff_category_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs tariff category.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (customs_classification_scheme_cd, customs_tariff_code_cd, customs_tariff_code_type_cd,
 customs_tariff_category_cd) NOT ENFORCED
)
OPTIONS(description='Bridge Table - Contains the associations between customs tariff codes and their types. - Source - Manual');