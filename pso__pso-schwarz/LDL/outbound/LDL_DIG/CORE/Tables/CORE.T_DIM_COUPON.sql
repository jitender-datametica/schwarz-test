/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COUPON
   GENERATED FROM POWERDESIGNER ON Montag, 26. Februar 2024 15:47:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_coupon (
coupon_id STRING(40) NOT NULL OPTIONS(description='A identifier of the coupon. This identifier is entirely unique'),
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
coupon_discount_type_cd STRING(20)
OPTIONS(description='Code identifying the discount type (e.g. Monetary, Percentage, etc.)'),
coupon_max_redemption_cnt BIGNUMERIC
OPTIONS(description='Maximum number times this coupon  can be used by one cusotmer'),
prod_food_class_cd STRING(5) OPTIONS(description='The code for the indicating if product is a food or non food'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
discount_ship_fg BOOL OPTIONS(description='Flag that indicates if coupon offers discount of shipping cost'),
coupon_discount_pct BIGNUMERIC(38,5) OPTIONS(description='Discount percentage provided by the coupon.'),
coupon_discount_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Gross discount amount provided by the coupon in local currency.'),
src_sys_name STRING(100) OPTIONS(description='The name of the source system delivering the data'),
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
OPTIONS(description='The table describes promotion coupons that can be used to get discounted price for an item or reduced/free shipping cost for an order. The table countains both individual (personal) coupons as well as generic coupons (coupons that are part of promotion campaign relevant to all customers)');