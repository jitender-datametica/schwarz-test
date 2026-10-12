/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_LEGACY_PRODUCT_ORGANISATION_LEVEL_1
   GENERATED FROM POWERDESIGNER ON Montag, 19. Juni 2023 12:20:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_legacy_product_organisation_level_1 (
prod_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_1 independent.'),
prod_brick_cd STRING(40)
OPTIONS(description='The Brickcode at the time of storing the legacy data. The Brickcode is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. '),
prod_org_lvl_name STRING(50)
OPTIONS(description='The legacy organisation level (when based on prod_brick_cd) of a product corresponds to the lidl digital structure which owns - or is responsible for - these articles (product variants) in the organization. '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_sid) NOT ENFORCED
)
OPTIONS(description='The table contains the legacy association between products and organisation level based on brick_codes');