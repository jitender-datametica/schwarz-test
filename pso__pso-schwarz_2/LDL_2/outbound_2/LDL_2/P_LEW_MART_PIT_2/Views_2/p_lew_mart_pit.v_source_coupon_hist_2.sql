/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_COUPON_HIST_2
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_COUPON_HIST_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-01-22 Nikolai Toknov	   Initial version
#  1.1  2025-05-14 Nikolai Toknov	   Inkrement 2.1 CR new types of LP-promotions(Mail: 09.05.2025)
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_COUPON_HIST_2
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_coupon_hist_2
OPTIONS(DESCRIPTION = `SOURCE VIEW LIDL PLUS COUPON_HIST`) AS SELECT CH.client_id,
 CH.coupon_sid,
 CH.coupon_type_cd,
 CH.coupon_nr,
 CH.coupon_name,
 CH.loyalty_prog_cd,
 CH.geo_area_sid,
 CH.geo_area_cd,
 CH.coupon_status_cd,
 CH.discount_type_cd,
 CH.curr_cd,
 CH.reduced_sales_price AS coupon_reduced_sales_price,
 CH.discount_val AS coupon_discount_val,
 CH.discount_pct AS coupon_discount_pct,
 CH.discount_x_cnt AS coupon_discount_x_cnt,
 CH.discount_y_cnt AS coupon_discount_y_cnt,
 CH.orig_discount_type_sid,
 CH.orig_coupon_type_sid,
 CH.coupon_reason_nr,
 RCT.orig_coupon_type_descr AS coupon_orig_coupon_type_descr,
 COALESCE(CH.dwh_valid_from, PARSE_DATE('%F', '1900-01-01')) AS valid_from_dt,
 COALESCE(CH.dwh_valid_to, PARSE_DATE('%F', '9999-12-31')) AS valid_to_dt,
 COALESCE(CAST(CH.deleted_fg AS BIGNUMERIC), 0) AS deleted_fg,
 CH.dwh_updated AS dwh_updated_ts
FROM ldl_p_lew_core.t_coupon_hist_2 AS CH
 LEFT JOIN ldl_p_lew_core.t_ref_orig_coupon_type_2 AS RCT ON CH.orig_coupon_type_sid = RCT.orig_coupon_type_sid;