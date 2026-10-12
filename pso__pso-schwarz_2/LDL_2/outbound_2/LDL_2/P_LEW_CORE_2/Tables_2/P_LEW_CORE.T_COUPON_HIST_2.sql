/* --------------------------------------------------------------------------------
   DDL for table: t_coupon_hist_2
   generated from Powerdesigner on Mittwoch, 19. Juni 2024 16:06:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_coupon_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
coupon_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the Coupon (surrogate key)'),
coupon_type_cd STRING(40) COLLATE 'und:ci'
OPTIONS(description='unique code identifying the type of the coupon, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.'),
coupon_nr STRING(50) COLLATE 'und:ci' OPTIONS(description='a number that is used to identify a certain coupon'),
coupon_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='the name of the coupon, i.e. giving a hint for what coupon it is (like Gratis Gasanzuender or 10% Parika-Mischung)'),
loyalty_prog_cd STRING(5) COLLATE 'und:ci' OPTIONS(description='identifier of the loyalty program: LPLUS (LidlPlus)'),
geo_area_sid BIGNUMERIC(38,0) OPTIONS(description='unique identifier of the geographical area (surrogate key)'),
geo_area_cd STRING(5) COLLATE 'und:ci' OPTIONS(description='code of the geographical area'),
coupon_status_cd STRING(5) COLLATE 'und:ci'
OPTIONS(description='unique code describing the status_2 of a coupon, e.g. being planned, activated or deactivated'),
coupon_activation_tmsp DATETIME OPTIONS(description='time when the coupon is visible to the customer in the the app'),
coupon_valid_from_tmsp DATETIME
OPTIONS(description='start timestamp when the coupon can be used by customers to get discount on their purchase'),
coupon_valid_to_tmsp DATETIME
OPTIONS(description='end timestamp when the coupon can be used by customers to get discount on their purchase'),
discount_type_cd STRING(40) COLLATE 'und:ci'
OPTIONS(description='unique code for the discount type, e.g. X Percentage, XForY, SpecialPrice, etc.'),
curr_cd STRING(2) COLLATE 'und:ci'
OPTIONS(description='currency cde for the discount value or special price of a product'),
reduced_sales_price BIGNUMERIC(38,5)
OPTIONS(description='the special price of the product that is linked to the coupon'),
discount_val BIGNUMERIC(38,5)
OPTIONS(description='by how much money amount the product that is linked to coupon is reduced, e.g. 0.50€ discount on peppers'),
discount_pct BIGNUMERIC(38,5)
OPTIONS(description='by how much percent the product that is linked to the coupon is reduced; e.g. 10% on peppers'),
discount_x_cnt BIGNUMERIC(38,0)
OPTIONS(description='how many pieces a customer needs to buy in order to get some free, i.e. the customer gets y_cnt'),
discount_y_cnt BIGNUMERIC(38,0) OPTIONS(description='how many pieces the customer gets in case he buys x_cnt'),
orig_discount_type_sid BIGNUMERIC(38,0)
OPTIONS(description='unique identifier of the discount_type in SCRM table promotionhst (surrogate key)'),
orig_coupon_type_sid BIGNUMERIC(38,0)
OPTIONS(description='unique identifier of the category in SCRM table promotionhst (surrogate key)'),
coupon_reason_nr BIGNUMERIC(38,0) OPTIONS(description='identifier of the coupon reason in SCRM'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Coupon is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (coupon_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id, coupon_sid
OPTIONS(description='$Revision: 0000 $. A coupon reduces the amount that the customer needs to pay for his/her purchase or gives free products for the purchase.');