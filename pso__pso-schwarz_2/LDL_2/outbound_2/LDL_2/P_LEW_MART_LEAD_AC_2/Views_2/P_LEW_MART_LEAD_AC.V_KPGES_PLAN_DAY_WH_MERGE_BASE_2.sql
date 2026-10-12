CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_kpges_plan_day_wh_merge_base_2 (client_id, wh_id, aspect_id, indicator_id
, dat_formdate, val_indicator, currency_iso_cd, dat_dayend) AS SELECT *
FROM ldl_p_lew_mart_lead.v_kpges_plan_day_wh_merge_base_2;