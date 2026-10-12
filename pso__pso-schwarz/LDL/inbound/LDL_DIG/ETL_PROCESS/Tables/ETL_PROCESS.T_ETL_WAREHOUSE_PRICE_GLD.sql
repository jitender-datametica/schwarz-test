CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PRICE_GLD (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
   PRICE_TYPE_CD                       VARCHAR(20)     NOT NULL COMMENT 'Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc',
   PRICE_GROUP_CD                      VARCHAR(20)     COMMENT 'Code of pricing group - internal or customer facing',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   WH_CD                               VARCHAR(5)      COMMENT 'A short  unique code for warehouse',
   CURR_CD                             VARCHAR(5)      COMMENT 'Currency in which price is set',
   PRICE_VAL                           NUMBER(38, 5)   COMMENT 'Valid price in given currency',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_ETL_WAREHOUSE_PRICE_GLD PRIMARY KEY (WH_SID, PROD_VARIANT_SID, PRICE_TYPE_CD, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'ETL Support table - A fact for prices on warehouse level (GLD)';
