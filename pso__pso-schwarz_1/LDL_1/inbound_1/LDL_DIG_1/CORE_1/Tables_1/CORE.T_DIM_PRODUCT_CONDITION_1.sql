/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_CONDITION_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 27. Juni 2023 09:33:00
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PRODUCT_CONDITION_1 (
   PROD_CONDITION_CD                   VARCHAR(20)     NOT NULL COMMENT 'The condition code of the product. (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping)',
   PROD_CONDITION_DESCR                VARCHAR(250)    NOT NULL COMMENT 'A textual description for the condition code of the product.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_CONDITION PRIMARY KEY (PROD_CONDITION_CD) NOT ENFORCED
 )  COMMENT= 'This table contains the descriptions of the different product condition codes (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping).';
