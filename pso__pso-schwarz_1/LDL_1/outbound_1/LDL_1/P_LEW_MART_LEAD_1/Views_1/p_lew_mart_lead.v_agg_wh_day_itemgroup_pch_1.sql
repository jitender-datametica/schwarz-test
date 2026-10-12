CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_wh_day_itemgroup_pch_1 (client_id, loc_sid_wh, wh_id, aspect_id,
itemgroup_int_id, pcwo_reason_id, sfotype_id, currency_iso_cd, pch_bnl_switch_fg, dwh_cal_dt, val_price_change) AS
SELECT client_id,
 loc_sid_wh,
 wh_id,
 aspect_id,
 itemgroup_int_id,
 pcwo_reason_id,
 sfotype_id,
 currency_iso_cd,
 pch_bnl_switch_fg,
 dwh_cal_dt,
 val_price_change
FROM ldl_p_lew_mart_lead.t_agg_wh_day_itemgroup_pch_1 AS V
UNION ALL
SELECT client_id,
 loc_sid_wh,
 wh_id,
 aspect_id,
 itemgroup_int_id,
 41 AS pcwo_reason_id,
 134 AS sfotype_id,
 currency_iso_cd,
 1 AS pch_bnl_switch_fg,
 dwh_cal_dt,
  discount_val_net * -1
FROM ldl_p_lew_mart_lead.t_agg_wh_day_itmgrp_pch_ldlpl_loyalty_1
WHERE pcwo_reason_id = 41
UNION ALL
SELECT client_id,
 loc_sid_wh,
 wh_id,
 aspect_id,
 itemgroup_int_id,
  CASE
  WHEN pcwo_reason_id = 41
  THEN 46
  ELSE pcwo_reason_id
  END AS pcwo_reason_id,
 134 AS sfotype_id,
 currency_iso_cd,
 1 AS pch_bnl_switch_fg,
 dwh_cal_dt,
 discount_val_net
FROM ldl_p_lew_mart_lead.t_agg_wh_day_itmgrp_pch_ldlpl_loyalty_1;