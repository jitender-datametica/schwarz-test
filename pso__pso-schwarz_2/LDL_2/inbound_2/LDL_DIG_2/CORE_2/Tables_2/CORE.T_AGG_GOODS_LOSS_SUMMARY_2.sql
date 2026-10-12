/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_AGG_GOODS_LOSS_SUMMARY_2
   GENERATED FROM POWERDESIGNER ON Freitag, 5. August 2022 14:30:05
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_AGG_GOODS_LOSS_SUMMARY_2 (
   BUSINESS_EVENT_TYPE_CD              VARCHAR(5)      NOT NULL COMMENT 'Code identifying the retail business event type  ( ex. O = Order, R = return ...)',
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
   EVENT_DT                            DATE            NOT NULL COMMENT 'Date when the Order was performed (items left the warehouse) or when the Return happened',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'Ordered product',
   DELIVERY_SRC_TYPE_CD                VARCHAR(5)      NOT NULL COMMENT 'The code for source location_2 of product from where it is delivered i.e. from supplier_2 or warehouse directly',
   PROFIT_LOSS_REASON_CD               VARCHAR(20)     NOT NULL COMMENT 'The code of the reason for profit or loss ',
   GOODS_LOSS_ORIGIN_TYPE_CD           VARCHAR(5)      NOT NULL COMMENT 'Code identifying the event type that leads to profit or loss ( ex. PC = Price Chagne, CV = coupon validation ...)',
   GOODS_LOSS_ORIGIN_DETAIL            VARCHAR(50)     NOT NULL COMMENT 'The goods loss detail value (in case of coupon validation - coupon code, scrapping - warehouse code, proce change - not applicable hence ''-''',
   NATIONAL_ACCT_SID                   NUMBER          COMMENT 'The unique identifier (surrogate key) for the Financial Account_2 which is associated with this PL reason code',
   NATIONAL_ACCT_NR                    VARCHAR(20)     COMMENT 'Number of the Account_2 which is associated with this PL reason code. There are postings in the GL they are booked to this account_2 number ',
   CURR_CD                             VARCHAR(5)      COMMENT 'Currency code in which order has been payed',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Ordered quantity of the product',
   TGT_PRICE_NET_LOCAL_VAL             NUMBER(38, 5)   COMMENT 'The target price at which the product was intended to be sold (in local currency)',
   ACTUAL_PRICE_NET_LOCAL_VAL          NUMBER(38, 5)   COMMENT 'The actual price at which the product was sold (in local currency)',
   IVP_PRICE_NET_LOCAL_VAL             NUMBER(38, 5)   COMMENT 'Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs ) (in local currency)',
   PC_LOSSES_NET_LOCAL_VAL             NUMBER(38, 5)   COMMENT 'Losses amount based on difference between target price and actual price (in local currency)',
   TRANSFER_MARGIN_NET_LOCAL_VAL       NUMBER(38, 5)   COMMENT 'This amount is a loss that will be used to reduce the earnings and thus affecting the margin (in local currency)',
   CORRECTION_COGS_NET_LOCAL_VAL       NUMBER(38, 5)   COMMENT 'Correction value for the cost of goods sold. It is added to actual cost of goods sold to icrease losses and thus affecting margin (in local currency)',
   TGT_PRICE_NET_EUR_VAL               NUMBER(38, 5)   COMMENT 'The target price at which the product was intended to be sold (in euro)',
   ACTUAL_PRICE_NET_EUR_VAL            NUMBER(38, 5)   COMMENT 'The actual price at which the product was sold (in euro)',
   IVP_PRICE_NET_EUR_VAL               NUMBER(38, 5)   COMMENT 'Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs, in euro)',
   PC_LOSSES_NET_EUR_VAL               NUMBER(38, 5)   COMMENT 'Losses amount based on difference between target price and actual price (in euro)',
   TRANSFER_MARGIN_NET_EUR_VAL         NUMBER(38, 5)   COMMENT 'This amount is a loss that will be used to reduce the earnings and thus affecting the margin (in euro)',
   CORRECTION_COGS_NET_EUR_VAL         NUMBER(38, 5)   COMMENT 'Correction value for the cost of goods sold. It is added to actual cost of goods sold to icrease losses and thus affecting margin (in euro)',
   IS_LEGACY_FG                        BOOLEAN         COMMENT 'Technical field used to identify legacy data, for further use as a filter condition.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   CONSTRAINT PK_T_AGG_GOODS_LOSS_SUMMARY PRIMARY KEY (BUSINESS_EVENT_TYPE_CD, EVENT_DT, WSHOP_CD, PROD_VARIANT_SID, DELIVERY_SRC_TYPE_CD, PROFIT_LOSS_REASON_CD, GOODS_LOSS_ORIGIN_TYPE_CD, GOODS_LOSS_ORIGIN_DETAIL) NOT ENFORCED
 )  COMMENT= 'The aggregate table that holds the loss due to various event type like promotional coupons applied to an order, chage of price of goods sold. Aggregated at [Webshop; Day; Currency; Product Variant; Derivery Source Type; Loss Reason Code, Goods Loss Type and respective Detail] level';
