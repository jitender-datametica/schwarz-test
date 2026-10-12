/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_LEGACY_SHOP_CATEGORY_RESPONSIBLE
   GENERATED FROM POWERDESIGNER ON Donnerstag, 31. August 2023 12:11:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_legacy_shop_category_responsible (
prod_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country independent'),
legacy_prod_brick_cd STRING(40)
OPTIONS(description='The brickcode at the time of storing the legacy data. the brickcode is a unique standardized code of all categories in the gs1 article categorization system on level 4 and is maintained for every article in sap.'),
legacy_prod_manager_cd STRING(100)
OPTIONS(description='Legacy product manager code (when based on prod_brick_cd)  indentifiyng the product manager. Until availability of actual code value we will be using the name of the manager as a code.'),
legacy_prod_manager_name STRING(100)
OPTIONS(description='Legacy product manager name (when based on prod_brick_cd)  indentifiyng the product manager. Full name (first name + family name) of the product manager'),
legacy_prod_group_ldt_cd STRING(50)
OPTIONS(description='The LDT group of products, based on product family or brick code'),
legacy_dt DATE
OPTIONS(description='Date when the legacy data for brickcode and organisation level were stored in the table'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (prod_sid) NOT ENFORCED
)
OPTIONS(description='It contains the legacy association between products and product manager,  product group LDT base on brick_codes');