/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_PRODUCT_ASSORTMENT_LIFECYCLE_1
   GENERATED FROM POWERDESIGNER ON Montag, 22. August 2022 13:44:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_product_assortment_lifecycle_1 (
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
prod_assortment_lifecycle_cat_cd STRING(25) NOT NULL
OPTIONS(description='The code for the detailed category of is a NIS/ADS categorisation  ( ex. Artikelanlage, End Of Life, etc)'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
prod_assortment_lifecycle_cd STRING(5)
OPTIONS(description='The code for the indicating if product is “new in sortiment” (NIS) and “leaving the sortiment” (ADS). '),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (prod_variant_sid, wshop_cd, prod_assortment_lifecycle_cat_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This dimension defines if product is a new “new in sortiment” (NIS) and “leaving the sortiment” (ADS). ');