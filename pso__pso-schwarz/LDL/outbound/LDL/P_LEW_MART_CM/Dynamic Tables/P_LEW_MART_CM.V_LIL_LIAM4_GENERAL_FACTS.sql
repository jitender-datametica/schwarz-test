
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_liam4_general_facts
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT REG.region_id AS client_id,
 SUBSTR(CAST(ASS.assort_region_cat_id AS STRING), 1, 27) AS liam_clnt_cat_id,
 PERMS.period_id AS per_id,
 SUBSTR(CAST(SUBSTR(ASS.assort_region_cat_id, 1, 13) || '00005000000000' AS STRING), 1, 27) AS liam_parnt_clnt_cat_id,
 SUBSTR(CAST(CER.to_currency_iso_cd AS STRING), 1, 3) AS currency_iso_cd,
  CASE
  WHEN LENGTH(SUBSTR(DT.feature14_name, 13)) = 0
  THEN '-Volume not provided-'
  ELSE COALESCE(SUBSTR(DT.feature14_name, 13), '-Volume not provided-')
  END AS volume_type,
 ROUND(CAST(DT.buyer_cnt / 1000 AS NUMERIC), 5) AS buyer_cnt,
 ROUND(CAST(ROUND(CAST(DT.turnover_val / 1000 AS NUMERIC), 5) * CER.rate_currency_exchange AS NUMERIC), 5) AS
 turnover_val,
 CAST(DT.penetrate_abs_pct AS NUMERIC) AS penetrate_abs_pct,
 ROUND(CAST(DT.household_in_country_cnt / 1000 AS NUMERIC), 5) AS household_in_country_cnt,
 DT.feature1_name,
 DT.feature2_name,
 DT.feature3_name,
 DT.feature4_name,
 DT.feature5_name,
 DT.feature6_name,
 DT.feature7_name,
 DT.feature8_name,
 DT.feature9_name,
 DT.feature10_name,
 DT.feature11_name,
 DT.feature12_name,
 DT.feature13_name,
 CAST(TRIM(SUBSTR(DT.feature14_name, 1, 11)) AS STRING) AS feature14_name,
 'Total Market' AS total_market_desc,
 10 AS total_market_id,
 'Lidl' AS retailer1_desc,
 1000 AS retailer1_id,
 CAST(COMP1.region_rtl_desc_de AS STRING) AS retailer2_desc,
 COMP1.rtl_id AS retailer2_id,
 CAST(COMP2.region_rtl_desc_de AS STRING) AS retailer3_desc,
 COMP2.rtl_id AS retailer3_id
FROM ldl_p_lew_core_ac.v_market_article_feature AS DT
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region AS REG ON DT.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period AS PERMS ON DT.client_id = PERMS.client_id AND DT.period_sid = PERMS
   .period_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat AS ASS ON DT.client_id = ASS.client_id AND DT.region_sid =
    ASS.region_sid AND DT.assort_cat_sid = ASS.assort_cat_sid
 INNER JOIN ldl_p_lew_core_ac.v_lil_assort_category AS ASSC ON ASS.client_id = ASSC.client_id AND ASS.assort_cat_sid =
   ASSC.assort_cat_sid
 INNER JOIN ldl_p_lew_core_ac.v_market_article_feature_pos AS POS ON DT.region_sid = POS.region_sid AND DT.assort_cat_sid
      = POS.assort_cat_sid AND DT.period_sid = POS.period_sid AND POS.rank_pos = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_region_retailer AS COMP1 ON POS.client_id = COMP1.client_id AND POS.retailer_sid_comp1
    = COMP1.retailer_sid
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_region_retailer AS COMP2 ON POS.client_id = COMP2.client_id AND POS.retailer_sid_comp2
    = COMP2.retailer_sid
 INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt AS CER ON DT.curr_cd = CER.from_currency_iso_cd
WHERE COALESCE(POS.deleted_fg, 0) = 0
 AND NOT EXISTS (SELECT NULL
  FROM ldl_p_lew_process_mstr_ac.v_lil_data_mask AS DM
  WHERE client_id = DT.client_id
   AND region_sid = DT.region_sid
   AND period_sid = DT.period_sid
   AND src_assort_parent_cat_cd = LTRIM(ASSC.src_assort_parent_cat_cd)
   AND interface_name = 'LIAM_FMCG_AssOpt'
   AND mask_data_fg = 1);

