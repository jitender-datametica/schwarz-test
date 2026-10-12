/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_AGG_PRODUCT_PROMOTION_CLUSTER_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 15. August 2024 08:56:16
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_AGG_PRODUCT_PROMOTION_CLUSTER_2 (
   PROMO_ID                            NUMBER(38, 0)   NOT NULL COMMENT 'An identifier from source system to uniqly identify the promotion',
   PROMO_SALE_CLUSTER_CD               NUMBER          NOT NULL COMMENT 'A code for aggregation of sales_2 orders assigned to a promotion based on the customer order date. One Promotion contains several Promotion Clusters',
   IS_AFTER_CANCELLATION_FG            BOOLEAN         NOT NULL COMMENT 'Flag that indicates if measurements are calculated including cancelled orders (TRUE - cancelled orders included, FLASE - cancelled orders not included)',
   CURR_USAGE_TYPE_CD                  VARCHAR(5)      NOT NULL COMMENT 'The code for the currency usage ( Local Currency vs_2 Global Currency ).',
   PROD_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
   PROMO_START_DT                      DATE            COMMENT 'Start date of the product promotion in stationary business',
   PROMO_SALE_START_DT                 DATE            COMMENT 'Date when sales_2 of promotional goods starts',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   IS_FIRST_PROMOTION_FG               BOOLEAN         COMMENT 'Flag that indicates if it is the first time that a product is part of a promotion in a specific country_2 in a pre defined timeframe',
   IS_REPEATED_FG                      BOOLEAN         COMMENT 'If it is the first time that promotion happens on a specific country_2 then false, else true',
   SALE_PROMO_TYPE_CD                  VARCHAR(20)     COMMENT 'The unique code for that defines the way the product gets promoted e.g. website, flyer, etc.',
   CURRENT_PROMO_SALE_CLUSTER_CD       NUMBER          COMMENT 'Code of the Promotion Sale Cluster which is currently active (based on promotion start date and current date)',
   IS_CURRENT_PROMO_SALE_CLUSTER_FG    BOOLEAN         COMMENT 'True for the row where Promotion Sale Cluster CD is equal to Current Promotion Sale Cluster CD. Otherwise value is FALSE',
   FIRST_DELIVERY_CY_WEEK              NUMBER(38, 0)   COMMENT 'Week when was the first time when the combination of this product & IAN & Charge entered the Warehouse. ',
   PROMO_DUR_WEEK_CNT                  NUMBER          COMMENT 'How long was the promotion planned to be active (number of weeks)',
   FIRST_INBOUND_DT                    DATE            COMMENT 'Min posting date in material movement document for each Product Variant. For Product Level (head level) it is considered the Min date for all the Product Variants. ',
   FINISHED_3_PROM_WEEKS_FG            BOOLEAN         COMMENT 'Flag that indicates if a promotion has passed the first 3 weeks based on the first week start date and current date',
   FIRST_WEEK_START_DT                 DATE            COMMENT 'This is the date when the first week of the promotion started.
            Special logic for DE and CZ because these countries focus on promotion weeks and not on promotion dates.
            For DE and CZ the promotions always starts on a monday, even if the promotion start date refers to another weekday.',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of a particular product ordered',
   RETURN_PROD_QTY                     NUMBER(38, 5)   COMMENT 'Quantity of a particular product that has been returned',
   CUM_PROD_QTY                        NUMBER(38, 5)   COMMENT 'Accumulated quantity of a particular product ordered - includes all quantities of the previous Promotion Clusters',
   CUM_RETURN_PROD_QTY                 NUMBER(38, 5)   COMMENT 'Accumulated returned quantity of a particular product - includes all quantities of the previous Promotion Clusters',
   GROSS_MARGIN_NET_VAL                NUMBER(38, 5)   COMMENT 'Calculated Net Profit Margin',
   CUM_GROSS_MARGIN_NET_VAL            NUMBER(38, 5)   COMMENT 'Accumulated Calculated Gross Margin - includes all amounts of the previous Promotion clusters (excl. taxes)',
   PROD_PRICE_GROSS_VAL                NUMBER(38, 5)   COMMENT 'Original (listed) gross price of a product. (includes returns and cancellations)',
   PROD_PRICE_NET_VAL                  NUMBER(38, 5)   COMMENT 'Original (listed) net price of a product ( includes returns and cancellations)',
   CUM_PROD_PRICE_GROSS_VAL            NUMBER(38, 5)   COMMENT 'Accumulated total original (listed) net price of a product - includes all amouns of the previous Promotion clusters (incl taxes)',
   CUM_PROD_PRICE_NET_VAL              NUMBER(38, 5)   COMMENT 'Accumulated total original (listed) net price of a product - includes all amouns of the previous Promotion clusters (excl taxes)',
   PLAN_AB_QTY                         NUMBER(38, 5)   COMMENT 'Planned quantity of units solds for each promotion week. Calculation method is based on estimated initial promotional stock',
   PLAN_AMC_QTY                        NUMBER(38, 5)   COMMENT 'Planned quantity of units solds for each promotion week. Calculation method - For promotion phase,  the Aktionsmenge field which were planned to be sold in the first three weeks of a promotion * tgt pct quantities per week.
            For after-promotion phase, this means the Nachlaufmenge (supplier_order_qty - tgt_prod_qty) which were planned to be sold * the tgt pct per week.',
   CUM_PLAN_AMC_QTY                    NUMBER(38, 5)   COMMENT 'Accumulated planned quantity of units solds for each promotion week. Sums PLAN_AMC_QTY of the previous Promotion Clusters
            For after-promotion phase, this means the Nachlaufmenge (supplier_order_qty - tgt_prod_qty) which were planned to be sold * the tgt pct per week.',
   CUM_PLAN_AB_QTY                     NUMBER(38, 5)   COMMENT 'Accumulated planned quantity of units solds for each promotion week. Sums PLAN_AB_QTY of the previous Promotion Clustters',
   PROD_ORDERABLE_LVL_CD               VARCHAR(5)      COMMENT 'Indicator code. It shows if a product is orderable, soon orderable, or not orderable. It is derived from multiple indicators, like stock_indicator, display_indicator, online_indicator',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_AGG_PRODUCT_PROMOTION_CLUSTER PRIMARY KEY (PROMO_ID, PROMO_SALE_CLUSTER_CD, IS_AFTER_CANCELLATION_FG, CURR_USAGE_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'A Fact table that aggregates promotion sales_2 up to the level of  Promotion Cluster (a period which is part of promotion)., Special Analisys Flag, This granularity is then multiplied to have one row for each combination of [Local/Global currency] x [Special Analysis - True/False] . Product is not part of the PK because for each Promotion we have exactly 1 product';
