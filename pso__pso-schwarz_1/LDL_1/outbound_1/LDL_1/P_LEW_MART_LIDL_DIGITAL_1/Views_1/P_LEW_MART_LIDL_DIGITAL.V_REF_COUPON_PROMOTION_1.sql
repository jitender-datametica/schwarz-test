/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: Coupon Promotion
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#
#  1.0 2022-09-26 Marcin Kikola         Initial version created for AP0144589
#                                       Implementation of external_id logic
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   VIEW DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_coupon_promotion_1 (client_id
OPTIONS(description='Identifier for client'), coupon_promo_sid
OPTIONS(description='Coupon id coming from t_coupon_promotion_hist_1'), src_coupon_promo_nr
OPTIONS(description='Identifier of the coupon_promotion within LidlPlus/SCRM source system SCRM: external_id'),
src_coupon_promo_viz_nr
OPTIONS(description='Identifier of the promotion based on external_id but simpler to visualize (has 1 to 1 relation with external_id)'),
feature_id
OPTIONS(description='Categorization of LidlPlus Coupons and their Promotion : p_lew_core.t_ref_coupon_promotion_type.coupon_promo_type_sid based on SCRM NN.dim_promotion.promotion_type_description'),
coupon_type_id
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_coupon_type.orig_coupon_type_sid based on SCRM L1.promotionhst.category'),
discount_type_id
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_discount_type.orig_discount_type_sid based on SCRM L1.promotionhst.discount_type'),
load_id OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row insert time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDLPLUS : COUPON PROMOTION TABLE`) AS SELECT client_id,
 coupon_promo_sid,
 src_coupon_promo_nr,
 src_coupon_promo_viz_nr,
 feature_id,
 coupon_type_id,
 discount_type_id,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ref_coupon_promotion_1;