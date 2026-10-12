/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_PRODUCT_DIVISION_TYPE
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_product_division_type (
product_division_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - Code for the type of product categorisation  ( TEX, HG )'),
product_division_type_descr STRING(250) NOT NULL
OPTIONS(description='Description for the type of product categorisation  ( Textil or Hard goods article )'),
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
OPTIONS(description='Minor Dimension - The product categorisation  ( Short for Textil or Hard goods article ). - Source - VMT');