/* --------------------------------------------------------------------------------
   DDL for table: T_SALES_VARIANT_GROUP_1
   generated from Powerdesigner on Dienstag, 1. April 2025 13:51:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_sales_variant_group_1 (
product_group_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Major Entity - The sales_1 variant group is a special product group for sales_1 variants. - Source - LExIS'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
sales_variant_group_type_cd STRING(50) OPTIONS(description='The unique code of the sales_1 variant group type.'),
sales_variant_group_nr STRING(250) NOT NULL OPTIONS(description='The business identifier of the sales_1 variant group.'),
sales_variant_group_name STRING(100) NOT NULL
OPTIONS(description='Descriptive attribute - The name of the group of products'),
sales_variant_group_desc STRING(250)
OPTIONS(description='Descriptive attribute - A short description of the group of products'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (product_group_sid, lang_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - The sales_1 variant group is a special product group for sales_1 variants. - Source - LExIS');