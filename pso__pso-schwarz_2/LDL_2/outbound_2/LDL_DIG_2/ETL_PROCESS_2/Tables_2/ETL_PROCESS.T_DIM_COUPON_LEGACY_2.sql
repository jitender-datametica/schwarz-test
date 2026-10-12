/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COUPON_LEGACY_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 22. August 2023 08:46:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_dim_coupon_legacy_2 (
coupon_id BIGNUMERIC NOT NULL OPTIONS(description='A identifier of the coupon. This identifier is entirely unique'),
coupon_cd STRING(50)
OPTIONS(description='A business key that uniquely identifies a coupon. Same coupon Code can be used in different campaigns'),
coupon_promo_cd STRING(50)
OPTIONS(description='A business key that uniquely identifies the promotion campaign to which this coupon belongs.'),
coupon_promo_name STRING(100) OPTIONS(description='The name of the promotion campaign to which this coupon belongs.'),
coupon_valid_from_tmsp TIMESTAMP
OPTIONS(description='The first point in time when this coupon can be used (date when the promotion begins)'),
coupon_valid_to_tmsp TIMESTAMP
OPTIONS(description='The last point in time when this coupon can be used (date when the promotion ends)'),
coupon_type_cd STRING(20) OPTIONS(description='Code identifying the coupon type (ex\'GENERIC\',\'PROMOTION\')'),
coupon_max_redemption_cnt BIGNUMERIC
OPTIONS(description='Maximum number times this coupon  can be used by one cusotmer'),
prod_food_class_cd STRING(5) OPTIONS(description='The code for the indicating if product is a food or non food'),
discount_ship_fg BOOL OPTIONS(description='Flag that indicates if coupon offers discount of shipping cost'),
discount_percentage_fg BOOL
OPTIONS(description='Flag that indicates if coupon offers discount of product cost as percentage of the price'),
discount_fixed_fg BOOL
OPTIONS(description='Flag that indicates if coupon offers discount of product cost - a fixed amount'),
discount_buyx_payy_fg BOOL
OPTIONS(description='Flag that indicates if coupon allows you to buy X number of items at the price of Y items (ex. buy 3 for the price of 2)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (coupon_id) NOT ENFORCED
)
OPTIONS(description='The table contains legacy coupon data coming from a decommissioned source system and describes promotion coupons that were used to get discounted price for an item_2 or reduced/free shipping cost for an order. The table countains both individual (personal) coupons as well as generic coupons (coupons that are part of promotion campaign relevant to all customers)');