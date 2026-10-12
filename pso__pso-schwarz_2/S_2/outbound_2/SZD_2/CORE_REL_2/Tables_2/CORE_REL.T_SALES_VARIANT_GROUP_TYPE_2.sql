/* --------------------------------------------------------------------------------
   DDL for table: T_SALES_VARIANT_GROUP_TYPE_2
   generated from Powerdesigner on Donnerstag, 27. März 2025 10:46:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_sales_variant_group_type_2 (
sales_variant_group_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the sales_2 variant group type.'),
sales_variant_group_type_name STRING(100) NOT NULL OPTIONS(description='The name of the sales_2 variant group type.'),
sales_variant_group_type_desc STRING(250) NOT NULL
OPTIONS(description='A brief description of the sales_2 variant group type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source.'),
PRIMARY KEY (sales_variant_group_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Describes the type of the sales_2 variant group. Different types of sales_2 variant group can be related in a hierarchy. - Source - Manual');