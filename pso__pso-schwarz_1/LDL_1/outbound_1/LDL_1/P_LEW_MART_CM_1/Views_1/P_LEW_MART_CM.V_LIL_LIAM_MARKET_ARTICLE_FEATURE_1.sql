CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_liam_market_article_feature_1 (client_id, region_sid, period_id,
liam_parnt_clnt_cat_id, liam_clnt_cat_id, currency_iso_cd, household_in_country_cnt, buyer_cnt, turnover_val,
penetrate_abs_pct, feature1, feature2, feature3, feature4, feature5, feature6, feature7, feature8, feature9, feature10,
feature11, feature12, feature13, feature14) AS SELECT CASE
  WHEN MAF.client_id = 33
  THEN 331
  ELSE MAF.client_id
  END AS client_id,
 MAF.region_sid,
 PP.period_id,
 SUBSTR(CAST(SUBSTR(ARC.assort_region_cat_id, 1, 13) || '00005000000000' AS STRING), 1, 27) AS liam_parnt_clnt_cat_id,
 SUBSTR(CAST(ARC.assort_region_cat_id AS STRING), 1, 27) AS liam_clnt_cat_id,
 SUBSTR(CAST(CER.to_currency_iso_cd AS STRING), 1, 3) AS currency_iso_cd,
 MAF.household_in_country_cnt,
 MAF.buyer_cnt,
   MAF.turnover_val / 1000 * CER.rate_currency_exchange AS turnover_val,
 MAF.penetrate_abs_pct,
 MAF.feature1_name AS feature1,
 MAF.feature2_name AS feature2,
 MAF.feature3_name AS feature3,
 MAF.feature4_name AS feature4,
 MAF.feature5_name AS feature5,
 MAF.feature6_name AS feature6,
 MAF.feature7_name AS feature7,
 MAF.feature8_name AS feature8,
 MAF.feature9_name AS feature9,
 MAF.feature10_name AS feature10,
 MAF.feature11_name AS feature11,
 MAF.feature12_name AS feature12,
 MAF.feature13_name AS feature13,
 MAF.feature14_name AS feature14
FROM ldl_p_lew_core_ac.v_market_article_feature_1 AS MAF
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_1 AS PP ON MAF.period_sid = PP.period_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat_1 AS ARC ON MAF.client_id = ARC.client_id AND MAF.region_sid
     = ARC.region_sid AND MAF.assort_cat_sid = ARC.assort_cat_sid
 INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt_1 AS CER ON MAF.curr_cd = CER.from_currency_iso_cd;