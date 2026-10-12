/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SCM_TARGET_REGIONAL
   GENERATED FROM POWERDESIGNER ON Montag, 19. Dezember 2022 10:40:40
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_SCM_TARGET_REGIONAL (
   BUS_YEAR                            NUMBER          NOT NULL COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
   MONTH_OF_BUS_YEAR                   NUMBER          NOT NULL COMMENT 'The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   PROD_SIZE_TYPE_GROUP_CD             VARCHAR(5)      NOT NULL COMMENT 'A code for product size classification grouped in the bigger buckets - ''Kleinteil'', ''Großteil'', etc',
   PACK_SIZE_HANDLE_GROUP_CD           VARCHAR(5)      NOT NULL COMMENT 'A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it - '' 1 person''  , ''2 persons'' etc',
   DB_POS_NAME                         VARCHAR(200)    NOT NULL COMMENT 'Name of the Contribution Margin position in German',
   IS_WINE_SPIRITS_FG                  BOOLEAN         NOT NULL COMMENT 'Flag to identify if the values are belonging to the wine/spirits product gs1 category.',
   DELIVERY_SRC_TYPE_CD                VARCHAR(5)      COMMENT 'The code for source location of product from where it is delivered i.e. from supplier or warehouse directly',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Product quantity',
   PACK_QTY                            NUMBER(38, 5)   COMMENT 'Packaging quantity',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_SCM_TARGET_REGIONAL PRIMARY KEY (BUS_YEAR, MONTH_OF_BUS_YEAR, WSHOP_CD, PROD_SIZE_TYPE_GROUP_CD, PACK_SIZE_HANDLE_GROUP_CD, IS_WINE_SPIRITS_FG, DB_POS_NAME) NOT ENFORCED
 )  COMMENT= 'ETL Support table -   input data for the Deckungsbeitragsrechnung /Contribution Margin';
