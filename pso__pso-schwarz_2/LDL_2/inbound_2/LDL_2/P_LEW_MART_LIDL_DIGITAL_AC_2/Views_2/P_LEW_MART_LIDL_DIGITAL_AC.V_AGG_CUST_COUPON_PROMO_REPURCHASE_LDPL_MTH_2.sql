/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
# 1.0 2025-02-14 Pawel Wieczorek         AP0235777 Initial versions
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_CUST_COUPON_PROMO_REPURCHASE_LDPL_MTH_2
COMMENT = 'Lidlplus : Customer repurchase rate for coupons'
(
 aspect_id                      COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
,client_id                      COMMENT 'Identifier for client'
,geo_area_sid                   COMMENT 'Identifier for geographical country_2'
,lidlplus_cust_fg               COMMENT 'Lidl Plus Customer Flag'
,loc_sid                        COMMENT 'Store ID'
,move_to_store_id               COMMENT 'Filialnummer nach letztem Filialumzug'
,wh_id                          COMMENT 'Warehouse ID'
,item_sid                       COMMENT 'Item_2 surrogate ID (uniquely across all countries/clients)'
,customer_sid                   COMMENT 'Customer identifier'
,mth_rf_segment_sid             COMMENT 'ids of recency-frequency segments from rfm model'
,mth_m_segment_sid              COMMENT 'ids of monetary segments from rfm model'
,gender_cd                      COMMENT 'The code for the gender'
,age_range_cd                   COMMENT 'The code for the age range.'
,household_type_id              COMMENT 'ID of the household type in which the customer lives.'
,child_age_range_group_id       COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.'
,feature_id                     COMMENT 'Categorization of LidlPlus Coupons and their Promotion : p_lew_core.t_ref_coupon_promotion_type.coupon_promo_type_sid based on SCRM NN.dim_promotion.promotion_type_description'
,coupon_type_id                 COMMENT 'Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_coupon_type.orig_coupon_type_sid based on SCRM L1.promotionhst.category'
,discount_type_id               COMMENT 'Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_discount_type.orig_discount_type_sid based on SCRM L1.promotionhst.discount_type'
,cy_month                       COMMENT 'Calendar_2 Year+Month in form YYYYMM'
,cy_month_prev_1m               COMMENT 'The calendar_2 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'
,cy_month_prev_1y               COMMENT 'The calendar_2 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'
,repurchase_1m_fg               COMMENT 'Repurchase flag case when Y the there was repurchase within 1 month'
,repurchase_3m_fg               COMMENT 'Repurchase flag case when Y the there was repurchase within 3 months'
,repurchase_12m_fg              COMMENT 'Repurchase flag case when Y the there was repurchase within 12 months'
,load_id                        COMMENT 'Load identifier'
,dwh_created                    COMMENT 'Row create time'
,dwh_updated                    COMMENT 'Row update time'
)
AS
SELECT
 t.aspect_id
,t.client_id
,t.geo_area_sid
,t.lidlplus_cust_fg
,t.loc_sid
,t.move_to_store_id
,t.wh_id
,t.item_sid
,t.customer_sid
,t.mth_rf_segment_sid
,t.mth_m_segment_sid
,t.gender_cd
,t.age_range_cd
,t.household_type_id
,t.child_age_range_group_id
,t.feature_id
,t.coupon_type_id
,t.discount_type_id
,t.cy_month
,t.cy_month_prev_1m
,t.cy_month_prev_1y
,t.repurchase_1m_fg
,t.repurchase_3m_fg
,t.repurchase_12m_fg
,t.load_id
,t.dwh_created
,t.dwh_updated
FROM p_lew_mart_lidl_digital.v_agg_cust_coupon_promo_repurchase_ldpl_mth_2 AS t
;