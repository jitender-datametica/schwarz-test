/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_LEGACY_PRODUCT_ORGANISATION_LEVEL_1
   GENERATED FROM POWERDESIGNER ON Montag, 19. Juni 2023 12:20:55
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_LEGACY_PRODUCT_ORGANISATION_LEVEL_1 (
   PROD_SID                            NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
   PROD_NR                             VARCHAR(20)     COMMENT 'The number for internal onlineshop product, which is country_1 independent.',
   PROD_BRICK_CD                       VARCHAR(40)     COMMENT 'The Brickcode at the time of storing the legacy data. The Brickcode is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. ',
   PROD_ORG_LVL_NAME                   VARCHAR(50)     COMMENT 'The legacy organisation level (when based on prod_brick_cd) of a product corresponds to the lidl digital structure which owns - or is responsible for - these articles (product variants) in the organization. ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_LEGACY_PRODUCT_ORGANISATION_LEVEL PRIMARY KEY (PROD_SID) NOT ENFORCED
 )  COMMENT= 'The table contains the legacy association between products and organisation level based on brick_codes';
