/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
# 1.0 2025-02-14 Pawel Wieczorek         AP0235777 Initial versions
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_cust_coupon_promo_repurchase_ldpl_mth_2 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), geo_area_sid OPTIONS(description='Identifier for geographical country_2'),
lidlplus_cust_fg OPTIONS(description='Lidl Plus Customer Flag'), loc_sid OPTIONS(description='Store ID'),
move_to_store_id OPTIONS(description='Filialnummer nach letztem Filialumzug'), wh_id OPTIONS(description='Warehouse ID'),
item_sid OPTIONS(description='Item_2 surrogate ID (uniquely across all countries/clients)'), customer_sid
OPTIONS(description='Customer identifier'), mth_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), mth_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), gender_cd OPTIONS(description='The code for the gender'),
age_range_cd OPTIONS(description='The code for the age range.'), household_type_id
OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
feature_id
OPTIONS(description='Categorization of LidlPlus Coupons and their Promotion : p_lew_core.t_ref_coupon_promotion_type.coupon_promo_type_sid based on SCRM NN.dim_promotion.promotion_type_description'),
coupon_type_id
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_coupon_type.orig_coupon_type_sid based on SCRM L1.promotionhst.category'),
discount_type_id
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_discount_type.orig_discount_type_sid based on SCRM L1.promotionhst.discount_type'),
cy_month OPTIONS(description='Calendar_2 Year+Month in form YYYYMM'), cy_month_prev_1m
OPTIONS(description='The calendar_2 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y
OPTIONS(description='The calendar_2 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
repurchase_1m_fg OPTIONS(description='Repurchase flag case when Y the there was repurchase within 1 month'),
repurchase_3m_fg OPTIONS(description='Repurchase flag case when Y the there was repurchase within 3 months'),
repurchase_12m_fg OPTIONS(description='Repurchase flag case when Y the there was repurchase within 12 months'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDLPLUS : CUSTOMER REPURCHASE RATE FOR COUPONS`) AS
SELECT F.aspect_id,
 F.client_id,
 F.geo_area_sid,
 F.lidlplus_cust_fg,
 F.loc_sid,
 F.move_to_store_id,
 F.wh_id,
 F.item_sid,
 F.customer_sid,
 F.mth_rf_segment_sid,
 F.mth_m_segment_sid,
 COLLATE(COALESCE(D.gender_cd, 'N/A'), '') AS gender_cd,
 COLLATE(COALESCE(D.age_range_cd, 'N/A'), '') AS age_range_cd,
 COALESCE(D.household_type_id, 0) AS household_type_id,
 COALESCE(D.child_age_range_group_id, 0) AS child_age_range_group_id,
 F.feature_id,
 F.coupon_type_id,
 F.discount_type_id,
 F.cy_month,
 F.cy_month_prev_1m,
 F.cy_month_prev_1y,
 F.repurchase_1m_fg,
 F.repurchase_3m_fg,
 F.repurchase_12m_fg,
 F.load_id,
 F.dwh_created,
 F.dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_cust_coupon_promo_repurchase_ldpl_mth_2 AS F
 LEFT JOIN ldl_p_lew_mart_lidl_digital.t_cust_demogr_2 AS D ON F.customer_sid = D.customer_sid;