/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_PRODUCT_DIVISION_TYPE
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PRODUCT_DIVISION_TYPE (
   PRODUCT_DIVISION_TYPE_CD            VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - Code for the type of product categorisation  ( TEX, HG )',
   PRODUCT_DIVISION_TYPE_DESCR         VARCHAR(250)    NOT NULL COMMENT 'Description for the type of product categorisation  ( Textil or Hard goods article )',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_DIM_PRODUCT_DIVISION_TYPE PRIMARY KEY (PRODUCT_DIVISION_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - The product categorisation  ( Short for Textil or Hard goods article ). - Source - VMT';
