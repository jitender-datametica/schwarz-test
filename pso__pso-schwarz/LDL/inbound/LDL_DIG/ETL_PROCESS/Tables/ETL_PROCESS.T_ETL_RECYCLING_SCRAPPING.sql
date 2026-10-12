/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_RECYCLING_SCRAPPING
   GENERATED FROM POWERDESIGNER ON Freitag, 17. Mai 2024 11:09:34
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_RECYCLING_SCRAPPING (
   FIN_PRICE_TYPE_CD                   VARCHAR(5)      NOT NULL COMMENT 'The type that identifies whether it is Actual (historical) or Plan (static).',
   BUS_YEAR                            NUMBER          NOT NULL COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
   MONTH_OF_BUS_YEAR                   NUMBER          NOT NULL COMMENT 'The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   PROD_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product',
   RECYCLED_GOODS_NET_EUR_VAL          NUMBER(38, 5)   COMMENT 'Value of products that are recycled and scrapped',
   RECYCLED_AND_SCRAPPED_PROD_QTY      NUMBER(38, 5)   COMMENT 'Total quantity of products that were either recycled or scrapped. Up until 01-03-2024, the data about recycled and scrapped products was coming in from an excel file which did not indicate if the product was recycled or scrapped. This column therefore contains data about the total quantity of such products until 29-02-2024. From 01-03-2024 onwards the quantity of this products will be equal to the sum of recycled_prod_qty and scrapped_prod_qty.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_RECYCLING_SCRAPPING PRIMARY KEY (FIN_PRICE_TYPE_CD, BUS_YEAR, MONTH_OF_BUS_YEAR, WSHOP_CD, PROD_SID) NOT ENFORCED 
)  COMMENT = 'ETL Support table  -  input data for the Deckungsbeitragsrechnung /Contribution Margin';
