
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_LIAM4_DATA_ACT_FLAT_2
(
client_id
, per_id
, liam_parnt_cat_id
, liam_clnt_chld_cat_id
, currency_iso_cd
, pos_nr
, page_nr
, product_name
, manufacturer
, brand_2
, pack_size
, ean_2
, category_family
, uwg_fam
, feature1
, feature2
, feature3
, feature4
, feature5
, feature6
, feature7
, feature8
, feature9
, feature10
, feature11
, feature12
, feature13
, feature14
, penetrate_cum_rel_pct
, penetrate_diff_cum_rel_pct
, penetrate_single_rel_pct
, penetrate_cum_abs_pct
, penetrate_exclusive_rel_pct
, exclusive_buyer_assortment_pct
, assortment_depth_per_buyer_cnt
, turnover_cum_all_pct
, turnover_cum_product_pct
, val_k
, turnover_prom_val
, prom_share_pct
, vol_packs_k
, buyer_cnt_k
, trip_cnt_k
, avg_price_per_pack_val
, tm_val_k
, tm_prom_share_pct
, tm_vol_packs_k
, r1_val_k
, r1_prom_share_pct
, r1_vol_packs_k
, r2_val_k
, r2_prom_share_pct
, r2_vol_packs_k
, r3_val_k
, r3_prom_share_pct
, r3_vol_packs_k
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
        reg.region_id AS client_id
      , perms.period_id AS per_id
      , CAST(SUBSTRING(ass.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)) AS liam_parnt_cat_id
      , ass.assort_region_cat_id AS liam_clnt_chld_cat_id
      , CAST(cer.to_currency_iso_cd AS CHAR(3)) AS currency_iso_cd
      , pos.rank_pos AS pos_nr
      , CAST(CEIL((pos_nr)/200)AS INTEGER) AS page_nr
      , pos.product_name
      , pos.manufacturer
      , pos.brand_2
      , pos.pack_size
      , pos.ean_2
      , pos.category_family
      , CAST('not provided yet' AS VARCHAR(128)) AS uwg_fam
      , pos.feature1_content AS feature1
      , pos.feature2_content AS feature2
      , pos.feature3_content AS feature3
      , pos.feature4_content AS feature4
      , pos.feature5_content AS feature5
      , pos.feature6_content AS feature6
      , pos.feature7_content AS feature7
      , pos.feature8_content AS feature8
      , pos.feature9_content AS feature9
      , pos.feature10_content AS feature10
      , pos.feature11_content AS feature11
      , pos.feature12_content AS feature12
      , pos.feature13_content AS feature13
      , pos.feature14_content AS feature14
 -- Anpassungen für Snowflake
    ,(pos.penetrate_cum_rel_pct)::DECIMAL(23,5),
      (pos.penetrate_diff_cum_rel_pct)::DECIMAL(23,5),
      (pos.penetrate_single_rel_pct)::DECIMAL(23,5),
      (pos.penetrate_cum_abs_pct)::DECIMAL(23,5),
      (pos.penetrate_exclusive_rel_pct)::DECIMAL(23,5),
      (pos.exclusive_buyer_assortment_pct)::DECIMAL(23,5),
      (pos.assortment_depth_per_buyer_cnt)::DECIMAL(23,5),
      (pos.turnover_cum_all_pct)::DECIMAL(23,5),
      (pos.turnover_cum_product_pct)::DECIMAL(23,5),
      (pos.turnover_val/1000*cer.rate_currency_exchange)::DECIMAL(23,5) AS val_k,
      (pos.turnover_prom_val/1000*cer.rate_currency_exchange)::DECIMAL(23,5) AS turnover_prom_val,
      (COALESCE(CASE WHEN pos.promotion_share_pct = 0 THEN NULL ELSE pos.promotion_share_pct END, CASE WHEN pos.turnover_prom_val*100/ CASE WHEN pos.turnover_val = 0 THEN NULL ELSE pos.turnover_val END = 0 THEN NULL ELSE pos.turnover_prom_val*100/ CASE WHEN pos.turnover_val = 0 THEN NULL ELSE pos.turnover_val END END))::DECIMAL(23,5) AS prom_share_pct,
      (pos.extrapol_package_cnt/1000)::DECIMAL(23,5) AS vol_packs_k,
      (pos.buyer_cnt/1000)::DECIMAL(23,5) AS buyer_cnt_k,
      (pos.trip_cnt/1000)::DECIMAL(23,5) AS trip_cnt_k,
      (pos.avg_price_per_pack_val*cer.rate_currency_exchange)::DECIMAL(23,5) AS avg_price_per_pack_val,
      (pos.total_market_turnover_val/1000*cer.rate_currency_exchange)::DECIMAL(23,5) AS tm_val_k,
      (pos.total_market_promotion_share_pct)::DECIMAL(23,5) AS tm_prom_share_pct,
      (pos.total_market_extrapol_package_cnt/1000)::DECIMAL(23,5) AS tm_vol_packs_k,
      (pos.lidl_turnover_val/1000*cer.rate_currency_exchange)::DECIMAL(23,5) AS r1_val_k,
      (pos.lidl_promotion_share_pct)::DECIMAL(23,5) AS r1_prom_share_pct,
      (pos.lidl_extrapol_package_cnt/1000)::DECIMAL(23,5) AS r1_vol_packs_k,
      (pos.competitor1_turnover_val/1000*cer.rate_currency_exchange)::DECIMAL(23,5) AS r2_val_k,
      (pos.competitor1_promotion_share_pct)::DECIMAL(23,5) AS r2_prom_share_pct,
      (pos.competitor1_extrapol_package_cnt/1000)::DECIMAL(23,5) AS r2_vol_packs_k,
      (pos.competitor2_turnover_val/1000*cer.rate_currency_exchange)::DECIMAL(23,5) AS r3_val_k,
      (pos.competitor2_promotion_share_pct)::DECIMAL(23,5) AS r3_prom_share_pct,
      (pos.competitor2_extrapol_package_cnt/1000)::DECIMAL(23,5) AS r3_vol_packs_k
FROM P_LEW_CORE_AC.v_market_article_feature_pos_2 AS pos
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_assort_region_cat_2 AS ass
    ON ass.client_id = pos.client_id
    AND ass.region_sid = pos.region_sid
    AND ass.assort_cat_sid = pos.assort_cat_sid
INNER JOIN P_LEW_CORE_AC.v_lil_assort_category_2 AS assc
  ON assc.client_id = ass.client_id
 AND assc.assort_cat_sid = ass.assort_cat_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_2 AS reg
    ON reg.region_sid = pos.region_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period_2 AS perms
    ON perms.client_id = pos.client_id
    AND perms.period_sid = pos.period_sid
INNER JOIN P_LEW_MART_CM.v_lil_currency_exch_rt_2 AS cer
    ON cer.from_currency_iso_cd = pos.curr_cd
WHERE COALESCE(pos.deleted_fg, 0) = 0
    AND NOT EXISTS(
        SELECT NULL
        FROM P_LEW_PROCESS_MSTR_AC.v_lil_data_mask_2 AS dm
        WHERE dm.client_id = pos.client_id
        AND dm.region_sid = pos.region_sid
        AND dm.period_sid = pos.period_sid
        AND dm.src_assort_parent_cat_cd = LTRIM(assc.src_assort_parent_cat_cd)
        AND dm.interface_name = 'LIAM_FMCG_AssOpt'
        AND dm.mask_data_fg = 1);
