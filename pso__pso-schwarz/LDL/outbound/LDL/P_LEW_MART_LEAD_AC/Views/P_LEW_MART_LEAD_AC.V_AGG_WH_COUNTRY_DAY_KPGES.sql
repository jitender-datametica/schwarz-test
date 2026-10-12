CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_wh_country_day_kpges (client_id, wh_id, indicator_id, dat_formdate,
cy_week, cy_month, byr, val_indicator, currency_iso_cd, curr_tot_id) AS SELECT client_id,
 wh_id,
 indicator_id,
 dat_formdate,
 cy_week,
 cy_month,
 byr,
 val_indicator,
 currency_iso_cd,
 curr_tot_id
FROM ldl_p_lew_mart_lead.v_agg_wh_country_day_kpges;