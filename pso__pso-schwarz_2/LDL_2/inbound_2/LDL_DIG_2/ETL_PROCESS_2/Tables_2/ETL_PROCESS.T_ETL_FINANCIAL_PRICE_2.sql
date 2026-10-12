/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_FINANCIAL_PRICE_2
   GENERATED FROM POWERDESIGNER ON Freitag, 13. Januar 2023 17:51:58
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_FINANCIAL_PRICE_2 (
   FIN_PRICE_TYPE_CD                   VARCHAR(5)      NOT NULL COMMENT 'The type that identifies whether it is Actual (historical) or Plan (static).',
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
   PRICE_CONDITION                     VARCHAR(100)    NOT NULL COMMENT 'Price Condition',
   PROD_SIZE_TYPE_GROUP_CD             VARCHAR(5)      NOT NULL COMMENT 'A code for product size classification grouped in the bigger buckets - ''Kleinteil'', ''Großteil'', etc',
   PACK_SIZE_HANDLE_GROUP_CD           VARCHAR(5)      NOT NULL COMMENT 'A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it - '' 1 person''  , ''2 persons'' etc',
   IS_WINE_SPIRITS_FG                  BOOLEAN         NOT NULL COMMENT 'Flag to identify if the values are belonging to the wine/spirits product gs1 category.',
   VALID_FROM_DT                       DATE            NOT NULL COMMENT 'The start date that determines the validity_2 of the price.',
   VALID_TO_DT                         DATE            COMMENT 'The end date that determines the validity_2 of the price.',
   PRICE_EUR_VAL                       NUMBER(38, 5)   COMMENT 'Valid price in given currency',
   RETURN_QTY_PCT                      NUMBER(38, 5)   COMMENT 'Return quantity percentage',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_FINANCIAL_PRICE PRIMARY KEY (FIN_PRICE_TYPE_CD, PRICE_CONDITION, WSHOP_CD, PROD_SIZE_TYPE_GROUP_CD, PACK_SIZE_HANDLE_GROUP_CD, VALID_FROM_DT, IS_WINE_SPIRITS_FG) NOT ENFORCED
 )  COMMENT= 'ETL Support table -   input data for the Deckungsbeitragsrechnung /Contribution Margin';
