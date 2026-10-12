/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_BUSINESS_TARGET_REGIONAL
   GENERATED FROM POWERDESIGNER ON Montag, 19. Dezember 2022 10:39:25
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_BUSINESS_TARGET_REGIONAL (
   BUS_YEAR                            NUMBER          NOT NULL COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
   MONTH_OF_BUS_YEAR                   NUMBER          NOT NULL COMMENT 'The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   DELIVERY_SRC_TYPE_CD                VARCHAR(5)      NOT NULL COMMENT 'The code for source location of product from where it is delivered i.e. from supplier or warehouse directly',
   PROD_FOOD_CLASS_CD                  VARCHAR(5)      NOT NULL COMMENT 'The code for the indicating if product is a food or non food',
   BRAND_CLASS_CD                      VARCHAR(5)      NOT NULL COMMENT 'The code for the indicating if product is classified as a Lidl own brand or not',
   PROD_ORG_LVL_NAME                   VARCHAR(50)     NOT NULL COMMENT 'The Organisation level is a mapped field for every category in the GS1 article categorization system on level 4. Every Brickcode has a mapped Organisation level, which can be compared to the old Shop categorie 1, but now based first on the Brickcode structure. The Organisation level is a mapping to transfer the GS1 article categorization system to the structures of Lidl Digital.',
   DB_POS_NAME                         VARCHAR(200)    NOT NULL COMMENT 'Name of the Contribution Margin position in German',
   IS_WINE_SPIRITS_FG                  BOOLEAN         NOT NULL COMMENT 'Flag to identify if the values are belonging to the wine/spirits product gs1 category.',
   CURR_CD                             VARCHAR(5)      COMMENT 'Currency in which target is set',
   TGT_PRICE_NET_EUR_VAL               NUMBER(38, 5)   COMMENT 'Planned price in euro',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Product quantity',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_BUSINESS_TARGET_REGIONAL PRIMARY KEY (BUS_YEAR, MONTH_OF_BUS_YEAR, WSHOP_CD, DELIVERY_SRC_TYPE_CD, PROD_FOOD_CLASS_CD, BRAND_CLASS_CD, PROD_ORG_LVL_NAME, DB_POS_NAME, IS_WINE_SPIRITS_FG) NOT ENFORCED
 )  COMMENT= 'ETL Support table -   input data for the Deckungsbeitragsrechnung /Contribution Margin';
