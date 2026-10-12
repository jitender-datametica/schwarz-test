CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_wh_day_pch_1 (client_id, loc_sid_wh, wh_id, aspect_id, pcwo_reason_id
, sfotype_id, pch_bnl_switch_fg, currency_iso_cd, dwh_cal_dt, val_price_change) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_wh_day_pch_1 AS V;