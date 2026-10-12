CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_lift_period_portion_2 (client_id, per_id, lift_cat_id, rtl_id, rtl_lvl,
prom_id, period_portion_id, currency_iso_cd, household_in_country_cnt, turnover_val, pot_turnover_val,
household_penetrate_pct, buyer_cnt, pot_buyer_cnt, trip_cnt, buy_freq, spend_per_buyer_val, spend_per_trip_val,
category_lidl_val, pot_turnover_exploit_pct, loyalty_pct, closure_rate_pct, buyer_quality, lidl_market_share_pct,
py_household_in_country_cnt, py_turnover_val, py_pot_turnover_val, py_household_penetrate_pct, py_buyer_cnt,
py_pot_buyer_cnt, py_trip_cnt, py_buy_freq, py_spend_per_buyer_val, py_spend_per_trip_val, py_category_lidl_val,
py_pot_turnover_exploit_pct, py_loyalty_pct, py_closure_rate_pct, py_buyer_quality, py_lidl_market_share_pct,
raw_buyer_id, per_desc, per_desc_en, py_per_desc, py_per_desc_en) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_lift_period_portion_2;