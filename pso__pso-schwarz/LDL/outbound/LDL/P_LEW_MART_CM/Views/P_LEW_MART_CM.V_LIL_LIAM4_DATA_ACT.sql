CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_liam4_data_act (client_id, per_id, liam_parnt_clnt_cat_id,
liam_clnt_cat_id, pos_nr, currency_iso_cd, meas_id, val, txt1, prot_fg) AS SELECT CAST(REG.region_id AS BIGNUMERIC) AS
 client_id,
 PERMS.period_id AS per_id,
 SUBSTR(CAST(SUBSTR(ASS.assort_region_cat_id, 1, 13) || '00005000000000' AS STRING), 1, 27) AS liam_parnt_clnt_cat_id,
 SUBSTR(CAST(ASS.assort_region_cat_id AS STRING), 1, 27) AS liam_clnt_cat_id,
 CAST(DT.rank_pos AS BIGNUMERIC) AS pos_nr,
 SUBSTR(CAST(CER.to_currency_iso_cd AS STRING), 1, 3) AS currency_iso_cd,
 meas.meas_id,
 CAST(CASE
    WHEN meas.meas_cd = 'penetrate_cum_rel_pct'
    THEN CAST(DT.penetrate_cum_rel_pct AS NUMERIC)
    WHEN meas.meas_cd = 'penetrate_diff_cum_rel_pct'
    THEN DT.penetrate_diff_cum_rel_pct
    WHEN meas.meas_cd = 'penetrate_single_rel_pct'
    THEN DT.penetrate_single_rel_pct
    WHEN meas.meas_cd = 'penetrate_cum_abs_pct'
    THEN DT.penetrate_cum_abs_pct
    WHEN meas.meas_cd = 'penetrate_exclusive_rel_pct'
    THEN DT.penetrate_exclusive_rel_pct
    WHEN meas.meas_cd = 'exclusive_buyer_assortment_pct'
    THEN DT.exclusive_buyer_assortment_pct
    WHEN meas.meas_cd = 'assortment_depth_per_buyer_cnt'
    THEN DT.assortment_depth_per_buyer_cnt
    WHEN meas.meas_cd = 'turnover_cum_all_pct'
    THEN DT.turnover_cum_all_pct
    WHEN meas.meas_cd = 'turnover_cum_product_pct'
    THEN DT.turnover_cum_product_pct
    WHEN meas.meas_cd = 'turnover_val'
    THEN DT.turnover_val / 1000
    WHEN meas.meas_cd = 'turnover_prom_val'
    THEN DT.turnover_prom_val / 1000
    WHEN meas.meas_cd = 'extrapol_package_cnt'
    THEN DT.extrapol_package_cnt / 1000
    WHEN meas.meas_cd = 'buyer_cnt'
    THEN DT.buyer_cnt / 1000
    WHEN meas.meas_cd = 'trip_cnt'
    THEN DT.trip_cnt / 1000
    WHEN meas.meas_cd = 'avg_price_per_pack_val'
    THEN DT.avg_price_per_pack_val
    WHEN meas.meas_cd = 'packs_per_trip_cnt'
    THEN DT.packs_per_trip_cnt
    ELSE NULL
    END * CASE
    WHEN meas.monetary_fg = 1
    THEN CER.rate_currency_exchange
    ELSE 1
    END AS NUMERIC) AS val,
 LTRIM(COALESCE(CAST(ROUND(CAST(CAST(CASE
         WHEN meas.meas_cd = 'penetrate_cum_rel_pct'
         THEN CAST(DT.penetrate_cum_rel_pct AS NUMERIC)
         WHEN meas.meas_cd = 'penetrate_diff_cum_rel_pct'
         THEN DT.penetrate_diff_cum_rel_pct
         WHEN meas.meas_cd = 'penetrate_single_rel_pct'
         THEN DT.penetrate_single_rel_pct
         WHEN meas.meas_cd = 'penetrate_cum_abs_pct'
         THEN DT.penetrate_cum_abs_pct
         WHEN meas.meas_cd = 'penetrate_exclusive_rel_pct'
         THEN DT.penetrate_exclusive_rel_pct
         WHEN meas.meas_cd = 'exclusive_buyer_assortment_pct'
         THEN DT.exclusive_buyer_assortment_pct
         WHEN meas.meas_cd = 'assortment_depth_per_buyer_cnt'
         THEN DT.assortment_depth_per_buyer_cnt
         WHEN meas.meas_cd = 'turnover_cum_all_pct'
         THEN DT.turnover_cum_all_pct
         WHEN meas.meas_cd = 'turnover_cum_product_pct'
         THEN DT.turnover_cum_product_pct
         WHEN meas.meas_cd = 'turnover_val'
         THEN DT.turnover_val / 1000
         WHEN meas.meas_cd = 'turnover_prom_val'
         THEN DT.turnover_prom_val / 1000
         WHEN meas.meas_cd = 'extrapol_package_cnt'
         THEN DT.extrapol_package_cnt / 1000
         WHEN meas.meas_cd = 'buyer_cnt'
         THEN DT.buyer_cnt / 1000
         WHEN meas.meas_cd = 'trip_cnt'
         THEN DT.trip_cnt / 1000
         WHEN meas.meas_cd = 'avg_price_per_pack_val'
         THEN DT.avg_price_per_pack_val
         WHEN meas.meas_cd = 'packs_per_trip_cnt'
         THEN DT.packs_per_trip_cnt
         ELSE NULL
         END * CASE
         WHEN meas.monetary_fg = 1
         THEN CER.rate_currency_exchange
         ELSE 1
         END AS NUMERIC) AS NUMERIC), 5) AS STRING), CASE
    WHEN meas.meas_cd = 'manufacturer'
    THEN DT.manufacturer
    WHEN meas.meas_cd = 'brand'
    THEN DT.brand
    WHEN meas.meas_cd = 'product_name'
    THEN DT.product_name
    WHEN meas.meas_cd = 'pack_size'
    THEN DT.pack_size
    WHEN meas.meas_cd = 'ean'
    THEN DT.ean
    WHEN meas.meas_cd = 'category_family'
    THEN DT.category_family
    WHEN meas.meas_cd = 'feature1'
    THEN DT.feature1_content
    WHEN meas.meas_cd = 'feature2'
    THEN DT.feature2_content
    WHEN meas.meas_cd = 'feature3'
    THEN DT.feature3_content
    WHEN meas.meas_cd = 'feature4'
    THEN DT.feature4_content
    WHEN meas.meas_cd = 'feature5'
    THEN DT.feature5_content
    WHEN meas.meas_cd = 'feature6'
    THEN DT.feature6_content
    WHEN meas.meas_cd = 'feature7'
    THEN DT.feature7_content
    WHEN meas.meas_cd = 'feature8'
    THEN DT.feature8_content
    WHEN meas.meas_cd = 'feature9'
    THEN DT.feature9_content
    WHEN meas.meas_cd = 'feature10'
    THEN DT.feature10_content
    WHEN meas.meas_cd = 'feature11'
    THEN DT.feature11_content
    WHEN meas.meas_cd = 'feature12'
    THEN DT.feature12_content
    WHEN meas.meas_cd = 'feature13'
    THEN DT.feature13_content
    WHEN meas.meas_cd = 'feature14'
    THEN DT.feature14_content
    ELSE NULL
    END)) AS txt1,
 1 AS prot_fg
FROM ldl_p_lew_core_ac.v_market_article_feature_pos AS DT
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region AS REG ON DT.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_core_ac.v_lil_period AS PER ON DT.client_id = PER.client_id AND DT.period_sid = PER.period_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period AS PERMS ON DT.client_id = PERMS.client_id AND DT.period_sid = PERMS
   .period_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat AS ASS ON DT.client_id = ASS.client_id AND DT.region_sid =
    ASS.region_sid AND DT.assort_cat_sid = ASS.assort_cat_sid
 INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt AS CER ON DT.curr_cd = CER.from_currency_iso_cd
 INNER JOIN (SELECT meas_id,
   meas_cd,
   monetary_fg
  FROM ldl_p_lew_process_mstr_ac.v_lil_measure
  WHERE meas_cd IN ('penetrate_cum_rel_pct', 'penetrate_diff_cum_rel_pct', 'penetrate_single_rel_pct',
     'penetrate_cum_abs_pct', 'penetrate_exclusive_rel_pct', 'exclusive_buyer_assortment_pct',
     'assortment_depth_per_buyer_cnt', 'turnover_cum_all_pct', 'turnover_cum_product_pct', 'turnover_val',
     'turnover_prom_val', 'extrapol_package_cnt', 'buyer_cnt', 'trip_cnt', 'avg_price_per_pack_val',
     'packs_per_trip_cnt', 'manufacturer', 'brand', 'product_name', 'pack_size', 'ean', 'category_family', 'feature1',
     'feature2', 'feature3', 'feature4', 'feature5', 'feature6', 'feature7', 'feature8', 'feature9', 'feature10',
     'feature11', 'feature12', 'feature13', 'feature14')) AS meas ON meas.meas_id NOT IN (44)
WHERE COALESCE(DT.deleted_fg, 0) = 0
 AND NOT EXISTS (SELECT NULL
  FROM ldl_p_lew_process_mstr_ac.v_lil_data_mask AS DM
  WHERE client_id = DT.client_id
   AND region_sid = DT.region_sid
   AND period_sid = DT.period_sid
   AND src_assort_parent_cat_cd = LTRIM(ASS.assort_parnt_cat_name_de)
   AND interface_name = 'LIAM_FMCG_AssOpt'
   AND mask_data_fg = 1)
UNION ALL
SELECT CAST(REG.region_id AS BIGNUMERIC) AS client_id,
 PERMS.period_id AS per_id,
 SUBSTR(CAST(SUBSTR(ASS.assort_region_cat_id, 1, 13) || '00005000000000' AS STRING), 1, 27) AS liam_parnt_clnt_cat_id,
 SUBSTR(CAST(ASS.assort_region_cat_id AS STRING), 1, 27) AS liam_clnt_cat_id,
 CAST(CASE
   WHEN meas.meas_id IN (19, 12, 44, 28)
   THEN - 1
   ELSE 0
   END AS BIGNUMERIC) AS pos_nr,
 SUBSTR(CAST(CER.to_currency_iso_cd AS STRING), 1, 3) AS currency_iso_cd,
 meas.meas_id,
 CAST(CASE
    WHEN meas.meas_cd = 'household_in_country_cnt'
    THEN CAST(DT.household_in_country_cnt AS NUMERIC) / 1000
    WHEN meas.meas_cd = 'buyer_ass_cnt'
    THEN DT.buyer_cnt / 1000
    WHEN meas.meas_cd = 'turnover_val'
    THEN DT.turnover_val / 1000
    WHEN meas.meas_cd = 'penetrate_abs_pct'
    THEN DT.penetrate_abs_pct
    ELSE NULL
    END * CASE
    WHEN meas.monetary_fg = 1
    THEN CER.rate_currency_exchange
    ELSE 1
    END AS NUMERIC) AS val,
 LTRIM(COALESCE(CAST(ROUND(CAST(CAST(CASE
         WHEN meas.meas_cd = 'household_in_country_cnt'
         THEN CAST(DT.household_in_country_cnt AS NUMERIC) / 1000
         WHEN meas.meas_cd = 'buyer_ass_cnt'
         THEN DT.buyer_cnt / 1000
         WHEN meas.meas_cd = 'turnover_val'
         THEN DT.turnover_val / 1000
         WHEN meas.meas_cd = 'penetrate_abs_pct'
         THEN DT.penetrate_abs_pct
         ELSE NULL
         END * CASE
         WHEN meas.monetary_fg = 1
         THEN CER.rate_currency_exchange
         ELSE 1
         END AS NUMERIC) AS NUMERIC), 5) AS STRING), CASE
    WHEN meas.meas_cd = 'feature1'
    THEN DT.feature1_name
    WHEN meas.meas_cd = 'feature2'
    THEN DT.feature2_name
    WHEN meas.meas_cd = 'feature3'
    THEN DT.feature3_name
    WHEN meas.meas_cd = 'feature4'
    THEN DT.feature4_name
    WHEN meas.meas_cd = 'feature5'
    THEN DT.feature5_name
    WHEN meas.meas_cd = 'feature6'
    THEN DT.feature6_name
    WHEN meas.meas_cd = 'feature7'
    THEN DT.feature7_name
    WHEN meas.meas_cd = 'feature8'
    THEN DT.feature8_name
    WHEN meas.meas_cd = 'feature9'
    THEN DT.feature9_name
    WHEN meas.meas_cd = 'feature10'
    THEN DT.feature10_name
    WHEN meas.meas_cd = 'feature11'
    THEN DT.feature11_name
    WHEN meas.meas_cd = 'feature12'
    THEN DT.feature12_name
    WHEN meas.meas_cd = 'feature13'
    THEN DT.feature13_name
    WHEN meas.meas_cd = 'feature14'
    THEN DT.feature14_name
    ELSE NULL
    END)) AS txt1,
 1 AS prot_fg
FROM ldl_p_lew_core_ac.v_market_article_feature AS DT
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region AS REG ON DT.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_core_ac.v_lil_period AS PER ON DT.client_id = PER.client_id AND DT.period_sid = PER.period_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period AS PERMS ON DT.client_id = PERMS.client_id AND DT.period_sid = PERMS
   .period_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat AS ASS ON DT.client_id = ASS.client_id AND DT.region_sid =
    ASS.region_sid AND DT.assort_cat_sid = ASS.assort_cat_sid
 INNER JOIN ldl_p_lew_mart_cm.v_lil_currency_exch_rt AS CER ON DT.curr_cd = CER.from_currency_iso_cd
 INNER JOIN (SELECT meas_id,
   meas_cd,
   monetary_fg
  FROM ldl_p_lew_process_mstr_ac.v_lil_measure
  WHERE meas_cd IN ('household_in_country_cnt', 'buyer_ass_cnt', 'turnover_val', 'penetrate_abs_pct', 'feature1',
     'feature2', 'feature3', 'feature4', 'feature5', 'feature6', 'feature7', 'feature8', 'feature9', 'feature10',
     'feature11', 'feature12', 'feature13', 'feature14')) AS meas ON meas.meas_id NOT IN (1)
WHERE COALESCE(DT.deleted_fg, 0) = 0
 AND NOT EXISTS (SELECT NULL
  FROM ldl_p_lew_process_mstr_ac.v_lil_data_mask AS DM
  WHERE client_id = DT.client_id
   AND region_sid = DT.region_sid
   AND period_sid = DT.period_sid
   AND src_assort_parent_cat_cd = LTRIM(ASS.assort_parnt_cat_name_de)
   AND interface_name = 'LIAM_FMCG_AssOpt'
   AND mask_data_fg = 1);