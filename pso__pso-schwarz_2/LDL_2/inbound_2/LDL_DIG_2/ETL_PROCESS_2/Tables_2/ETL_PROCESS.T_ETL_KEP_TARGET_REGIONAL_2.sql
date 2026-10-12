/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_KEP_TARGET_REGIONAL_2
   GENERATED FROM POWERDESIGNER ON Montag, 19. Dezember 2022 10:41:42
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_KEP_TARGET_REGIONAL_2 (
   BUS_YEAR                            NUMBER          NOT NULL COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
   MONTH_OF_BUS_YEAR                   NUMBER          NOT NULL COMMENT 'The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
   PACK_SIZE_HANDLE_GROUP_CD           VARCHAR(5)      NOT NULL COMMENT 'A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it - '' 1 person''  , ''2 persons'' etc',
   ACCT_NR                             VARCHAR(20)     NOT NULL COMMENT 'Number of the Account. The there are postings in the GL they are booked to this account_2 number',
   IS_WINE_SPIRITS_FG                  BOOLEAN         NOT NULL COMMENT 'Flag to identify if the values are belonging to the wine/spirits product gs1 category.',
   DELIVERY_SRC_TYPE_CD                VARCHAR(5)      COMMENT 'The code for source location_2 of product from where it is delivered i.e. from supplier_2 or warehouse directly',
   DB_POS_NAME                         VARCHAR(200)    COMMENT 'Name of the Contribution Margin position in German',
   CURR_CD                             VARCHAR(5)      COMMENT 'Currency in which target is set',
   TGT_PRICE_NET_EUR_VAL               NUMBER(38, 5)   COMMENT 'Planned price in euro',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_KEP_TARGET_REGIONAL PRIMARY KEY (BUS_YEAR, MONTH_OF_BUS_YEAR, WSHOP_CD, PACK_SIZE_HANDLE_GROUP_CD, ACCT_NR, IS_WINE_SPIRITS_FG) NOT ENFORCED
 )  COMMENT= 'ETL Support table -   input data for the Deckungsbeitragsrechnung /Contribution Margin';
