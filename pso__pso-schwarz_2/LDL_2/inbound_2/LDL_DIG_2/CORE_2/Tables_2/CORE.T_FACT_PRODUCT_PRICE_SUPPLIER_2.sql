/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_PRODUCT_PRICE_SUPPLIER_2
   GENERATED FROM POWERDESIGNER ON Montag, 6. November 2023 13:33:57
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_PRODUCT_PRICE_SUPPLIER_2 (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
   SUPPLIER_SID                        NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for supplier_2',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
   PRICE_TYPE_CD                       VARCHAR(20)     NOT NULL COMMENT 'Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc',
   PRICE_GROUP_CD                      VARCHAR(20)     COMMENT 'Code of pricing group - internal or customer facing',
   ACTIVE_FROM_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The first date from when this record became valid from a business perspective,',
   ACTIVE_TO_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The last date up to when this record was valid from a business perspective,',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   PRICE_VAL                           NUMBER(38, 5)   COMMENT 'Valid price in given currency',
   SUPPLIER_NR                         VARCHAR(20)     COMMENT 'Account_2 number of supplier_2/vendor from the sorce system',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   IS_LEGACY_FG                        BOOLEAN         COMMENT 'Technical field used to identify legacy data (from Qlik legacy systems vs_2 generic data flows), for further use as a filter condition',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_FACT_PRODUCT_PRICE_SUPPLIER PRIMARY KEY (WSHOP_CD, PROD_VARIANT_SID, SUPPLIER_SID, PRICE_TYPE_CD, ACTIVE_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'A fact for prices on supplier_2 level (Purchase price, Additional freight costs, etc)';
