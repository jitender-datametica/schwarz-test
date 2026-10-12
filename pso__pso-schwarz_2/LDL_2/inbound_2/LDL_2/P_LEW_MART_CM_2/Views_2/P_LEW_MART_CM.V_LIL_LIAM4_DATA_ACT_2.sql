CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_LIAM4_DATA_ACT_2
(
  client_id
 , per_id
 , liam_parnt_clnt_cat_id
 , liam_clnt_cat_id
 , pos_nr
 , currency_iso_cd
 , meas_id
 , val
 , txt1
 , prot_fg
) AS
SELECT
   Cast(reg.region_id AS SMALLINT) AS client_id
  ,perms.period_id AS per_id
  ,Cast(Substr(ass.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)) AS liam_parnt_clnt_cat_id
  ,Cast(ass.assort_region_cat_id AS CHAR(27)) AS liam_clnt_cat_id
  ,Cast(dt.rank_pos AS SMALLINT) AS pos_nr
  ,Cast(cer.to_currency_iso_cd AS CHAR(3)) AS currency_iso_cd
  ,meas.meas_id
  ,Cast(CASE meas.meas_cd
       WHEN 'penetrate_cum_rel_pct'             THEN Cast(dt.penetrate_cum_rel_pct AS DECIMAL(38,9))
       WHEN 'penetrate_diff_cum_rel_pct'        THEN dt.penetrate_diff_cum_rel_pct
       WHEN 'penetrate_single_rel_pct'          THEN dt.penetrate_single_rel_pct
       WHEN 'penetrate_cum_abs_pct'             THEN dt.penetrate_cum_abs_pct
       WHEN 'penetrate_exclusive_rel_pct'       THEN dt.penetrate_exclusive_rel_pct
       WHEN 'exclusive_buyer_assortment_pct'    THEN dt.exclusive_buyer_assortment_pct
       WHEN 'assortment_depth_per_buyer_cnt'    THEN dt.assortment_depth_per_buyer_cnt
       WHEN 'turnover_cum_all_pct'              THEN dt.turnover_cum_all_pct
       WHEN 'turnover_cum_product_pct'          THEN dt.turnover_cum_product_pct
       WHEN 'turnover_val'                      THEN dt.turnover_val/1000
       WHEN 'turnover_prom_val'                 THEN dt.turnover_prom_val/1000
       WHEN 'extrapol_package_cnt'              THEN dt.extrapol_package_cnt/1000
       WHEN 'buyer_cnt'                         THEN dt.buyer_cnt/1000
       WHEN 'trip_cnt'                          THEN dt.trip_cnt/1000
       WHEN 'avg_price_per_pack_val'            THEN dt.avg_price_per_pack_val
       WHEN 'packs_per_trip_cnt'                THEN dt.packs_per_trip_cnt
     END *
     CASE
       WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange
                                 ELSE 1
    END AS DECIMAL(38,9)) AS val
 ,LTrim(Cast(Coalesce(Cast(val AS DECIMAL(18,5))::VARCHAR(50), CASE meas.meas_cd
       WHEN 'manufacturer'            THEN dt.manufacturer
       WHEN 'brand_2'                   THEN dt.brand_2
       WHEN 'product_name'            THEN dt.product_name
       WHEN 'pack_size'               THEN dt.pack_size
       WHEN 'ean_2'                     THEN dt.ean_2
       WHEN 'category_family'         THEN dt.category_family
       WHEN 'feature1'                THEN dt.feature1_content
       WHEN 'feature2'                THEN dt.feature2_content
       WHEN 'feature3'                THEN dt.feature3_content
       WHEN 'feature4'                THEN dt.feature4_content
       WHEN 'feature5'                THEN dt.feature5_content
       WHEN 'feature6'                THEN dt.feature6_content
       WHEN 'feature7'                THEN dt.feature7_content
       WHEN 'feature8'                THEN dt.feature8_content
       WHEN 'feature9'                THEN dt.feature9_content
       WHEN 'feature10'               THEN dt.feature10_content
       WHEN 'feature11'               THEN dt.feature11_content
       WHEN 'feature12'               THEN dt.feature12_content
       WHEN 'feature13'               THEN dt.feature13_content
       WHEN 'feature14'               THEN dt.feature14_content
     END) AS VARCHAR(10000))) AS txt1
  ,Cast(1 AS BYTEINT) AS prot_fg
FROM p_lew_core_ac.v_market_article_feature_pos_2 AS dt
INNER JOIN p_lew_process_mstr_ac.v_lil_region_2 AS reg
ON reg.region_sid = dt.region_sid
INNER JOIN p_lew_core_ac.v_lil_period_2 AS per
ON per.client_id = dt.client_id
AND per.period_sid = dt.period_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_period_2 AS perms
ON perms.client_id = dt.client_id
AND perms.period_sid = dt.period_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_assort_region_cat_2 AS ass
ON ass.client_id = dt.client_id
AND ass.region_sid = dt.region_sid
AND ass.assort_cat_sid = dt.assort_cat_sid
INNER JOIN p_lew_mart_cm.v_lil_currency_exch_rt_2 AS cer
ON cer.from_currency_iso_cd = dt.curr_cd
CROSS JOIN (
    SELECT
       meas_id
     , meas_cd
     , monetary_fg
    FROM p_lew_process_mstr_ac.v_lil_measure_2
    WHERE meas_cd IN (
         'penetrate_cum_rel_pct', 'penetrate_diff_cum_rel_pct', 'penetrate_single_rel_pct', 'penetrate_cum_abs_pct',
         'penetrate_exclusive_rel_pct', 'exclusive_buyer_assortment_pct', 'assortment_depth_per_buyer_cnt',
         'turnover_cum_all_pct', 'turnover_cum_product_pct', 'turnover_val', 'turnover_prom_val', 'extrapol_package_cnt',
         'buyer_cnt', 'trip_cnt', 'avg_price_per_pack_val', 'packs_per_trip_cnt', 'manufacturer', 'brand_2', 'product_name',
         'pack_size', 'ean_2', 'category_family', 'feature1', 'feature2', 'feature3', 'feature4',
         'feature5', 'feature6', 'feature7', 'feature8', 'feature9', 'feature10',
         'feature11', 'feature12', 'feature13', 'feature14'
      )
    ) AS meas

    WHERE NOT meas.meas_id  IN (44)
    AND Coalesce(dt.deleted_fg, 0) = 0
    AND NOT EXISTS(
        SELECT NULL
        FROM p_lew_process_mstr_ac.v_lil_data_mask_2 AS dm
        WHERE dm.client_id = dt.client_id
        AND dm.region_sid = dt.region_sid
        AND dm.period_sid = dt.period_sid
        AND dm.src_assort_parent_cat_cd = LTrim(ass.assort_parnt_cat_name_de)
        AND dm.interface_name = 'LIAM_FMCG_AssOpt'
        AND dm.mask_data_fg = 1)

    UNION ALL

    SELECT
   Cast(reg.region_id AS SMALLINT) AS client_id
  ,perms.period_id
  ,Cast(Substr(ass.assort_region_cat_id,1,13)||'00005000000000' AS CHAR(27)) AS liam_parnt_clnt_cat_id
  ,Cast(ass.assort_region_cat_id AS CHAR(27)) AS liam_clnt_cat_id
  ,Cast(CASE
     WHEN meas.meas_id IN (19,12,44,28) THEN -1 ELSE 0
   END AS SMALLINT) AS pos_nr
  ,Cast(cer.to_currency_iso_cd AS CHAR(3)) AS currency_iso_cd
  ,meas.meas_id
  ,Cast(CASE meas.meas_cd
       WHEN 'household_in_country_cnt'            THEN Cast(dt.household_in_country_cnt AS DECIMAL(38,9))/1000
       WHEN 'buyer_ass_cnt'         THEN dt.buyer_cnt/1000
       WHEN 'turnover_val'         THEN dt.turnover_val/1000
       WHEN 'penetrate_abs_pct'      THEN dt.penetrate_abs_pct
       END *
     CASE
       WHEN meas.monetary_fg = 1 THEN cer.rate_currency_exchange
                                 ELSE 1
    END AS DECIMAL(38,9)) AS val
 ,LTrim(Cast(Coalesce(Cast(val AS DECIMAL(18,5))::VARCHAR(50), CASE meas.meas_cd
       WHEN 'feature1'                THEN dt.feature1_name
       WHEN 'feature2'                THEN dt.feature2_name
       WHEN 'feature3'                THEN dt.feature3_name
       WHEN 'feature4'                THEN dt.feature4_name
       WHEN 'feature5'                THEN dt.feature5_name
       WHEN 'feature6'                THEN dt.feature6_name
       WHEN 'feature7'                THEN dt.feature7_name
       WHEN 'feature8'                THEN dt.feature8_name
       WHEN 'feature9'                THEN dt.feature9_name
       WHEN 'feature10'               THEN dt.feature10_name
       WHEN 'feature11'               THEN dt.feature11_name
       WHEN 'feature12'               THEN dt.feature12_name
       WHEN 'feature13'               THEN dt.feature13_name
       WHEN 'feature14'               THEN dt.feature14_name
     END) AS VARCHAR(10000))) AS txt1
  ,Cast(1 AS BYTEINT) AS prot_fg
FROM p_lew_core_ac.v_market_article_feature_2 AS dt
INNER JOIN p_lew_process_mstr_ac.v_lil_region_2 AS reg
ON reg.region_sid = dt.region_sid
INNER JOIN p_lew_core_ac.v_lil_period_2 AS per
ON per.client_id = dt.client_id
AND per.period_sid = dt.period_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_period_2 AS perms
ON perms.client_id = dt.client_id
AND perms.period_sid = dt.period_sid
INNER JOIN p_lew_process_mstr_ac.v_lil_assort_region_cat_2 AS ass
ON ass.client_id = dt.client_id
AND ass.region_sid = dt.region_sid
AND ass.assort_cat_sid = dt.assort_cat_sid
INNER JOIN p_lew_mart_cm.v_lil_currency_exch_rt_2 AS cer
ON cer.from_currency_iso_cd = dt.curr_cd
CROSS JOIN (
    SELECT 
        meas_id
      , meas_cd
      , monetary_fg
    FROM p_lew_process_mstr_ac.v_lil_measure_2
    WHERE meas_cd IN (
         'household_in_country_cnt', 'buyer_ass_cnt', 'turnover_val', 'penetrate_abs_pct',
         'feature1', 'feature2', 'feature3', 'feature4','feature5', 'feature6', 'feature7', 'feature8',
         'feature9', 'feature10', 'feature11', 'feature12', 'feature13', 'feature14'
      )
    ) AS meas

    WHERE NOT meas.meas_id IN (1)
    AND Coalesce(dt.deleted_fg, 0) = 0
    AND NOT EXISTS(
        SELECT NULL
        FROM p_lew_process_mstr_ac.v_lil_data_mask_2 AS dm
        WHERE dm.client_id = dt.client_id
        AND dm.region_sid = dt.region_sid
        AND dm.period_sid = dt.period_sid
        AND dm.src_assort_parent_cat_cd = LTrim(ass.assort_parnt_cat_name_de)
        AND dm.interface_name = 'LIAM_FMCG_AssOpt'
        AND dm.mask_data_fg = 1);