/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_AGG_GOODS_LOSS_SUMMARY_1
   GENERATED FROM POWERDESIGNER ON Freitag, 5. August 2022 14:30:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_agg_goods_loss_summary_1 (
business_event_type_cd STRING(5) NOT NULL
OPTIONS(description='Code identifying the retail business event type  ( ex. O = Order, R = return ...)'),
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
event_dt DATE NOT NULL
OPTIONS(description='Date when the Order was performed (items left the warehouse) or when the Return happened'),
prod_variant_sid BIGNUMERIC NOT NULL OPTIONS(description='Ordered product'),
delivery_src_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for source location_1 of product from where it is delivered i.e. from supplier_1 or warehouse directly'),
profit_loss_reason_cd STRING(20) NOT NULL OPTIONS(description='The code of the reason for profit or loss '),
goods_loss_origin_type_cd STRING(5) NOT NULL
OPTIONS(description='Code identifying the event type that leads to profit or loss ( ex. PC = Price Chagne, CV = coupon validation ...)'),
goods_loss_origin_detail STRING(50) NOT NULL
OPTIONS(description='The goods loss detail value (in case of coupon validation - coupon code, scrapping - warehouse code, proce change - not applicable hence\'-\''),
national_acct_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for the Financial Account_1 which is associated with this PL reason code'),
national_acct_nr STRING(20)
OPTIONS(description='Number of the Account_1 which is associated with this PL reason code. There are postings in the GL they are booked to this account_1 number '),
curr_cd STRING(5) OPTIONS(description='Currency code in which order has been payed'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Ordered quantity of the product'),
tgt_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='The target price at which the product was intended to be sold (in local currency)'),
actual_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='The actual price at which the product was sold (in local currency)'),
ivp_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs ) (in local currency)'),
pc_losses_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Losses amount based on difference between target price and actual price (in local currency)'),
transfer_margin_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='This amount is a loss that will be used to reduce the earnings and thus affecting the margin (in local currency)'),
correction_cogs_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Correction value for the cost of goods sold. It is added to actual cost of goods sold to icrease losses and thus affecting margin (in local currency)'),
tgt_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The target price at which the product was intended to be sold (in euro)'),
actual_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The actual price at which the product was sold (in euro)'),
ivp_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs, in euro)'),
pc_losses_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Losses amount based on difference between target price and actual price (in euro)'),
transfer_margin_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='This amount is a loss that will be used to reduce the earnings and thus affecting the margin (in euro)'),
correction_cogs_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Correction value for the cost of goods sold. It is added to actual cost of goods sold to icrease losses and thus affecting margin (in euro)'),
is_legacy_fg BOOL
OPTIONS(description='Technical field used to identify legacy data, for further use as a filter condition.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
PRIMARY KEY (business_event_type_cd, event_dt, wshop_cd, prod_variant_sid, delivery_src_type_cd, profit_loss_reason_cd,
 goods_loss_origin_type_cd, goods_loss_origin_detail) NOT ENFORCED
)
OPTIONS(description='The aggregate table that holds the loss due to various event type like promotional coupons applied to an order, chage of price of goods sold. Aggregated at [Webshop; Day; Currency; Product Variant; Derivery Source Type; Loss Reason Code, Goods Loss Type and respective Detail] level');