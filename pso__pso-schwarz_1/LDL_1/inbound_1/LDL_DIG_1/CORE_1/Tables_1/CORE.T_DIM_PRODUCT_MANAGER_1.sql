/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_MANAGER_1
   GENERATED FROM POWERDESIGNER ON Freitag, 12. Mai 2023 16:09:20
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PRODUCT_MANAGER_1 (
   PROD_MANAGER_CD                     VARCHAR(100)    NOT NULL COMMENT 'A code indentifiyng the product manager. Util we have actual code value we will be using the name of the manager as a code',
   PROD_MANAGER_NAME                   VARCHAR(100)    COMMENT 'Full name (first name + family name) of the product manager',
   PROD_MANAGER_TEAM                   VARCHAR(100)    COMMENT 'Name of the team to which the product manager belongs',
   PROD_MANAGER_TEAM_LEAD              VARCHAR(100)    COMMENT 'Full name (first name + family name) of the person who is the leader of the product management team',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_MANAGER PRIMARY KEY (PROD_MANAGER_CD) NOT ENFORCED
 )  COMMENT= 'A minor dimension that contains Product Managers.  Product manager is responsible for ordering of products, placing them in promotions, etc..';
