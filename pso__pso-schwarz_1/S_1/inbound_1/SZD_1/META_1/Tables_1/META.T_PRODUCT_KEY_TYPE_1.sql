/* --------------------------------------------------------------------------------
   DDL for table: T_PRODUCT_KEY_TYPE_1
   generated from Powerdesigner on Donnerstag, 30. November 2023 09:39:09
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_PRODUCT_KEY_TYPE_1 (
   PRODUCT_KEY_TYPE_CD                 VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the product.',
   PRODUCT_KEY_TYPE_NAME               VARCHAR(100)    NOT NULL COMMENT 'The name of the type of natural key which identifies the product.',
   PRODUCT_KEY_TYPE_DESCR              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_PRODUCT_KEY_TYPE PRIMARY KEY (PRODUCT_KEY_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Metadata - Keytable - Product - Contains the types that shares the key space for the subject area "Product".';

