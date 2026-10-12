CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_kpges_day_country (client_id, indicator_id, dat_formdate, val_indicator
, currency_iso_cd, dat_dayend, curr_tot_id) AS SELECT *
FROM ldl_p_lew_mart_lead.v_kpges_day_country;