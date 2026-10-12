/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_CONDITION
   GENERATED FROM POWERDESIGNER ON Dienstag, 27. Juni 2023 09:33:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_condition (
prod_condition_cd STRING(20) NOT NULL
OPTIONS(description='The condition code of the product. (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping)'),
prod_condition_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the condition code of the product.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_condition_cd) NOT ENFORCED
)
OPTIONS(description='This table contains the descriptions of the different product condition codes (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping).');