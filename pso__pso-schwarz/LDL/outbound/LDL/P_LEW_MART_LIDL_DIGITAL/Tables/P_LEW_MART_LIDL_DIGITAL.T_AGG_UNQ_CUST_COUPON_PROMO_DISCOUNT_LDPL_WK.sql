/*
 * History:
 * 
 * 1.0 2022-01-24 Pawel Wieczorek         #266102 Initial versions
 * 1.1 2022-01-24 Pawel Wieczorek         #266102 Remove space from comments - Table definitions must use trailing commas (test_table_comma_trailing), change comma to the end of line
 * 1.2 2022-08-04 Pawel Wieczorek         AP0056182_coupon_promo_discount_2 #282119 changing precision for discount_val NUMBER(18,5) -> NUMBER(25,10) 
 * 1.3 2022-09-23 Marcin Kikola           AP0144589 external id logic added to the definition of the table. Coupon_promo_sid added as id for external id
 */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_unq_cust_coupon_promo_discount_ldpl_wk (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
cy_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.    [Week Identifier]'),
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filialnummer nach letztem Filialumzug'),
lidlplus_cust_fg STRING NOT NULL OPTIONS(description='Lidl Plus Customer Flag'),
customer_sid INTEGER NOT NULL OPTIONS(description='Customer identifier'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
curr_tot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'),
coupon_promo_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier of the coupon_promotion (surrogate key in t_coupon_promotion_hist. Default value for Sonstige -2)'),
feature_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Categorization of LidlPlus Coupons and their Promotion : p_lew_core.t_ref_coupon_promotion_type.coupon_promo_type_sid based on SCRM NN.dim_promotion.promotion_type_description'),
coupon_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_coupon_type.orig_coupon_type_sid based on SCRM L1.promotionhst.category'),
discount_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_discount_type.orig_discount_type_sid based on SCRM L1.promotionhst.discount_type'),
cw_cust_act BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Current Week Customer Active flag 1 for active 0 for not active'),
pw_cust_act BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Previous Week Customer Active flag 1 for active 0 for not active'),
pyw_cust_act BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Previous Year Week Customer Active flag 1 for active 0 for not active'),
cw_discount_val BIGNUMERIC(25,10) NOT NULL OPTIONS(description='Current Week Discount value'),
pw_discount_val BIGNUMERIC(25,10) NOT NULL OPTIONS(description='Previous Week Discount value'),
pyw_discount_val BIGNUMERIC(25,10) NOT NULL OPTIONS(description='Previous Year Week Discount value'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_inserted DATETIME NOT NULL OPTIONS(description='Row insert time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (aspect_id, client_id, cy_week, currency_iso_cd, feature_id, coupon_type_id, discount_type_id) NOT ENFORCED
) OPTIONS(description='Lidlplus : Unique customer for coupon promotion discount aggregated to week level');