/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_REGIONAL_STOCK_KNOCKDOWN_MONTHLY_2
   GENERATED FROM POWERDESIGNER ON Freitag, 26. Mai 2023 09:22:18
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_REGIONAL_STOCK_KNOCKDOWN_MONTHLY_2 (
   BUS_YEAR                            NUMBER          NOT NULL COMMENT 'The business year as a number in the form YYYY. Eg. 2019',
   MONTH_OF_BUS_YEAR                   NUMBER          NOT NULL COMMENT 'The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   PROD_SID                            NUMBER          COMMENT 'The unique identifier (surrogate key) for the product',
   PROD_NR                             VARCHAR(20)     COMMENT 'The number for internal onlineshop product, which is country_2 independent',
   TOTAL_STOCK_CNT                     NUMBER          COMMENT 'Sum of stock items stored in the warehouse, that lost part of their value',
   PROD_PRICE_KNOCKDOWN_NET_EUR_VAL    NUMBER(38, 5)   COMMENT 'Total amount of loss in value of the products which are present in stock',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_REGIONAL_STOCK_KNOCKDOWN_MONTHLY PRIMARY KEY (BUS_YEAR, MONTH_OF_BUS_YEAR, WSHOP_CD, PROD_VARIANT_SID) NOT ENFORCED
 )  COMMENT= 'The table contains the total monthly quantity per webshop of articles in stock and their depreciation value (knock down/write-down) needed for accounting purposes.';
