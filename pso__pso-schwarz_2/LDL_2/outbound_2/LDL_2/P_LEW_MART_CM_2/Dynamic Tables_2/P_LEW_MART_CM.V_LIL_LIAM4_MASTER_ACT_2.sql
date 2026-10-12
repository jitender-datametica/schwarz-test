CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_liam4_master_act_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT CAST(REG.region_id AS BIGNUMERIC) AS client_id,
 PER.period_id,
 SUBSTR(CAST(SUBSTR(ASMP.assort_region_cat_id, 1, 13) || '00005000000000' AS STRING), 1, 27) AS liam_parnt_clnt_cat_id,
 SUBSTR(CAST(ASMP.assort_region_cat_id AS STRING), 1, 27) AS liam_clnt_cat_id,
 CAST(POS.rank_pos AS BIGNUMERIC) AS pos_nr,
 CAST(POS.manufacturer AS STRING) AS pos_manufacturer,
 CAST(POS.brand_2 AS STRING) AS pos_brand,
 CAST(POS.product_name AS STRING) AS pos_product_name,
 CAST(POS.pack_size AS STRING) AS pos_pack_size,
 CAST(POS.ean_2 AS STRING) AS pos_ean,
 CAST(POS.category_family AS STRING) AS pos_category_family,
 CAST(POS.feature1_content AS STRING) AS feature1,
 CAST(POS.feature2_content AS STRING) AS feature2,
 CAST(POS.feature3_content AS STRING) AS feature3,
 CAST(POS.feature4_content AS STRING) AS feature4,
 CAST(POS.feature5_content AS STRING) AS feature5,
 CAST(POS.feature6_content AS STRING) AS feature6,
 CAST(POS.feature7_content AS STRING) AS feature7,
 CAST(POS.feature8_content AS STRING) AS feature8,
 CAST(POS.feature9_content AS STRING) AS feature9,
 CAST(POS.feature10_content AS STRING) AS feature10,
 CAST(POS.feature11_content AS STRING) AS feature11,
 CAST(POS.feature12_content AS STRING) AS feature12,
 CAST(POS.feature13_content AS STRING) AS feature13,
 CAST(POS.feature14_content AS STRING) AS feature14,
 CAST(POS.penetrate_cum_rel_pct AS NUMERIC) AS pos_penetrate_cum_rel_pct,
 1 AS prot_fg
FROM ldl_p_lew_core_ac.v_market_article_feature_pos_2 AS POS
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_2 AS REG ON POS.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_2 AS PER ON POS.client_id = PER.client_id AND POS.period_sid = PER.period_sid
   
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat_2 AS ASMP ON POS.client_id = ASMP.client_id AND POS.region_sid
     = ASMP.region_sid AND POS.assort_cat_sid = ASMP.assort_cat_sid
UNION ALL
SELECT CAST(REG.region_id AS BIGNUMERIC) AS client_id,
 PER.period_id,
 SUBSTR(CAST(SUBSTR(ASMP.assort_region_cat_id, 1, 13) || '00005000000000' AS STRING), 1, 27) AS liam_parnt_clnt_cat_id,
 SUBSTR(CAST(ASMP.assort_region_cat_id AS STRING), 1, 27) AS liam_clnt_cat_id,
 0 AS pos_nr,
 CAST(NULL AS STRING) AS manufacturer,
 CAST(NULL AS STRING) AS brand_2,
 CAST(NULL AS STRING) AS product_name,
 CAST(NULL AS STRING) AS pack_size,
 CAST(NULL AS STRING) AS ean_2,
 CAST(NULL AS STRING) AS category_family,
 CAST(FEAT.feature1_name AS STRING) AS feature1,
 CAST(FEAT.feature2_name AS STRING) AS feature2,
 CAST(FEAT.feature3_name AS STRING) AS feature3,
 CAST(FEAT.feature4_name AS STRING) AS feature4,
 CAST(FEAT.feature5_name AS STRING) AS feature5,
 CAST(FEAT.feature6_name AS STRING) AS feature6,
 CAST(FEAT.feature7_name AS STRING) AS feature7,
 CAST(FEAT.feature8_name AS STRING) AS feature8,
 CAST(FEAT.feature9_name AS STRING) AS feature9,
 CAST(FEAT.feature10_name AS STRING) AS feature10,
 CAST(FEAT.feature11_name AS STRING) AS feature11,
 CAST(FEAT.feature12_name AS STRING) AS feature12,
 CAST(FEAT.feature13_name AS STRING) AS feature13,
 CAST(FEAT.feature14_name AS STRING) AS feature14,
 CAST(NULL AS NUMERIC) AS penetrate_cum_rel_pct,
 1 AS prot_fg
FROM ldl_p_lew_core_ac.v_market_article_feature_2 AS FEAT
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_2 AS REG ON FEAT.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_2 AS PER ON FEAT.client_id = PER.client_id AND FEAT.period_sid = PER.period_sid
   
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat_2 AS ASMP ON FEAT.client_id = ASMP.client_id AND FEAT.region_sid
     = ASMP.region_sid AND FEAT.assort_cat_sid = ASMP.assort_cat_sid
UNION ALL
SELECT CAST(REG.region_id AS BIGNUMERIC) AS client_id,
 PER.period_id,
 SUBSTR(CAST(SUBSTR(ASMP.assort_region_cat_id, 1, 13) || '00005000000000' AS STRING), 1, 27) AS liam_parnt_clnt_cat_id,
 SUBSTR(CAST(ASMP.assort_region_cat_id AS STRING), 1, 27) AS liam_clnt_cat_id,
 - 1 AS pos_nr,
 CAST(NULL AS STRING) AS manufacturer,
 CAST(NULL AS STRING) AS brand_2,
 CAST(NULL AS STRING) AS product_name,
 CAST(NULL AS STRING) AS pack_size,
 CAST(NULL AS STRING) AS ean_2,
 CAST(NULL AS STRING) AS category_family,
 CAST(NULL AS STRING) AS feature1,
 CAST(NULL AS STRING) AS feature2,
 CAST(NULL AS STRING) AS feature3,
 CAST(NULL AS STRING) AS feature4,
 CAST(NULL AS STRING) AS feature5,
 CAST(NULL AS STRING) AS feature6,
 CAST(NULL AS STRING) AS feature7,
 CAST(NULL AS STRING) AS feature8,
 CAST(NULL AS STRING) AS feature9,
 CAST(NULL AS STRING) AS feature10,
 CAST(NULL AS STRING) AS feature11,
 CAST(NULL AS STRING) AS feature12,
 CAST(NULL AS STRING) AS feature13,
 CAST(NULL AS STRING) AS feature14,
 CAST(NULL AS NUMERIC) AS penetrate_cum_rel_pct,
 1 AS prot_fg
FROM ldl_p_lew_core_ac.v_market_article_feature_2 AS FEAT
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_2 AS REG ON FEAT.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_2 AS PER ON FEAT.client_id = PER.client_id AND FEAT.period_sid = PER.period_sid
   
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat_2 AS ASMP ON FEAT.client_id = ASMP.client_id AND FEAT.region_sid
     = ASMP.region_sid AND FEAT.assort_cat_sid = ASMP.assort_cat_sid;
