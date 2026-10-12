
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_liam4_data_act_flat
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
-- Anpassungen für Snowflake
 SELECT REG.region_id AS client_id,
 PERMS.period_id AS per_id,
 SUBSTR(CAST(SUBSTR(ASS.assort_region_cat_id, 1, 13) || '00005000000000' AS STRING), 1, 27) AS liam_parnt_cat_id,
 ASS.assort_region_cat_id AS liam_clnt_chld_cat_id,
 SUBSTR(CAST(CER.to_currency_iso_cd AS STRING), 1, 3) AS currency_iso_cd,
 POS.rank_pos AS pos_nr,
 CAST(CEIL(POS.rank_pos / 200) AS BIGNUMERIC) AS page_nr,
 POS.product_name,
 POS.manufacturer,
 POS.brand,
 POS.pack_size,
 POS.ean,
 POS.category_family,
 'not provided yet' AS uwg_fam,
 POS.feature1_content AS feature1,
 POS.feature2_content AS feature2,
 POS.feature3_content AS feature3,
 POS.feature4_content AS feature4,
 POS.feature5_content AS feature5,
 POS.feature6_content AS feature6,
 POS.feature7_content AS feature7,
 POS.feature8_content AS feature8,
 POS.feature9_content AS feature9,
 POS.feature10_content AS feature10,
 POS.feature11_content AS feature11,
 POS.feature12_content AS feature12,
 POS.feature13_content AS feature13,
 POS.feature14_content AS feature14,
 CAST(POS.penetrate_cum_rel_pct AS NUMERIC) AS penetrate_cum_rel_pct ,
 CAST(POS.penetrate_diff_cum_rel_pct AS NUMERIC) AS penetrate_diff_cum_rel_pct,
 CAST(POS.penetrate_single_rel_pct AS NUMERIC) AS penetrate_single_rel_pct,
 CAST(POS.penetrate_cum_abs_pct AS NUMERIC) AS penetrate_cum_abs_pct,
 CAST(POS.penetrate_exclusive_rel_pct AS NUMERIC) AS penetrate_exclusive_rel_pct,
 CAST(POS.exclusive_buyer_assortment_pct AS NUMERIC) AS exclusive_buyer_assortment_pct,
 CAST(POS.assortment_depth_per_buyer_cnt AS NUMERIC) AS assortment_depth_per_buyer_cnt ,
 CAST(POS.turnover_cum_all_pct AS NUMERIC) AS turnover_cum_all_pct,
 CAST(POS.turnover_cum_product_pct AS NUMERIC) AS turnover_cum_product_pct,
 ROUND(CAST(POS.turnover_val / 1000 * CER.rate_currency_exchange AS NUMERIC), 5) AS val_k,
 ROUND(CAST(POS.turnover_prom_val / 1000 * CER.rate_currency_exchange AS NUMERIC), 5) AS turnover_prom_val,
 CAST(COALESCE(CASE
    WHEN POS.promotion_share_pct = 0
    THEN NULL
    ELSE POS.promotion_share_pct
    END, CASE
    WHEN POS.turnover_prom_val * 100 / CASE
       WHEN POS.turnover_val = 0
       THEN NULL
       ELSE POS.turnover_val
       END = 0
    THEN NULL
    ELSE POS.turnover_prom_val * 100 / CASE
      WHEN POS.turnover_val = 0
      THEN NULL
      ELSE POS.turnover_val
      END
    END) AS NUMERIC) AS prom_share_pct,
 ROUND(CAST(POS.extrapol_package_cnt / 1000 AS NUMERIC), 5) AS vol_packs_k,
 ROUND(CAST(POS.buyer_cnt / 1000 AS NUMERIC), 5) AS buyer_cnt_k,
 ROUND(CAST(POS.trip_cnt / 1000 AS NUMERIC), 5) AS trip_cnt_k,
 ROUND(CAST(POS.avg_price_per_pack_val * CER.rate_currency_exchange AS NUMERIC), 5) AS avg_price_per_pack_val,
 ROUND(CAST(POS.total_market_turnover_val / 1000 * CER.rate_currency_exchange AS NUMERIC), 5) AS tm_val_k,
 CAST(POS.total_market_promotion_share_pct AS NUMERIC) AS tm_prom_share_pct,
 ROUND(CAST(POS.total_market_extrapol_package_cnt / 1000 AS NUMERIC), 5) AS tm_vol_packs_k,
 ROUND(CAST(POS.lidl_turnover_val / 1000 * CER.rate_currency_exchange AS NUMERIC), 5) AS r1_val_k,
 CAST(POS.lidl_promotion_share_pct AS NUMERIC) AS r1_prom_share_pct,
 ROUND(CAST(POS.lidl_extrapol_package_cnt / 1000 AS NUMERIC), 5) AS r1_vol_packs_k,
 ROUND(CAST(POS.competitor1_turnover_val / 1000 * CER.rate_currency_exchange AS NUMERIC), 5) AS r2_val_k,
 CAST(POS.competitor1_promotion_share_pct AS NUMERIC) AS r2_prom_share_pct,
 ROUND(CAST(POS.competitor1_extrapol_package_cnt / 1000 AS NUMERIC), 5) AS r2_vol_packs_k,
 ROUND(CAST(POS.competitor2_turnover_val / 1000 * CER.rate_currency_exchange AS NUMERIC), 5) AS r3_val_k,
 CAST(POS.competitor2_promotion_share_pct AS NUMERIC) AS r3_prom_share_pct,
 ROUND(CAST(POS.competitor2_extrapol_package_cnt / 1000 AS NUMERIC), 5) AS r3_vol_packs_k
FROM ldl_p_lew_core_ac.v_market_article_feature_pos AS POS
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat AS ASS ON POS.client_id = ASS.client_id AND POS.region_sid
     = ASS.region_sid AND POS.assort_cat_sid = ASS.assort_cat_sid
 INNER JOIN ldl_p_lew_core_ac.v_lil_assort_category AS ASSC ON ASS.client_id = ASSC.client_id AND ASS.assort_cat_sid =
   ASSC.assort_cat_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region AS REG ON POS.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period AS PERMS ON POS.client_id = PERMS.client_id AND POS.period_sid =
   PERMS.period_sid
 INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt AS CER ON POS.curr_cd = CER.from_currency_iso_cd
WHERE COALESCE(POS.deleted_fg, 0) = 0
 AND NOT EXISTS (SELECT NULL
  FROM ldl_p_lew_process_mstr_ac.v_lil_data_mask AS DM
  WHERE client_id = POS.client_id
   AND region_sid = POS.region_sid
   AND period_sid = POS.period_sid
   AND src_assort_parent_cat_cd = LTRIM(ASSC.src_assort_parent_cat_cd)
   AND interface_name = 'LIAM_FMCG_AssOpt'
   AND mask_data_fg = 1);


