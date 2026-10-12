/* --------------------------------------------------------------------------------
   DDL for table: T_PRODUCT_GROUP_KEY_TYPE_2
   generated from Powerdesigner on Donnerstag, 13. Februar 2025 08:50:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_PRODUCT_GROUP_KEY_TYPE_2 (
   PRODUCT_GROUP_KEY_TYPE_CD           VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the product.',
   PRODUCT_GROUP_KEY_TYPE_NAME         VARCHAR(100)    NOT NULL COMMENT 'The name of the type of natural key which identifies the product.',
   PRODUCT_GROUP_KEY_TYPE_DESCR        VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_PRODUCT_GROUP_KEY_TYPE PRIMARY KEY (PRODUCT_GROUP_KEY_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Metadata - Keytable - Product Instance Group - Contains the types that shares the key space for the subject area "Product".';
