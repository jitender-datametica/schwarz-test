CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_dim_currency_1 (curr_cd, curr_name, curr_name_de, curr_name_en, curr_name_bg
, curr_name_cs, curr_name_da, curr_name_el, curr_name_es, curr_name_fi, curr_name_fr, curr_name_hr, curr_name_hu,
curr_name_it, curr_name_lt, curr_name_nl, curr_name_pl, curr_name_pt, curr_name_ro, curr_name_sh, curr_name_sk,
curr_name_sl, curr_name_sv, used_in_lidl_countries_fg, euro_exchange_rate, dwh_load_id, dwh_created, dwh_updated) AS
SELECT *
FROM ldl_p_lew_bil_ac.v_dim_currency_1 AS CURR;