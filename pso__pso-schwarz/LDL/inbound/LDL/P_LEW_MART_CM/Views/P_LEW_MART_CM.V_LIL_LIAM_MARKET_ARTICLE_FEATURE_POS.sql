CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_LIAM_MARKET_ARTICLE_FEATURE_POS(
	CLIENT_ID
	,REGION_SID
	,PERIOD_ID
	,LIAM_PARNT_CLNT_CAT_ID
	,LIAM_CLNT_CAT_ID
	,ASSORT_CAT_SUBFAMILY_SID
	,CURRENCY_ISO_CD
	,RANK_POS
	,BRAND_TYPE_TXT
	,PRODUCT_NAME
	,MANUFACTURER
	,BRAND
	,PACK_SIZE
	,EAN
	,CATEGORY_FAMILY
	,CATEGORY_SUBFAMILY_NAME
	,FEATURE1
	,FEATURE2
	,FEATURE3
	,FEATURE4
	,FEATURE5
	,FEATURE6
	,FEATURE7
	,FEATURE8
	,FEATURE9
	,FEATURE10
	,FEATURE11
	,FEATURE12
	,FEATURE13
	,FEATURE14
	,TURNOVER_VAL
	,TURNOVER_PROM_VAL
	,PROMOTION_SHARE_PCT
	,TRIP_CNT
	,BUYER_CNT
	,EXTRAPOL_PACKAGE_CNT
	,WEIGHT_TYPE_TXT
	,AVG_PRICE_PER_PACK_VAL
	,PACKS_PER_TRIP_CNT
	,PENETRATE_CUM_ABS_PCT
	,PENETRATE_CUM_REL_PCT
	,PENETRATE_DIFF_CUM_REL_PCT
	,PENETRATE_SINGLE_REL_PCT
	,PENETRATE_EXCLUSIVE_REL_PCT
	,EXCLUSIVE_BUYER_ASSORTMENT_PCT
	,ASSORTMENT_DEPTH_PER_BUYER_CNT
	,TURNOVER_CUM_ALL_PCT
	,TURNOVER_CUM_PRODUCT_PCT
	,TOTAL_MARKET_TURNOVER_VAL
	,TOTAL_MARKET_PROMOTION_SHARE_PCT
	,TOTAL_MARKET_EXTRAPOL_PACKAGE_CNT
	,LIDL_TURNOVER_VAL
	,LIDL_PROMOTION_SHARE_PCT
	,LIDL_EXTRAPOL_PACKAGE_CNT
	,COMPETITOR1_TURNOVER_VAL
	,COMPETITOR1_PROMOTION_SHARE_PCT
	,COMPETITOR1_EXTRAPOL_PACKAGE_CNT
	,COMPETITOR2_TURNOVER_VAL
	,COMPETITOR2_PROMOTION_SHARE_PCT
	,COMPETITOR2_EXTRAPOL_PACKAGE_CNT
	,RETAILER_COMP1_ID
	,RETAILER_COMP2_ID
) AS
  SELECT
   DECODE(mafp.client_id, 33, 331, mafp.client_id) AS client_id
   ,mafp.region_sid
   ,period_id
   ,CAST(SUBSTR(arc.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)) AS liam_parnt_clnt_cat_id
   ,CAST(arc.assort_region_cat_id AS CHAR(27)) AS liam_clnt_cat_id
   ,assort_cat_subfamily_sid
   ,CAST(cer.to_currency_iso_cd AS CHAR(3)) AS currency_iso_cd
   ,rank_pos
   ,brand_type_txt
   ,product_name
   ,manufacturer
   ,brand
   ,pack_size
   ,ean
   ,category_family
   ,category_subfamily_name
   ,feature1_content
   ,feature2_content
   ,feature3_content
   ,feature4_content
   ,feature5_content
   ,feature6_content
   ,feature7_content
   ,feature8_content
   ,feature9_content
   ,feature10_content
   ,feature11_content
   ,feature12_content
   ,feature13_content
   ,feature14_content
   ,(turnover_val/1000*cer.rate_currency_exchange) AS turnover_val
   ,(turnover_prom_val/1000*cer.rate_currency_exchange) AS turnover_prom_val
   ,promotion_share_pct
   ,trip_cnt 
   ,buyer_cnt
   ,extrapol_package_cnt
   ,weight_type_txt
   ,(avg_price_per_pack_val*cer.rate_currency_exchange) AS avg_price_per_pack_val
   ,packs_per_trip_cnt
   ,penetrate_cum_abs_pct
   ,penetrate_cum_rel_pct
   ,penetrate_diff_cum_rel_pct
   ,penetrate_single_rel_pct
   ,penetrate_exclusive_rel_pct
   ,exclusive_buyer_assortment_pct
   ,assortment_depth_per_buyer_cnt
   ,turnover_cum_all_pct
   ,turnover_cum_product_pct
   ,(total_market_turnover_val/1000*cer.rate_currency_exchange) AS total_market_turnover_val
   ,total_market_promotion_share_pct
   ,total_market_extrapol_package_cnt
   ,(lidl_turnover_val/1000*cer.rate_currency_exchange) AS lidl_turnover_val
   ,lidl_promotion_share_pct
   ,lidl_extrapol_package_cnt
   ,(competitor1_turnover_val/1000*cer.rate_currency_exchange) AS competitor1_turnover_val
   ,competitor1_promotion_share_pct
   ,competitor1_extrapol_package_cnt
   ,(competitor2_turnover_val/1000*cer.rate_currency_exchange) AS competitor2_turnover_val
   ,competitor2_promotion_share_pct
   ,competitor2_extrapol_package_cnt
   ,rr1.rtl_id
   ,rr2.rtl_id
FROM p_lew_core_ac.v_market_article_feature_pos AS mafp
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_period AS pp
	ON mafp.period_sid=pp.period_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_assort_region_cat AS arc
	ON arc.client_id = mafp.client_id
	AND arc.region_sid = mafp.region_sid
	AND arc.assort_cat_sid = mafp.assort_cat_sid
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_retailer rr1
    ON rr1.client_id=mafp.client_id
    AND rr1.region_sid=mafp.region_sid
    AND rr1.retailer_sid=mafp.retailer_sid_comp1
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_retailer rr2
    ON rr2.client_id=mafp.client_id
    AND rr2.region_sid=mafp.region_sid
    AND rr2.retailer_sid=mafp.retailer_sid_comp2
INNER JOIN P_LEW_MART_CM.v_lil_currency_exch_rt AS cer
    ON cer.from_currency_iso_cd = mafp.curr_cd;