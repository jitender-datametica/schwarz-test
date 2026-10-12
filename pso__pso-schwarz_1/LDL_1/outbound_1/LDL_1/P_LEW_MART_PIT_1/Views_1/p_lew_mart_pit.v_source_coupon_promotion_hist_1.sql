/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_COUPON_PROMOTION_HIST_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_COUPON_PROMOTION_HIST_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-01-22 Nikolai Toknov	   Initial version
#  1.1  2024-02-12 Nikolai Toknov		add WA to remove duplicates
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_COUPON_PROMOTION_HIST_1
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_coupon_promotion_hist_1
OPTIONS(DESCRIPTION = `SOURCE VIEW LIDL PLUS COUPON_PROMOTION_HIST`) AS SELECT client_id,
 coupon_promo_sid,
 coupon_promo_type_sid,
 coupon_sid,
 src_coupon_promo_nr,
 src_coupon_promo_viz_nr,
 coupon_promo_benefit_txt,
 coupon_promo_start_dt,
 coupon_promo_end_dt,
 scratch_redemtion_day_qty,
 COALESCE(dwh_valid_from, PARSE_DATE('%F', '1900-01-01')) AS valid_from_dt,
 COALESCE(dwh_valid_to, PARSE_DATE('%F', '9999-12-31')) AS valid_to_dt,
 COALESCE(CAST(deleted_fg AS BIGNUMERIC), 0) AS deleted_fg,
 dwh_updated AS dwh_updated_ts
FROM ldl_p_lew_core.t_coupon_promotion_hist_1 AS CPH
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(coupon_promo_sid AS STRING), COALESCE(dwh_valid_to
       , PARSE_DATE('%F', '9999-12-31')) ORDER BY dwh_updated IS NULL DESC, dwh_updated DESC)) = 1;