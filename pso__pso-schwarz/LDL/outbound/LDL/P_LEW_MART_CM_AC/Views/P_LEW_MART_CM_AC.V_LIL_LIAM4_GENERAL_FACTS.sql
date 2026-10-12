CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_liam4_general_facts (client_id, liam_clnt_cat_id, per_id,
liam_parnt_clnt_cat_id, currency_iso_cd, volume_type, buyer_cnt, turnover_val, penetrate_abs_pct,
household_in_country_cnt, feature1_name, feature2_name, feature3_name, feature4_name, feature5_name, feature6_name,
feature7_name, feature8_name, feature9_name, feature10_name, feature11_name, feature12_name, feature13_name,
feature14_name, total_market_desc, total_market_id, retailer1_desc, retailer1_id, retailer2_desc, retailer2_id,
retailer3_desc, retailer3_id) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_liam4_general_facts;