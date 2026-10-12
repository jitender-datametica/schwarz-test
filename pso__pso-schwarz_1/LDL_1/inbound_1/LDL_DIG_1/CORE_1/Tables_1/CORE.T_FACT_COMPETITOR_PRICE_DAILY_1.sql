/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_COMPETITOR_PRICE_DAILY_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 25. Juli 2024 11:04:58
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_COMPETITOR_PRICE_DAILY_1 (
   COMPETITOR_PRICE_ID                 VARCHAR(20)     NOT NULL COMMENT 'The unique code for the Competitor Price. As we can have more prices from the same competitor in the same day, the ID allows us to differentiate them.',
   PROD_VARIANT_SID                    NUMBER          COMMENT 'The unique identifier (surrogate key) for the product variant',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   CAL_DT                              DATE            COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31).',
   COMPETITOR_CD                       VARCHAR(20)     COMMENT 'The unique code for the Competitor.',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   PRICE_SRC_NAME                      VARCHAR(100)    COMMENT 'Price comparison website on which competitor price was found.',
   COMPETITOR_SALE_PRICE_GROSS_LOCAL_VAL NUMBER(38, 5)   COMMENT 'Sales_1 price from the competitor.',
   COMPETITOR_SHIP_PRICE_GROSS_LOCAL_VAL NUMBER(38, 5)   COMMENT 'Shipping price from the competitor.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_FACT_COMPETITOR_PRICE_DAILY PRIMARY KEY (COMPETITOR_PRICE_ID) NOT ENFORCED 
)  COMMENT = 'A fact table that records the prices for product variants from competitors on daily basis. Competitor is an organization that engages in economic competition with LIDL webshops. e.g Amazon.de, Mediamarkt.de etc.
             
             The granularity (Business Key) of the table is represented by the combination of competitor_cd, prod_variant_sid, price_src_name and cal_dt,';
