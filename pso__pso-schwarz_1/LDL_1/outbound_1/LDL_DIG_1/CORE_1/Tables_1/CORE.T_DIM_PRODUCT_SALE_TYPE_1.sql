/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_SALE_TYPE_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 15. August 2024 08:14:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_sale_type_1 (
prod_sale_type_cd STRING(5) NOT NULL
OPTIONS(description='This code shows if the product is sold as a single item_1 (SI), group article header (GH) - also referred to as "bundle header", or as a group article component (GC) - also referred to as "bundle component"'),
prod_sale_type_descr STRING(250) NOT NULL
OPTIONS(description='The description for the product sale type (e.g. SI - single item_1)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_sale_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines how the product is being sold - as a single item_1 (SI), group article header (GH) - also referred to as "bundle header", or as a group article component (GC) - also referred to as "bundle component"');