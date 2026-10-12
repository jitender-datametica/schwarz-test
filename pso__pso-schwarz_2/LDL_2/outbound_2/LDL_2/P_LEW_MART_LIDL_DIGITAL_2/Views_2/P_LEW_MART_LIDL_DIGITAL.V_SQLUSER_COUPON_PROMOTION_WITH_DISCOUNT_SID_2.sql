/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2022-10-03 Pawel Wieczorek   Initial version AP0144589
#  1.1 2022-10-04 Pawel Wieczorek   AP0144589 Fixed comments and aggregation
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_sqluser_coupon_promotion_with_discount_sid_2 (coupon_promo_sid
OPTIONS(description='coupon id coming from t_coupon_promotion_hist_2 (may be NULL)'), src_coupon_promo_nr
OPTIONS(description='identifier of the coupon_promotion within LidlPlus/SCRM source system SCRM: external_id (may be NULL)'),
coupon_promo_type_sid
OPTIONS(description='Categorization of LidlPlus Coupons and their Promotion : p_lew_core.t_ref_coupon_promotion_type.coupon_promo_type_sid based on SCRM NN.dim_promotion.promotion_type_description (may be NULL)'),
orig_coupon_type_sid
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_coupon_type.orig_coupon_type_sid based on SCRM L1.promotionhst.category (may be NULL)'),
orig_discount_type_sid
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_discount_type.orig_discount_type_sid based on SCRM L1.promotionhst.discount_type (may be NULL)'),
iso_country_code OPTIONS(description='Lidl-Land_2-Code'), client_id OPTIONS(description='Identifier for client'),
discount_sid
OPTIONS(description='Surrogate Key (DWH id) for the Promotion_ID of the EJR; WAWI-DWH: t_ejr_receiptline.discount_id'),
coupon_promo_start_dt OPTIONS(description='Date of promotion start (may be NULL)'), coupon_promo_end_dt
OPTIONS(description='Date of promotion finish (may be NULL)'), receiptline_inside_validity
OPTIONS(description='Valid coupon within receiptline dwh_cal_dt : 1 yes, 0 no'))
OPTIONS(DESCRIPTION = `Usage of coupons in t_pos_receiptline_coupon_promotion_discount_2`) AS WITH CLIENTS AS (SELECT
   client_id,
   country_cd AS iso_country_code
  FROM ldl_p_lew_core.t_client_2 AS C
  WHERE client_online_fg = 0
   AND lob_cd = 'LDL'), COUPON_PROMOTIONS AS (SELECT CPH.coupon_promo_sid,
   CPH.src_coupon_promo_nr,
   CPH.coupon_promo_type_sid,
   CH.orig_coupon_type_sid,
   CH.orig_discount_type_sid,
   CPH.client_id,
   CPH.coupon_promo_start_dt,
   CPH.coupon_promo_end_dt
  FROM ldl_p_lew_core.t_coupon_promotion_hist_2 AS CPH
   LEFT JOIN ldl_p_lew_core.t_coupon_hist_2 AS CH ON CPH.coupon_sid = CH.coupon_sid AND CURRENT_DATE BETWEEN CH.dwh_valid_from
      AND CH.dwh_valid_to AND CH.deleted_fg = 0
  WHERE CURRENT_DATE BETWEEN CPH.dwh_valid_from AND CPH.dwh_valid_to
   AND CPH.deleted_fg = 0), HUGE_RECEIPTLINE_JOIN AS (SELECT RCPD.coupon_promo_sid,
   COALESCE(RCPD.src_coupon_promo_nr, cp.src_coupon_promo_nr) AS src_coupon_promo_nr,
   cp.coupon_promo_type_sid,
   cp.orig_coupon_type_sid,
   cp.orig_discount_type_sid,
   c.iso_country_code,
   RCPD.client_id,
   RCPD.discount_sid,
   cp.coupon_promo_start_dt,
   cp.coupon_promo_end_dt,
    CASE
    WHEN RCPD.dwh_cal_dt BETWEEN cp.coupon_promo_start_dt AND cp.coupon_promo_end_dt
    THEN 1
    ELSE 0
    END AS receiptline_inside_validity
  FROM ldl_p_lew_core.t_pos_receiptline_coupon_promotion_discount_2 AS RCPD
   INNER JOIN CLIENTS AS c ON RCPD.client_id = c.client_id
   LEFT JOIN COUPON_PROMOTIONS AS cp ON RCPD.coupon_promo_sid = cp.coupon_promo_sid),
 COUPON_PROMOTIONS_WITH_DISCOUNT_SID AS (SELECT coupon_promo_sid,
   src_coupon_promo_nr,
   coupon_promo_type_sid,
   orig_coupon_type_sid,
   orig_discount_type_sid,
   iso_country_code,
   client_id,
   discount_sid,
   coupon_promo_start_dt,
   coupon_promo_end_dt,
   MAX(receiptline_inside_validity) AS receiptline_inside_validity
  FROM HUGE_RECEIPTLINE_JOIN
  GROUP BY coupon_promo_sid,
   src_coupon_promo_nr,
   coupon_promo_type_sid,
   orig_coupon_type_sid,
   orig_discount_type_sid,
   iso_country_code,
   client_id,
   discount_sid,
   coupon_promo_start_dt,
   coupon_promo_end_dt) (/* countries, but no record for LU */
  /* There are discount receiptlines, which do not have a coupon_promotion at SCRM: test_2 External_IDs, External_IDs "NotSet", "Personalized" or even NULL
  There may be coupon_promotions, which do not (yet) have a single discount receiptline. But these are not displayed here */
  SELECT coupon_promo_sid,
   src_coupon_promo_nr,
   coupon_promo_type_sid,
   orig_coupon_type_sid,
   orig_discount_type_sid,
   iso_country_code,
   client_id,
   discount_sid,
   coupon_promo_start_dt,
   coupon_promo_end_dt,
   receiptline_inside_validity
  FROM COUPON_PROMOTIONS_WITH_DISCOUNT_SID);