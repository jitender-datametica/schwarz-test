--==============================================================
-- Table: t_dim_product_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_product_2
   generated from Powerdesigner on Donnerstag, 8. August 2024 10:41:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_product_2 (
product_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
bus_country_cd STRING(2) OPTIONS(description='Business country_2 to which the good is dedicated to'),
product_nr STRING(20) OPTIONS(description='The number by which the product is known.'),
int_product_nr STRING(20) OPTIONS(description='The number by which the product is known internationally.'),
product_name STRING(100) OPTIONS(description='The name by which the product is known.'),
int_product_name STRING(100) OPTIONS(description='The name by which the product is known internationally.'),
nonfood_fg BOOL OPTIONS(description='Indicates, whether it is a nonfood product.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (product_sid) NOT ENFORCED
) OPTIONS(description='The products that are used in a dispo order. ');