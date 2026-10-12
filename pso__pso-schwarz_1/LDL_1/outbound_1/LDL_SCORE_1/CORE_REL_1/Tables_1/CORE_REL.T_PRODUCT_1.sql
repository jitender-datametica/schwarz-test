--==============================================================
-- Table: t_product_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_product_1
   generated from Powerdesigner on Donnerstag, 6. Juni 2024 10:04:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_product_1 (
product_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
product_status_cd STRING(20) OPTIONS(description='The code for the status_1 of the product.'),
bus_country_cd STRING(2)
OPTIONS(description='A two-character code according to the business definition of Kaufland or Lidl.'),
product_type_cd STRING(20) OPTIONS(description='A code for the type of the product e.g. TRADE.'),
product_nr STRING(20) OPTIONS(description='The number by which the product is known.'),
int_product_nr STRING(20) OPTIONS(description='The number by which the product is known internationally.'),
product_name STRING(100) OPTIONS(description='The name by which the product is known.'),
int_product_name STRING(100) OPTIONS(description='The name by which the product is known internationally.'),
nonfood_fg BOOL OPTIONS(description='Indicates, whether it is a nonfood product.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (product_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='This entity contains all products that are purchased and/or sold.');