/* --------------------------------------------------------------------------------
   DDL for table: T_PRODUCT_DIVISION_TYPE_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_product_division_type_2 (
product_division_type_cd STRING(50) NOT NULL
OPTIONS(description='Code for the type of product categorisation  ( TEX, HG )'),
product_division_type_desc STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - Description for the type of product categorisation  ( Textil or Hard goods article )'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (product_division_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - The product categorisation  ( Short for Textil or Hard goods article ) - Source - VMT');