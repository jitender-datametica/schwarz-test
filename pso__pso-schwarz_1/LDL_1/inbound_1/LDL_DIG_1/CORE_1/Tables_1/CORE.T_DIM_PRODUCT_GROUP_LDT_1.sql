/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_GROUP_LDT_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 31. August 2023 10:51:17
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PRODUCT_GROUP_LDT_1 (
   PROD_GROUP_LDT_CD                   VARCHAR(50)     NOT NULL COMMENT 'The LDT group of products, based on product family or brick code',
   PROD_GROUP_LDT_DESCR                VARCHAR(250)    COMMENT 'A textual description for the LDT product group',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_GROUP_LDT PRIMARY KEY (PROD_GROUP_LDT_CD) NOT ENFORCED
 )  COMMENT= 'The LDT (Lidl Digital Trading) group of products, based on product family or brick code - one of the LD classification for the products (Beauty , Werkzeug, etc)';
