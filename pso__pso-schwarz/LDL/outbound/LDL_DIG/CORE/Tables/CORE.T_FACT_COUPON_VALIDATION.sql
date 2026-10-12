/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_COUPON_VALIDATION
   GENERATED FROM POWERDESIGNER ON Donnerstag, 24. August 2023 14:46:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_coupon_validation (
coupon_validation_nr BIGNUMERIC NOT NULL OPTIONS(description='Unique identifier of the coupon redemption event'),
cust_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for customer order'),
prod_variant_sid BIGNUMERIC NOT NULL OPTIONS(description='Ordered product'),
coupon_id STRING(40) OPTIONS(description='A identifier of the coupon. This identifier is entirely unique'),
coupon_cd STRING(50) OPTIONS(description='A business key that uniquely identifies a coupong'),
coupon_promo_cd STRING(50)
OPTIONS(description='A business key that uniquely identifies the promotion campaign to which this coupon belongs.'),
profit_loss_reason_cd STRING(5) OPTIONS(description='The code for the reason of profit/loss  ( 327, 326... etc)'),
curr_cd STRING(5) OPTIONS(description='Currency code in which order has been payed'),
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product ordered'),
coupon_validation_tmsp TIMESTAMP
OPTIONS(description='Point in time when coupon was used in an order'),
coupon_ship_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='The discount amount of the shipping cost (allocated to this product) provided by the coupon '),
coupon_item_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Discount amount for single product item  provided by the coupon'),
coupon_pos_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Discount amount for the order positions (all items ot this product) provided by the coupon'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (coupon_validation_nr, cust_order_sid, prod_variant_sid) NOT ENFORCED
) OPTIONS(description='Table contains events of discount coupons applied to an order ');