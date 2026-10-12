CREATE TABLE ETL_PROCESS.T_ETL_PRODUCT_PRICE_SUPPLIER_REGIONAL (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   CONDITION_NUMBER_CD                 VARCHAR(20),
   PURCH_ORG_TYPE_CD                   VARCHAR(8)      NOT NULL,
   SUPPLIER_SID                        NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for supplier',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
   PRICE_TYPE_CD                       VARCHAR(20)     NOT NULL COMMENT 'Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc',
   PRICE_GROUP_CD                      VARCHAR(20)     COMMENT 'Code of pricing group - internal or customer facing',
   ACTIVE_FROM_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The first date from when this record became valid from a business perspective,',
   ACTIVE_TO_TMSP                      TIMESTAMP_LTZ   NOT NULL COMMENT 'The last date up to when this record was valid from a business perspective,',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_PRODUCT_PRICE_SUPPLIE PRIMARY KEY (WSHOP_CD, PURCH_ORG_TYPE_CD, PROD_VARIANT_SID, SUPPLIER_SID, PRICE_TYPE_CD, ACTIVE_FROM_TMSP)
       NOT ENFORCED
)
COMMENT = 'ETL Support table -  fact for prices on supplier level (Purchase price, Additional freight costs, etc)';
