CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_liam_market_article_feature (client_id, region_sid, period_id,
liam_parnt_clnt_cat_id, liam_clnt_cat_id, currency_iso_cd, household_in_country_cnt, buyer_cnt, turnover_val,
penetrate_abs_pct, feature1, feature2, feature3, feature4, feature5, feature6, feature7, feature8, feature9, feature10,
feature11, feature12, feature13, feature14) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_liam_market_article_feature;