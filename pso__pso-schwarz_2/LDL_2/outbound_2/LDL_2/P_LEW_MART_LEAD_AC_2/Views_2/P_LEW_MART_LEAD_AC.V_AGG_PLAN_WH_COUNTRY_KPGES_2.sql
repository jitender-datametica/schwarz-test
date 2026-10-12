CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_plan_wh_country_kpges_2 (client_id, wh_id, aspect_id, indicator_id,
byr, cy_month, val_indicator, currency_iso_cd, curr_tot_id) AS SELECT client_id,
 wh_id,
 aspect_id,
 indicator_id,
 byr,
 cy_month,
 val_indicator,
 currency_iso_cd,
 curr_tot_id
FROM ldl_p_lew_mart_lead.v_agg_plan_wh_country_kpges_2;