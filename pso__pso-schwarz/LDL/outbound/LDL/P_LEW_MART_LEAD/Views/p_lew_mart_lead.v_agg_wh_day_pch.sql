CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_wh_day_pch (client_id, loc_sid_wh, wh_id, aspect_id, pcwo_reason_id,
sfotype_id, pch_bnl_switch_fg, currency_iso_cd, dwh_cal_dt, val_price_change) AS SELECT client_id,
 loc_sid_wh,
 wh_id,
 aspect_id,
 pcwo_reason_id,
 sfotype_id,
 pch_bnl_switch_fg,
 currency_iso_cd,
 dwh_cal_dt,
 val_price_change
FROM ldl_p_lew_mart_lead.t_agg_wh_day_pch AS V
UNION ALL
SELECT client_id,
 loc_sid_wh,
 wh_id,
 aspect_id,
 41 AS pcwo_reason_id,
 134 AS sfotype_id,
 1 AS pch_bnl_switch_fg,
 currency_iso_cd,
 dwh_cal_dt,
  discount_val_net * -1
FROM ldl_p_lew_mart_lead.t_agg_wh_day_pch_ldlpl_loyalty
WHERE pcwo_reason_id = 41
UNION ALL
SELECT client_id,
 loc_sid_wh,
 wh_id,
 aspect_id,
  CASE
  WHEN pcwo_reason_id = 41
  THEN 46
  ELSE pcwo_reason_id
  END AS pcwo_reason_id,
 134 AS sfotype_id,
 1 AS pch_bnl_switch_fg,
 currency_iso_cd,
 dwh_cal_dt,
 discount_val_net
FROM ldl_p_lew_mart_lead.t_agg_wh_day_pch_ldlpl_loyalty;