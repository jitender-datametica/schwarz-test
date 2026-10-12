/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_LEGACY_SHOP_CATEGORY_RESPONSIBLE_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 31. August 2023 12:11:52
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_LEGACY_SHOP_CATEGORY_RESPONSIBLE_2 (
   PROD_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product',
   PROD_NR                             VARCHAR(20)     COMMENT 'The number for internal onlineshop product, which is country_2 independent',
   LEGACY_PROD_BRICK_CD                VARCHAR(40)     COMMENT 'The brickcode at the time of storing the legacy data. the brickcode is a unique standardized code of all categories in the gs1 article categorization system on level 4 and is maintained for every article in sap.',
   LEGACY_PROD_MANAGER_CD              VARCHAR(100)    COMMENT 'Legacy product manager code (when based on prod_brick_cd)  indentifiyng the product manager. Until availability of actual code value we will be using the name of the manager as a code.',
   LEGACY_PROD_MANAGER_NAME            VARCHAR(100)    COMMENT 'Legacy product manager name (when based on prod_brick_cd)  indentifiyng the product manager. Full name (first name + family name) of the product manager',
   LEGACY_PROD_GROUP_LDT_CD            VARCHAR(50)     COMMENT 'The LDT group of products, based on product family or brick code',
   LEGACY_DT                           DATE            COMMENT 'Date when the legacy data for brickcode and organisation level were stored in the table',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_LEGACY_SHOP_CATEGORY_RESPONSIBLE PRIMARY KEY (PROD_SID) NOT ENFORCED
 )  COMMENT= 'It contains the legacy association between products and product manager,  product group LDT base on brick_codes';
