CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_ITEMGROUP_INT_BUY_PRICE_RANGE_2
AS
   SELECT
     client_id,
   src_itemgrp_int_cd,
   src_subitemgrp_cd,
   buy_price_range_days,
   dwh_valid_from,
   dwh_valid_to
  FROM p_lew_mart_analytics.t_itemgroup_int_buy_price_range_2
;