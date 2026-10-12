CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_liam_market_article_feature_pos (client_id, region_sid, period_id,
liam_parnt_clnt_cat_id, liam_clnt_cat_id, assort_cat_subfamily_sid, currency_iso_cd, rank_pos, brand_type_txt,
product_name, manufacturer, brand, pack_size, ean, category_family, category_subfamily_name, feature1, feature2,
feature3, feature4, feature5, feature6, feature7, feature8, feature9, feature10, feature11, feature12, feature13,
feature14, turnover_val, turnover_prom_val, promotion_share_pct, trip_cnt, buyer_cnt, extrapol_package_cnt,
weight_type_txt, avg_price_per_pack_val, packs_per_trip_cnt, penetrate_cum_abs_pct, penetrate_cum_rel_pct,
penetrate_diff_cum_rel_pct, penetrate_single_rel_pct, penetrate_exclusive_rel_pct, exclusive_buyer_assortment_pct,
assortment_depth_per_buyer_cnt, turnover_cum_all_pct, turnover_cum_product_pct, total_market_turnover_val,
total_market_promotion_share_pct, total_market_extrapol_package_cnt, lidl_turnover_val, lidl_promotion_share_pct,
lidl_extrapol_package_cnt, competitor1_turnover_val, competitor1_promotion_share_pct, competitor1_extrapol_package_cnt,
competitor2_turnover_val, competitor2_promotion_share_pct, competitor2_extrapol_package_cnt, retailer_comp1_id,
retailer_comp2_id) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_liam_market_article_feature_pos;