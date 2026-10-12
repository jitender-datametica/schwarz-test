/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_PRODUCT_AVAILABILITY_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. März 2024 12:01:24
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_PRODUCT_AVAILABILITY_2 (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop',
   CAL_DT                              DATE            NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31).',
   PROD_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product',
   PROD_NR                             VARCHAR(20)     COMMENT 'The number for internal onlineshop product, which is country_2 independent',
   ACTIVE_FG                           BOOLEAN         COMMENT 'An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt',
   IS_ORDERABLE_FG                     BOOLEAN         COMMENT 'Flag shows is product orderable in the webshop on a date',
   IS_VISIBLE_FG                       BOOLEAN         COMMENT 'Flag shows is product visible in the webshop (can be found by name, category, filter) on a date',
   IS_SOLD_OUT_FG                      BOOLEAN         COMMENT 'Flag that shows if a product is sold out',
   IS_AVAIL_IN_STORE_FG                BOOLEAN         COMMENT 'Flag shows if the product is also sold in the lidl stores ',
   IS_IN_STOCK_FG                      BOOLEAN         COMMENT 'Flag shows if product is in stock. A product can be in stock, but not be sold before e.g. promotion starts.',
   IS_REPLENISHMENT_CONSIDERED_FG      BOOLEAN         COMMENT 'Flag to indicate if a product should be replenished',
   IS_IN_CAMPAIGN_PAGE_FG              BOOLEAN         COMMENT 'The flag that shows if the product is the part of a campaign page. Campaign Pages are the offer pages with the current weekly only store, only online and store & online offers.',
   AVAIL_LVL_CD                        VARCHAR(5)      COMMENT 'Indicator code for availability (1, Online ausverkauft; 2, Online in Kürze; 3, Bestellbar; Null, Offline)',
   PROD_ORDERABLE_LVL_CD               VARCHAR(5)      COMMENT 'Indicator code. It shows if a product is orderable, soon orderable, or not orderable. It is derived from multiple indicators, like stock_indicator, display_indicator, online_indicator',
   IS_IN_ONLINE_CATALOG_FG             BOOLEAN         COMMENT 'This flag has no business meaning on its own - it is a necessary but insufficient technical condition for product visibility in the webshop.',
   TOTAL_STOCK_QTY                     NUMBER(38, 5)   COMMENT 'Stock Quantity of the product (article) for that day in the webshop - this is the maximum amount that can be ordered in total in all orders.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_FACT_PRODUCT_AVAILABILITY PRIMARY KEY (PROD_SID, WSHOP_CD, CAL_DT) NOT ENFORCED 
)  COMMENT = 'The table contains data at the product level - if a certain product is sellable and availabe for a selected date on a daily basis';
