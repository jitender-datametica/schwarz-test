/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_AGG_PRODUCT_VARIANT_PROMOTION
   GENERATED FROM POWERDESIGNER ON Donnerstag, 15. August 2024 08:56:38
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_AGG_PRODUCT_VARIANT_PROMOTION (
   PROMO_ID                            NUMBER(38, 0)   NOT NULL COMMENT 'An identifier from source system to uniqly identify the promotion',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'Ordered product',
   IS_AFTER_CANCELLATION_FG            BOOLEAN         NOT NULL COMMENT 'Flag that indicates if measurements are calculated including cancelled orders (TRUE - cancelled orders included, FLASE - cancelled orders not included)',
   CURR_USAGE_TYPE_CD                  VARCHAR(5)      NOT NULL COMMENT 'The code for the currency usage ( Local Currency vs Global Currency ).',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   PROMO_START_DT                      DATE            COMMENT 'Start date of the product promotion in stationary business',
   PROMO_SALE_START_DT                 DATE            COMMENT 'Date when sales of promotional goods starts',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   IS_FIRST_PROMOTION_FG               BOOLEAN         COMMENT 'Flag that indicates if it is the first time that a product is part of a promotion in a specific country in a pre defined timeframe',
   IS_REPEATED_FG                      BOOLEAN         COMMENT 'If it is the first time that promotion happens on a specific country then false, else true',
   SALE_PROMO_TYPE_CD                  VARCHAR(20)     COMMENT 'The unique code for that defines the way the product gets promoted e.g. website, flyer, etc.',
   PROD_ORDERABLE_LVL_CD               VARCHAR(5)      COMMENT 'Indicator code. It shows if a product is orderable, soon orderable, or not orderable. It is derived from multiple indicators, like stock_indicator, display_indicator, online_indicator',
   FIRST_DELIVERY_CY_WEEK              NUMBER(38, 0)   COMMENT 'Week when was the first time when the combination of this product & IAN & Charge entered the Warehouse. ',
   PROMO_DUR_WEEK_CNT                  NUMBER          COMMENT 'How long was the promotion planned to be active (number of weeks)',
   FIRST_INBOUND_DT                    DATE            COMMENT 'Min posting date in material movement document for each Product Variant. For Product Level (head level) it is considered the Min date for all the Product Variants. ',
   FINISHED_3_PROM_WEEKS_FG            BOOLEAN         COMMENT 'Flag that indicates if a promotion has passed the first 3 weeks based on the first week start date and current date',
   FIRST_WEEK_START_DT                 DATE            COMMENT 'This is the date when the first week of the promotion started.
            Special logic for DE and CZ because these countries focus on promotion weeks and not on promotion dates.
            For DE and CZ the promotions always starts on a monday, even if the promotion start date refers to another weekday.',
   PASSED_SALE_WEEKS_CNT               NUMBER          COMMENT 'Number of weeks passed after the beginning of the promotion',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of a particular product ordered',
   RETURN_PROD_QTY                     NUMBER(38, 5)   COMMENT 'Quantity of a particular product that has been returned',
   TGT_PROD_SALE_QTY                   NUMBER(38, 0)   COMMENT 'Number of products expected to be sold. Product quantities in stock units (no decimal values).',
   PLAN_AB_QTY                         NUMBER(38, 5)   COMMENT 'Planned quantity of units solds for each promotion week. Calculation method is based on estimated initial promotional stock.
            Contains value up to today.',
   TOTAL_PLAN_AB_QTY                   NUMBER(38, 5)   COMMENT 'Planned quantity of units solds for each promotion week. Calculation method is based on estimated initial promotional stock.
            Contains planned value for entire product life span.',
   PLAN_AMC_QTY                        NUMBER(38, 5)   COMMENT 'Planned quantity of units solds for each promotion week. Calculation method - For promotion phase,  the Aktionsmenge field which were planned to be sold in the first three weeks of a promotion * tgt pct quantities per week.
            For after-promotion phase, this means the Nachlaufmenge (supplier_order_qty - tgt_prod_qty) which were planned to be sold * the tgt pct per week.
            Contains value up to today.',
   TOTAL_PLAN_AMC_QTY                  NUMBER(38, 5)   COMMENT 'Planned quantity of units solds for each promotion week. Calculation method - For promotion phase,  the Aktionsmenge field which were planned to be sold in the first three weeks of a promotion * tgt pct quantities per week.
            For after-promotion phase, this means the Nachlaufmenge (supplier_order_qty - tgt_prod_qty) which were planned to be sold * the tgt pct per week.
            Contains values up to today.
            Contains planned value for entire product life span.',
   DELTA_PLAN_AB_QTY                   NUMBER(38, 5)   COMMENT 'Planned quantity of units solds for each promotion week based on estimated initial promotional stock  -  Quantity of a particular product ordered',
   DELTA_PLAN_AMC_QTY                  NUMBER(38, 5)   COMMENT 'plan_amc_qty - Quantity of a particular product ordered',
   ALLOC_STOCK_CNT                     NUMBER          COMMENT 'The reserved stock for a country - this stock is only available for this country (for a certain time period)',
   AVAIL_TO_PROMISE_CNT                NUMBER          COMMENT 'The amount of stock which is currently available within the specific warehouse.
            All of the stock can be sold within the onlineshop and is stored in an internal warehouse.',
   AVAIL_TO_SELL_CNT                   NUMBER          COMMENT 'Available for Sale is the high level rack''s and pick-area''s stock within the system.',
   BLOCKED_STOCK_CNT                   NUMBER          COMMENT 'Stock of a product stored in the warehouse but currently blocked (not usable / not sellable).',
   TOTAL_STOCK_CNT                     NUMBER          COMMENT 'The sum of (blocked_stock_cnt,blocked_stock_return_cnt,unrestricted_stock_cnt,restricted_stock_cnt,in_transfer_cnt and in_qty_inspection_cnt)',
   RECEIVE_ON_DOCK_CNT                 NUMBER          COMMENT '"Received on dock" is the incoming goods area''s stock within the system. In case of a new delivery the stock would be stated first as ROD.',
   WSHOP_TOTAL_STOCK_CNT               NUMBER          COMMENT 'Total stock available per country, based on the distribution percentage',
   DAYS_NOT_ORDERABLE_IN_PROMOTION_CNT NUMBER          COMMENT 'Number of days a product is not orderable in its promotion period',
   ORDERABLE_IN_PROMOTION_START_DT     DATE            COMMENT 'First day a product can be ordered in promotion. Sometimes this is later than the promotion sale start date.',
   SUPPLIER_ORDER_QTY                  NUMBER(38, 0)   COMMENT 'Number of products ordered from suppliers. If it is zero, it means that nothing was ordered because there is still stock available from another promotion. ',
   EST_INIT_PROMO_STOCK_CNT            NUMBER(38, 5)   COMMENT 'Estimated stock present on the starting date of the promotion sales',
   PROMO_SALE_PRICE_GROSS_VAL          NUMBER(38, 5)   COMMENT 'Promotion sale price per unit in gross amount (incl. taxes)',
   PROMO_SALE_PRICE_NET_VAL            NUMBER(38, 5)   COMMENT 'Promotion sale price per unit in net amount (excl. taxes)',
   PROMO_PURCH_PRICE_NET_VAL           NUMBER(38, 5)   COMMENT 'Promotion purchase price per unit in net amount (excl. taxes)',
   GROSS_MARGIN_NET_VAL                NUMBER(38, 5)   COMMENT 'Calculated Net Profit Margin',
   PROD_PRICE_GROSS_VAL                NUMBER(38, 5)   COMMENT 'Original (listed) gross price of a product ( includes returns and cancellations)',
   PROD_PRICE_NET_VAL                  NUMBER(38, 5)   COMMENT 'Original (listed) net price of a product  ( includes returns and cancellations)',
   SPECIAL_ANALYSIS_PROD_QTY           NUMBER(38, 5)   COMMENT 'Quantity of a particular product ordered during promotion special analysis period.',
   SPECIAL_ANALYSIS_PROD_PRICE_NET_VAL NUMBER(38, 5)   COMMENT 'Original (listed) net price of a product ( includes returns and cancellations) during promotion special analysis period.',
   SPECIAL_ANALYSIS_GROSS_MARGIN_NET_VAL NUMBER(38, 5)   COMMENT 'Calculated Net Profit Margin (excl. taxes) during promotion special analysis period.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_AGG_PRODUCT_VARIANT_PROMOTION PRIMARY KEY (PROMO_ID, PROD_VARIANT_SID, IS_AFTER_CANCELLATION_FG, CURR_USAGE_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'A Fact table that aggregates promotion sales up to the level of Product Variant, Promotion , Special Analisys Flag, This granularity is then multiplied to have one row for each combination of [Local/Global currency] x [Special Analysis - True/False]';
