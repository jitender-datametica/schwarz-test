/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_PRODUCT_VARIANT_AVAILABILITY
   GENERATED FROM POWERDESIGNER ON Donnerstag, 30. November 2023 16:24:27
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_PRODUCT_VARIANT_AVAILABILITY (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop',
   CAL_DT                              DATE            NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31).',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
   ACTIVE_FG                           BOOLEAN         COMMENT 'An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The original product variant number',
   IS_ORDERABLE_FG                     BOOLEAN         COMMENT 'Flag shows is article orderable on a date; ',
   IS_VISIBLE_FG                       BOOLEAN         COMMENT 'Flag shows is article visible on a date; ',
   IS_AVAIL_IN_STORE_FG                BOOLEAN         COMMENT 'Available In Store Flag as of Shop System',
   IS_IN_STOCK_FG                      BOOLEAN         COMMENT 'Flag, if product is in stock.  A product can be in stock, but not be sold before e.g. promotion starts.',
   IS_REPLENISHMENT_CONSIDERED_FG      BOOLEAN         COMMENT 'Flag to indicate if a product should be replenished',
   AVAIL_LVL_CD                        VARCHAR(5)      COMMENT 'Indicator code for availability (1, Online ausverkauft; 2, Online in Kürze; 3, Bestellbar; Null, Offline)',
   PROD_ORDERABLE_LVL_CD               VARCHAR(5)      COMMENT 'Indicator code. It shows if a product is orderable, soon orderable, or not orderable. It is derived from multiple indicators, like stock_indicator, display_indicator, online_indicator',
   SRC_CATALOG_NAME                    VARCHAR(100)    COMMENT 'Source Catalog where extracted from ("Master" or "Online")',
   IS_IN_PROMO_FG                      BOOLEAN         COMMENT 'Flag, if product is in a campaign /promotion',
   IS_IN_ONLINE_CATALOG_FG             BOOLEAN         COMMENT 'This flag has no business meaning on its own - it is a necessary but insufficient technical condition for product visibility in the webshop.',
   MAX_ORDER_QTY                       NUMBER(38, 5)   COMMENT 'Maximum quantity of the article that can be ordered per customer per order',
   TOTAL_STOCK_QTY                     NUMBER(38, 5)   COMMENT 'Stock Quantity of the product (article) for that day in the webshop - this is the maximum amount that can be ordered in total in all orders.',
   LOCALE_NAME                         VARCHAR(100)    COMMENT 'Source Locale, where the status data was reported from (de_de, cz_cz, de_en , etc)',
   IS_LEGACY_FG                        BOOLEAN         COMMENT 'Technical field used to identify legacy data (archived data or not), for further use as a filter condition',
   IS_SOLD_OUT_FG                      BOOLEAN         COMMENT 'Flag that shows if a product is sold out',
   CONTENT_CLASSIFICATION_RATING       VARCHAR(20)     COMMENT 'This is a Lidl specific rating which expresses the level of content a certain article has and is created with. We differentiate between Discount, Standard & Premium content (or n/a) to specify how much content an article has in the web shop.
            The higher the rating the more information & content features are added to the article on its page.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_FACT_PRODUCT_VARIANT_AVAILABILITY PRIMARY KEY (PROD_VARIANT_SID, WSHOP_CD, CAL_DT) NOT ENFORCED 
)  COMMENT = 'For a product variant shows if it was sellable and availabe for a selected date on a daily basis';
