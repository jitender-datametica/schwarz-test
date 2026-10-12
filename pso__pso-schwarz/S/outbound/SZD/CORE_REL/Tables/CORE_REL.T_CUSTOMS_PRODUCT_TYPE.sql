/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_PRODUCT_TYPE
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:56:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_customs_product_type (
customs_product_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs product type.'),
customs_product_type_descr STRING(250) OPTIONS(description='A brief description of the customs product type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (customs_product_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - The customs type defines all kinds of possible customs products, like a GTS or WWT customs product. - Source - Manual');