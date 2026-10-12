/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_COUPON_TO_ITEM_HIST_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_COUPON_TO_ITEM_HIST_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-01-22 Nikolai Toknov	   Initial version
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_COUPON_TO_ITEM_HIST_1
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_coupon_to_item_hist_1
OPTIONS(DESCRIPTION = `SOURCE VIEW LIDL PLUS COUPON_TO_ITEM_HIST`) AS SELECT client_id,
 coupon_sid,
 item_sid,
 COALESCE(dwh_valid_from, PARSE_DATE('%F', '1900-01-01')) AS valid_from_dt,
 COALESCE(dwh_valid_to, PARSE_DATE('%F', '9999-12-31')) AS valid_to_dt,
 COALESCE(CAST(deleted_fg AS BIGNUMERIC), 0) AS deleted_fg,
 dwh_updated AS dwh_updated_ts
FROM ldl_p_lew_core.t_coupon_to_item_hist_1 AS C_ITM;