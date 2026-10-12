/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_AGG_SALES_DAILY_1
   GENERATED FROM POWERDESIGNER ON Montag, 29. Juli 2024 14:57:11
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_AGG_SALES_DAILY_1 (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country_1 and is run by an Lidl Digital Country_1',
   CAL_DT                              DATE            NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31).',
   ORDER_CNT                           NUMBER          COMMENT 'Number of orders',
   TOTAL_PROD_PRICE_NET_EUR_VAL        NUMBER(38, 5)   COMMENT 'Total sum of original (listed) net euro price of ordered items (includes returns and cancellations) (Bestellumsatz)',
   TGT_REVENUE_NET_EUR_VAL             NUMBER(38, 5)   COMMENT 'Planned net revenue before returns in euro',
   COGS_PRICE_NET_EUR_VAL              NUMBER(38, 5)   COMMENT 'Cost-of-Goods-sold in euro net (Wareneinsatz)',
   TGT_COGS_NET_EUR_VAL                NUMBER(38, 5)   COMMENT 'Planned Cost-of-Goods-sold in euro net, calculated as a difference between target revenue and target margin (Wareneinsatz (Plan))',
   TOTAL_RETURN_PROD_ORDER_DT_PRICE_NET_EUR_VAL NUMBER(38, 5)   COMMENT 'Total sum of original (listed) price of all items that were ordered on this date and later returned (in EUR, excl. taxes) (Retourenwert (auftragsbezogen))',
   TOTAL_RETURN_PROD_PRICE_NET_EUR_VAL NUMBER(38, 5)   COMMENT 'Total sum of original (listed) price of all items that were ordered before and returned on this date (in EUR, excl. taxes) (Retourenwert (physisch))',
   TOTAL_CANCEL_PROD_PRICE_NET_EUR_VAL NUMBER(38, 5)   COMMENT 'Total sum of original (listed) price of all items that were ordered on this date and then cancelled (in EUR, excl. taxes) (Stornowert)',
   CANCEL_COGS_PRICE_NET_EUR_VAL       NUMBER(38, 5)   COMMENT 'Cost-of-Goods-sold in euro net for all items that were ordered on this date and then cancelled (Storno Wareneinsatz)',
   TOTAL_PROD_COUPON_NET_EUR_VAL       NUMBER(38, 5)   COMMENT 'Total net euro discount value for all ordered (original/listed) products (cancelled orders are left out of the calculation)',
   TOTAL_DELIVERY_PAUSHAL_NET_EUR_VAL  NUMBER(38, 5)   COMMENT 'Total net euro paushal for delivery costs (Versandkostenpauschale) (cancelled orders are left out of the calculation)',
   TOTAL_DELIVERY_PAUSHAL_COUPON_NET_EUR_VAL NUMBER(38, 5)   COMMENT 'Total net euro discount value for paushal delivery cost split per every order position (cancelled orders are left out of the calculation)',
   TOTAL_DELIVERY_COST_NET_EUR_VAL     NUMBER(38, 5)   COMMENT 'Total net euro delivery costs for all ordered products (Versandkosten) (cancelled orders are left out of the calculation)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_AGG_SALES_DAILY PRIMARY KEY (WSHOP_CD, CAL_DT) NOT ENFORCED 
)  COMMENT = 'A fact table that aggregates sales_1 information at the level of calendar_1 day and webshop.';
