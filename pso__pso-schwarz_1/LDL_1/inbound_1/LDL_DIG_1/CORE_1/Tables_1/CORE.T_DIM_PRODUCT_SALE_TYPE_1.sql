/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_SALE_TYPE_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 15. August 2024 08:14:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PRODUCT_SALE_TYPE_1 (
   PROD_SALE_TYPE_CD                   VARCHAR(5)      NOT NULL COMMENT 'This code shows if the product is sold as a single item_1 (SI), group article header (GH) - also referred to as "bundle header", or as a group article component (GC) - also referred to as "bundle component"',
   PROD_SALE_TYPE_DESCR                VARCHAR(250)    NOT NULL COMMENT 'The description for the product sale type (e.g. SI - single item_1)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_PRODUCT_SALE_TYPE PRIMARY KEY (PROD_SALE_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'This minor dimension defines how the product is being sold - as a single item_1 (SI), group article header (GH) - also referred to as "bundle header", or as a group article component (GC) - also referred to as "bundle component"';
