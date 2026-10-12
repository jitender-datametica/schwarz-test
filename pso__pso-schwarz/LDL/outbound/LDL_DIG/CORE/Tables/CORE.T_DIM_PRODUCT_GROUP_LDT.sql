/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_GROUP_LDT
   GENERATED FROM POWERDESIGNER ON Donnerstag, 31. August 2023 10:51:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_group_ldt (
prod_group_ldt_cd STRING(50) NOT NULL
OPTIONS(description='The LDT group of products, based on product family or brick code'),
prod_group_ldt_descr STRING(250) OPTIONS(description='A textual description for the LDT product group'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_group_ldt_cd) NOT ENFORCED
)
OPTIONS(description='The LDT (Lidl Digital Trading) group of products, based on product family or brick code - one of the LD classification for the products (Beauty , Werkzeug, etc)');