
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_bo_base_abs_mth_2
OPTIONS(DESCRIPTION ='MONTHLY BASIS ABSCHRIFTEN_2', ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
)
AS
SELECT target_type,
 target_type_id,
 client_id,
 store_id,
  CASE
  WHEN target_type_id = 1
  THEN hierarchie_id
  ELSE NULL
  END AS subitemgroup_id,
  CASE
  WHEN target_type_id = 3
  THEN hierarchie_id
  ELSE NULL
  END AS itemgroup_int_id,
 cy_month,
 week_page_by,
 currency_iso_cd,
 country_id,
 country_desc,
 country_iso_cd,
 orig_store_nr,
 store_desc,
 wh_id,
 wh_desc,
 city,
 account_manager_id,
 account_manager_name,
 sales_manager_id,
 sales_manager_name,
 val_rtl_rl_sfo,
 val_rtl_rl_net_sfo,
 val_rtl_net_sfo_mhd_break,
 val_rtl_net_sfo_other_stc_loss,
 val_rtl_net_sfo_str_deliv_qlty,
 val_rtl_rl_sfo_py,
 val_rtl_rl_net_sfo_py,
 val_net_sfo_mhd_break_py,
 val_net_sfo_other_stc_loss_py,
 val_net_sfo_str_deliv_qlty_py,
 val_wrtoff_zero,
 val_wrtoff_zero_net,
 val_wrtoff_zero_net_mhd_break,
 val_wrtoff_zero_net_other_stc_loss,
 val_wrtoff_zero_net_str_deliv_qlty,
 val_discount_ejr,
 val_discount_net_ejr,
 val_rtl_ejr_adj,
 val_rtl_net_ejr_adj,
 val_rtl_ejr_adj_py,
 val_rtl_net_ejr_adj_py,
 sfo_to_val_retail_pct,
 sfo_to_val_retail_net_pct,
 sfo_to_val_retail_pct_py,
 sfo_to_val_retail_net_pct_py,
 val_rtl_total,
 val_rtl_net_total,
 val_rtl_wgi_to_total_pct,
 val_rtl_net_wgi_to_net_tot_pct,
 SUM(CASE
   WHEN rank_sfo_to_val_retail_pct <= 20
   THEN val_rtl_rl_sfo
   ELSE 0
   END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
    , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_sfo_st_sfo_rel,
 SUM(CASE
   WHEN rank_sfo_to_val_retail_net_pct <= 20
   THEN val_rtl_rl_net_sfo
   ELSE 0
   END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
    , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_net_st_sfo_rel,
 SUM(CASE
   WHEN rank_sfo_mhd_break_to_val_retail_net_pct <= 20
   THEN val_rtl_net_sfo_mhd_break
   ELSE 0
   END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
    , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_net_st_sfo_rel_mhd_brk,
 SUM(CASE
   WHEN rank_sfo_to_val_retail_pct <= 20
   THEN val_rtl_ejr_adj
   ELSE 0
   END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
    , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_ejr_adj_sfo_rel,
 SUM(CASE
   WHEN rank_sfo_to_val_retail_net_pct <= 20
   THEN val_rtl_net_ejr_adj
   ELSE 0
   END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
    , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_net_ejr_sfo_rel,
 SUM(CASE
   WHEN rank_sfo_mhd_break_to_val_retail_net_pct <= 20
   THEN val_rtl_net_ejr_adj
   ELSE 0
   END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
    , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_net_ejr_sfo_rel_mhd_brk,
 SUM(CASE
   WHEN rank_val_rtl_wgi_to_total_pct <= 20
   THEN val_rtl_total
   ELSE 0
   END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
    , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_total_rev,
 SUM(CASE
   WHEN rank_val_rtl_net_wgi_to_net_tot_pct <= 20
   THEN val_rtl_net_total
   ELSE 0
   END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
    , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_net_total_rev,
 SUM(CASE
   WHEN rank_val_rtl_wgi_to_total_pct <= 20
   THEN val_rtl_ejr_adj
   ELSE 0
   END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
    , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_pct_rev,
 SUM(CASE
   WHEN rank_val_rtl_net_wgi_to_net_tot_pct <= 20
   THEN val_rtl_net_ejr_adj
   ELSE 0
   END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
    , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_net_pct_rev,
    (SUM(CASE
      WHEN rank_sfo_to_val_retail_pct <= 20
      THEN val_rtl_rl_sfo
      ELSE 0
      END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
       , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(CASE
        WHEN rank_sfo_to_val_retail_pct <= 20
        THEN val_rtl_ejr_adj
        ELSE 0
        END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
         , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(CASE
      WHEN rank_sfo_to_val_retail_pct <= 20
      THEN val_rtl_ejr_adj
      ELSE 0
      END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
       , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * 100 AS top20_sfo_to_val_retail_pct,
    (SUM(CASE
      WHEN rank_sfo_to_val_retail_net_pct <= 20
      THEN val_rtl_rl_net_sfo
      ELSE 0
      END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
       , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(CASE
        WHEN rank_sfo_to_val_retail_net_pct <= 20
        THEN val_rtl_net_ejr_adj
        ELSE 0
        END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
         , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(CASE
      WHEN rank_sfo_to_val_retail_net_pct <= 20
      THEN val_rtl_net_ejr_adj
      ELSE 0
      END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
       , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * 100 AS top20_sfo_to_val_rtl_net_pct,
    (SUM(CASE
      WHEN rank_val_rtl_wgi_to_total_pct <= 20
      THEN val_rtl_ejr_adj
      ELSE 0
      END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
       , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(CASE
        WHEN rank_val_rtl_wgi_to_total_pct <= 20
        THEN val_rtl_total
        ELSE 0
        END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
         , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(CASE
      WHEN rank_val_rtl_wgi_to_total_pct <= 20
      THEN val_rtl_total
      ELSE 0
      END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
       , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * 100 AS top20_val_rtl_to_val_total_pct,
    (SUM(CASE
      WHEN rank_val_rtl_net_wgi_to_net_tot_pct <= 20
      THEN val_rtl_net_ejr_adj
      ELSE 0
      END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
       , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) / IF((SUM(CASE
        WHEN rank_val_rtl_net_wgi_to_net_tot_pct <= 20
        THEN val_rtl_net_total
        ELSE 0
        END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
         , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(CASE
      WHEN rank_val_rtl_net_wgi_to_net_tot_pct <= 20
      THEN val_rtl_net_total
      ELSE 0
      END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
       , CAST(cy_month AS STRING), CAST(week_page_by AS STRING), CAST(hierarchie_id AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) * 100 AS top20_val_rtl_to_net_tot_pct
FROM (SELECT lvl0.target_type,
   lvl0.target_type_id,
   lvl0.client_id,
   lvl0.store_id,
   lvl0.hierarchie_id,
   lvl0.cy_month,
   lvl0.week_page_by,
   lvl0.currency_iso_cd,
   lvl0.country_id,
   lvl0.country_desc,
   lvl0.country_iso_cd,
   lvl0.orig_store_nr,
   lvl0.store_desc,
   lvl0.wh_id,
   lvl0.wh_desc,
   lvl0.city,
   lvl0.account_manager_id,
   lvl0.account_manager_name,
   lvl0.sales_manager_id,
   lvl0.sales_manager_name,
   lvl0.val_rtl_rl_sfo,
   lvl0.val_rtl_rl_net_sfo,
   lvl0.val_rtl_net_sfo_mhd_break,
   lvl0.val_rtl_net_sfo_other_stc_loss,
   lvl0.val_rtl_net_sfo_str_deliv_qlty,
   lvl0.val_rtl_rl_sfo_py,
   lvl0.val_rtl_rl_net_sfo_py,
   lvl0.val_net_sfo_mhd_break_py,
   lvl0.val_net_sfo_other_stc_loss_py,
   lvl0.val_net_sfo_str_deliv_qlty_py,
   lvl0.val_wrtoff_zero,
   lvl0.val_wrtoff_zero_net,
   lvl0.val_wrtoff_zero_net_mhd_break,
   lvl0.val_wrtoff_zero_net_other_stc_loss,
   lvl0.val_wrtoff_zero_net_str_deliv_qlty,
   lvl0.val_discount_ejr,
   lvl0.val_discount_net_ejr,
   lvl0.val_rtl_ejr_adj,
   lvl0.val_rtl_net_ejr_adj,
   lvl0.val_rtl_ejr_adj_py,
   lvl0.val_rtl_net_ejr_adj_py,
   lvl0.sfo_to_val_retail_pct,
   lvl0.sfo_to_val_retail_net_pct,
   lvl0.sfo_mhd_break_to_val_retail_net_pct,
   lvl0.sfo_to_val_retail_pct_py,
   lvl0.sfo_to_val_retail_net_pct_py,
   ums.val_rtl_total,
   ums.val_rtl_net_total,
   CAST(IFNULL(lvl0.val_rtl_ejr_adj / IF(ums.val_rtl_total = 0, NULL, ums.val_rtl_total) * 100.0, 0) AS BIGNUMERIC) AS
   val_rtl_wgi_to_total_pct,
   CAST(IFNULL(lvl0.val_rtl_net_ejr_adj / IF(ums.val_rtl_net_total = 0, NULL, ums.val_rtl_net_total) * 100.0, 0) AS BIGNUMERIC)
   AS val_rtl_net_wgi_to_net_tot_pct,
   ROW_NUMBER() OVER (PARTITION BY lvl0.target_type, CAST(lvl0.target_type_id AS STRING), CAST(lvl0.client_id AS STRING)
      , CAST(lvl0.wh_id AS STRING), CAST(lvl0.cy_month AS STRING), CAST(lvl0.week_page_by AS STRING), CAST(lvl0.hierarchie_id AS STRING)
      ORDER BY CASE
       WHEN lvl0.val_rtl_ejr_adj > 0
       THEN lvl0.sfo_to_val_retail_pct
       ELSE CAST(- 999999999 AS BIGNUMERIC)
       END IS NULL DESC, CASE
       WHEN lvl0.val_rtl_ejr_adj > 0
       THEN lvl0.sfo_to_val_retail_pct
       ELSE CAST(- 999999999 AS BIGNUMERIC)
       END DESC, lvl0.val_rtl_rl_sfo IS NULL, lvl0.val_rtl_rl_sfo, lvl0.store_id IS NULL, lvl0.store_id) AS
   rank_sfo_to_val_retail_pct,
   ROW_NUMBER() OVER (PARTITION BY lvl0.target_type, CAST(lvl0.target_type_id AS STRING), CAST(lvl0.client_id AS STRING)
      , CAST(lvl0.wh_id AS STRING), CAST(lvl0.cy_month AS STRING), CAST(lvl0.week_page_by AS STRING), CAST(lvl0.hierarchie_id AS STRING)
      ORDER BY CASE
       WHEN lvl0.val_rtl_net_ejr_adj > 0
       THEN lvl0.sfo_to_val_retail_net_pct
       ELSE CAST(- 999999999 AS BIGNUMERIC)
       END IS NULL DESC, CASE
       WHEN lvl0.val_rtl_net_ejr_adj > 0
       THEN lvl0.sfo_to_val_retail_net_pct
       ELSE CAST(- 999999999 AS BIGNUMERIC)
       END DESC, lvl0.val_rtl_rl_net_sfo IS NULL, lvl0.val_rtl_rl_net_sfo, lvl0.store_id IS NULL, lvl0.store_id) AS
   rank_sfo_to_val_retail_net_pct,
   ROW_NUMBER() OVER (PARTITION BY lvl0.target_type, CAST(lvl0.target_type_id AS STRING), CAST(lvl0.client_id AS STRING)
      , CAST(lvl0.wh_id AS STRING), CAST(lvl0.cy_month AS STRING), CAST(lvl0.week_page_by AS STRING), CAST(lvl0.hierarchie_id AS STRING)
      ORDER BY CASE
       WHEN lvl0.val_rtl_net_ejr_adj > 0
       THEN lvl0.sfo_mhd_break_to_val_retail_net_pct
       ELSE CAST(- 999999999 AS BIGNUMERIC)
       END IS NULL DESC, CASE
       WHEN lvl0.val_rtl_net_ejr_adj > 0
       THEN lvl0.sfo_mhd_break_to_val_retail_net_pct
       ELSE CAST(- 999999999 AS BIGNUMERIC)
       END DESC, lvl0.val_rtl_net_sfo_mhd_break IS NULL, lvl0.val_rtl_net_sfo_mhd_break, lvl0.store_id IS NULL, lvl0.store_id
      ) AS rank_sfo_mhd_break_to_val_retail_net_pct,
   ROW_NUMBER() OVER (PARTITION BY lvl0.target_type, CAST(lvl0.target_type_id AS STRING), CAST(lvl0.client_id AS STRING)
      , CAST(lvl0.wh_id AS STRING), CAST(lvl0.cy_month AS STRING), CAST(lvl0.week_page_by AS STRING), CAST(lvl0.hierarchie_id AS STRING)
      ORDER BY CAST(IFNULL(lvl0.val_rtl_ejr_adj / IF(ums.val_rtl_total = 0, NULL, ums.val_rtl_total) * 100.0, 0) AS BIGNUMERIC)
      IS NULL DESC, CAST(IFNULL(lvl0.val_rtl_ejr_adj / IF(ums.val_rtl_total = 0, NULL, ums.val_rtl_total) * 100.0, 0) AS BIGNUMERIC)
      DESC, lvl0.store_id IS NULL, lvl0.store_id) AS rank_val_rtl_wgi_to_total_pct,
   ROW_NUMBER() OVER (PARTITION BY lvl0.target_type, CAST(lvl0.target_type_id AS STRING), CAST(lvl0.client_id AS STRING)
      , CAST(lvl0.wh_id AS STRING), CAST(lvl0.cy_month AS STRING), CAST(lvl0.week_page_by AS STRING), CAST(lvl0.hierarchie_id AS STRING)
      ORDER BY CAST(IFNULL(lvl0.val_rtl_net_ejr_adj / IF(ums.val_rtl_net_total = 0, NULL, ums.val_rtl_net_total) * 100.0, 0) AS BIGNUMERIC)
      IS NULL DESC, CAST(IFNULL(lvl0.val_rtl_net_ejr_adj / IF(ums.val_rtl_net_total = 0, NULL, ums.val_rtl_net_total) * 100.0, 0) AS BIGNUMERIC)
      DESC, lvl0.store_id IS NULL, lvl0.store_id) AS rank_val_rtl_net_wgi_to_net_tot_pct
  FROM (SELECT 'SIG' AS target_type,
      1 AS target_type_id,
      BASE.client_id,
      BASE.store_id,
      BASE.subitemgroup_id AS hierarchie_id,
      BASE.cy_month,
      cal.cy_week AS week_page_by,
      BASE.currency_iso_cd,
      BASE.country_id,
      BASE.country_desc,
      BASE.country_iso_cd,
      BASE.orig_store_nr,
      BASE.store_desc,
      BASE.wh_id,
      BASE.wh_desc,
      BASE.city,
      BASE.account_manager_id,
      BASE.account_manager_name,
      BASE.sales_manager_id,
      BASE.sales_manager_name,
      SUM(IFNULL(BASE.val_rtl_rl_sfo, 0)) AS val_rtl_rl_sfo,
      SUM(IFNULL(BASE.val_rtl_rl_net_sfo, 0)) AS val_rtl_rl_net_sfo,
      SUM(IFNULL(BASE.val_rtl_net_sfo_mhd_break, 0)) AS val_rtl_net_sfo_mhd_break,
      SUM(IFNULL(BASE.val_rtl_net_sfo_other_stc_loss, 0)) AS val_rtl_net_sfo_other_stc_loss,
      SUM(IFNULL(BASE.val_rtl_net_sfo_str_deliv_qlty, 0)) AS val_rtl_net_sfo_str_deliv_qlty,
      SUM(IFNULL(BASE.val_rtl_rl_sfo_py, 0)) AS val_rtl_rl_sfo_py,
      SUM(IFNULL(BASE.val_rtl_rl_net_sfo_py, 0)) AS val_rtl_rl_net_sfo_py,
      SUM(IFNULL(BASE.val_net_sfo_mhd_break_py, 0)) AS val_net_sfo_mhd_break_py,
      SUM(IFNULL(BASE.val_net_sfo_other_stc_loss_py, 0)) AS val_net_sfo_other_stc_loss_py,
      SUM(IFNULL(BASE.val_net_sfo_str_deliv_qlty_py, 0)) AS val_net_sfo_str_deliv_qlty_py,
      SUM(IFNULL(BASE.val_wrtoff_zero, 0)) AS val_wrtoff_zero,
      SUM(IFNULL(BASE.val_wrtoff_zero_net, 0)) AS val_wrtoff_zero_net,
      SUM(IFNULL(BASE.val_wrtoff_zero_net_mhd_break, 0)) AS val_wrtoff_zero_net_mhd_break,
      SUM(IFNULL(BASE.val_wrtoff_zero_net_other_stc_loss, 0)) AS val_wrtoff_zero_net_other_stc_loss,
      SUM(IFNULL(BASE.val_wrtoff_zero_net_str_deliv_qlty, 0)) AS val_wrtoff_zero_net_str_deliv_qlty,
      SUM(IFNULL(BASE.val_discount_ejr, 0)) AS val_discount_ejr,
      SUM(IFNULL(BASE.val_discount_net_ejr, 0)) AS val_discount_net_ejr,
      SUM(IFNULL(BASE.val_rtl_ejr_adj, 0)) AS val_rtl_ejr_adj,
      SUM(IFNULL(BASE.val_rtl_net_ejr_adj, 0)) AS val_rtl_net_ejr_adj,
      SUM(IFNULL(BASE.val_rtl_ejr_adj_py, 0)) AS val_rtl_ejr_adj_py,
      SUM(IFNULL(BASE.val_rtl_net_ejr_adj_py, 0)) AS val_rtl_net_ejr_adj_py,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_sfo) / IF(SUM(BASE.val_rtl_ejr_adj) = 0, NULL, SUM(BASE.val_rtl_ejr_adj)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_pct,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_net_sfo) / IF(SUM(BASE.val_rtl_net_ejr_adj) = 0, NULL, SUM(BASE.val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_net_pct,
      CAST(IFNULL(SUM(BASE.val_rtl_net_sfo_mhd_break) / IF(SUM(BASE.val_rtl_net_ejr_adj) = 0, NULL, SUM(BASE.val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
      AS sfo_mhd_break_to_val_retail_net_pct,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_sfo_py) / IF(SUM(BASE.val_rtl_ejr_adj_py) = 0, NULL, SUM(BASE.val_rtl_ejr_adj_py)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_pct_py,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_net_sfo_py) / IF(SUM(BASE.val_rtl_net_ejr_adj_py) = 0, NULL, SUM(BASE.val_rtl_net_ejr_adj_py)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_net_pct_py
     FROM ldl_p_lew_mart_msi.t_bo_base_abs_2 AS BASE
      INNER JOIN (SELECT CAL.cy_week,
        PARSE_DATE('%Y%m%d', SUBSTR(CAST(MIN(MTH.cy_month) AS STRING), 1, 6) || '01') AS date_from,
        DATE_ADD(CAL.cal_dt, INTERVAL 6 DAY) AS date_to
       FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL
        INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS MTH ON CAL.busyear = MTH.busyear AND CAL.cy_month >= MTH.cy_month
       WHERE CAL.cy_week_seq BETWEEN - 4 AND 0
        AND CAL.day_of_week = 1
       GROUP BY CAL.cal_dt,
        CAL.cy_week) AS cal ON BASE.dat_formdate BETWEEN cal.date_from AND cal.date_to
     WHERE BASE.itemgroup_int_id IN (9, 90)
     GROUP BY BASE.client_id,
      BASE.store_id,
      hierarchie_id,
      BASE.wh_id,
      BASE.cy_month,
      week_page_by,
      BASE.currency_iso_cd,
      BASE.country_id,
      BASE.country_desc,
      BASE.country_iso_cd,
      BASE.orig_store_nr,
      BASE.store_desc,
      BASE.wh_desc,
      BASE.city,
      BASE.account_manager_id,
      BASE.account_manager_name,
      BASE.sales_manager_id,
      BASE.sales_manager_name
     UNION ALL
     SELECT 'TOTAL_SIG' AS target_type,
      2 AS target_type_id,
      BASE.client_id,
      BASE.store_id,
      CAST(NULL AS BIGNUMERIC) AS hierarchie_id,
      BASE.cy_month,
      cal.cy_week AS week_page_by,
      BASE.currency_iso_cd,
      BASE.country_id,
      BASE.country_desc,
      BASE.country_iso_cd,
      BASE.orig_store_nr,
      BASE.store_desc,
      BASE.wh_id,
      BASE.wh_desc,
      BASE.city,
      BASE.account_manager_id,
      BASE.account_manager_name,
      BASE.sales_manager_id,
      BASE.sales_manager_name,
      SUM(IFNULL(BASE.val_rtl_rl_sfo, 0)) AS val_rtl_rl_sfo,
      SUM(IFNULL(BASE.val_rtl_rl_net_sfo, 0)) AS val_rtl_rl_net_sfo,
      SUM(IFNULL(BASE.val_rtl_net_sfo_mhd_break, 0)) AS val_rtl_net_sfo_mhd_break,
      SUM(IFNULL(BASE.val_rtl_net_sfo_other_stc_loss, 0)) AS val_rtl_net_sfo_other_stc_loss,
      SUM(IFNULL(BASE.val_rtl_net_sfo_str_deliv_qlty, 0)) AS val_rtl_net_sfo_str_deliv_qlty,
      SUM(IFNULL(BASE.val_rtl_rl_sfo_py, 0)) AS val_rtl_rl_sfo_py,
      SUM(IFNULL(BASE.val_rtl_rl_net_sfo_py, 0)) AS val_rtl_rl_net_sfo_py,
      SUM(IFNULL(BASE.val_net_sfo_mhd_break_py, 0)) AS val_net_sfo_mhd_break_py,
      SUM(IFNULL(BASE.val_net_sfo_other_stc_loss_py, 0)) AS val_net_sfo_other_stc_loss_py,
      SUM(IFNULL(BASE.val_net_sfo_str_deliv_qlty_py, 0)) AS val_net_sfo_str_deliv_qlty_py,
      SUM(IFNULL(BASE.val_wrtoff_zero, 0)) AS val_wrtoff_zero,
      SUM(IFNULL(BASE.val_wrtoff_zero_net, 0)) AS val_wrtoff_zero_net,
      SUM(IFNULL(BASE.val_wrtoff_zero_net_mhd_break, 0)) AS val_wrtoff_zero_net_mhd_break,
      SUM(IFNULL(BASE.val_wrtoff_zero_net_other_stc_loss, 0)) AS val_wrtoff_zero_net_other_stc_loss,
      SUM(IFNULL(BASE.val_wrtoff_zero_net_str_deliv_qlty, 0)) AS val_wrtoff_zero_net_str_deliv_qlty,
      SUM(IFNULL(BASE.val_discount_ejr, 0)) AS val_discount_ejr,
      SUM(IFNULL(BASE.val_discount_net_ejr, 0)) AS val_discount_net_ejr,
      SUM(IFNULL(BASE.val_rtl_ejr_adj, 0)) AS val_rtl_ejr_adj,
      SUM(IFNULL(BASE.val_rtl_net_ejr_adj, 0)) AS val_rtl_net_ejr_adj,
      SUM(IFNULL(BASE.val_rtl_ejr_adj_py, 0)) AS val_rtl_ejr_adj_py,
      SUM(IFNULL(BASE.val_rtl_net_ejr_adj_py, 0)) AS val_rtl_net_ejr_adj_py,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_sfo) / IF(SUM(BASE.val_rtl_ejr_adj) = 0, NULL, SUM(BASE.val_rtl_ejr_adj)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_pct,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_net_sfo) / IF(SUM(BASE.val_rtl_net_ejr_adj) = 0, NULL, SUM(BASE.val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_net_pct,
      CAST(IFNULL(SUM(BASE.val_rtl_net_sfo_mhd_break) / IF(SUM(BASE.val_rtl_net_ejr_adj) = 0, NULL, SUM(BASE.val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
      AS sfo_mhd_break_to_val_retail_net_pct,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_sfo_py) / IF(SUM(BASE.val_rtl_ejr_adj_py) = 0, NULL, SUM(BASE.val_rtl_ejr_adj_py)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_pct_py,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_net_sfo_py) / IF(SUM(BASE.val_rtl_net_ejr_adj_py) = 0, NULL, SUM(BASE.val_rtl_net_ejr_adj_py)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_net_pct_py
     FROM ldl_p_lew_mart_msi.t_bo_base_abs_2 AS BASE
      INNER JOIN (SELECT CAL.cy_week,
        PARSE_DATE('%Y%m%d', SUBSTR(CAST(MIN(MTH.cy_month) AS STRING), 1, 6) || '01') AS date_from,
        DATE_ADD(CAL.cal_dt, INTERVAL 6 DAY) AS date_to
       FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL
        INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS MTH ON CAL.busyear = MTH.busyear AND CAL.cy_month >= MTH.cy_month
       WHERE CAL.cy_week_seq BETWEEN - 4 AND 0
        AND CAL.day_of_week = 1
       GROUP BY CAL.cal_dt,
        CAL.cy_week) AS cal ON BASE.dat_formdate BETWEEN cal.date_from AND cal.date_to
     WHERE BASE.itemgroup_int_id IN (9, 90)
     GROUP BY BASE.client_id,
      BASE.store_id,
      BASE.cy_month,
      week_page_by,
      BASE.currency_iso_cd,
      BASE.country_id,
      BASE.country_desc,
      BASE.country_iso_cd,
      BASE.orig_store_nr,
      BASE.store_desc,
      BASE.wh_id,
      BASE.wh_desc,
      BASE.city,
      BASE.account_manager_id,
      BASE.account_manager_name,
      BASE.sales_manager_id,
      BASE.sales_manager_name
     UNION ALL
     SELECT 'WGI' AS target_type,
      3 AS target_type_id,
      BASE.client_id,
      BASE.store_id,
      BASE.itemgroup_int_id AS hierarchie_id,
      BASE.cy_month,
      cal.cy_week AS week_page_by,
      BASE.currency_iso_cd,
      BASE.country_id,
      BASE.country_desc,
      BASE.country_iso_cd,
      BASE.orig_store_nr,
      BASE.store_desc,
      BASE.wh_id,
      BASE.wh_desc,
      BASE.city,
      BASE.account_manager_id,
      BASE.account_manager_name,
      BASE.sales_manager_id,
      BASE.sales_manager_name,
      SUM(IFNULL(BASE.val_rtl_rl_sfo, 0)) AS val_rtl_rl_sfo,
      SUM(IFNULL(BASE.val_rtl_rl_net_sfo, 0)) AS val_rtl_rl_net_sfo,
      SUM(IFNULL(BASE.val_rtl_net_sfo_mhd_break, 0)) AS val_rtl_net_sfo_mhd_break,
      SUM(IFNULL(BASE.val_rtl_net_sfo_other_stc_loss, 0)) AS val_rtl_net_sfo_other_stc_loss,
      SUM(IFNULL(BASE.val_rtl_net_sfo_str_deliv_qlty, 0)) AS val_rtl_net_sfo_str_deliv_qlty,
      SUM(IFNULL(BASE.val_rtl_rl_sfo_py, 0)) AS val_rtl_rl_sfo_py,
      SUM(IFNULL(BASE.val_rtl_rl_net_sfo_py, 0)) AS val_rtl_rl_net_sfo_py,
      SUM(IFNULL(BASE.val_net_sfo_mhd_break_py, 0)) AS val_net_sfo_mhd_break_py,
      SUM(IFNULL(BASE.val_net_sfo_other_stc_loss_py, 0)) AS val_net_sfo_other_stc_loss_py,
      SUM(IFNULL(BASE.val_net_sfo_str_deliv_qlty_py, 0)) AS val_net_sfo_str_deliv_qlty_py,
      SUM(IFNULL(BASE.val_wrtoff_zero, 0)) AS val_wrtoff_zero,
      SUM(IFNULL(BASE.val_wrtoff_zero_net, 0)) AS val_wrtoff_zero_net,
      SUM(IFNULL(BASE.val_wrtoff_zero_net_mhd_break, 0)) AS val_wrtoff_zero_net_mhd_break,
      SUM(IFNULL(BASE.val_wrtoff_zero_net_other_stc_loss, 0)) AS val_wrtoff_zero_net_other_stc_loss,
      SUM(IFNULL(BASE.val_wrtoff_zero_net_str_deliv_qlty, 0)) AS val_wrtoff_zero_net_str_deliv_qlty,
      SUM(IFNULL(BASE.val_discount_ejr, 0)) AS val_discount_ejr,
      SUM(IFNULL(BASE.val_discount_net_ejr, 0)) AS val_discount_net_ejr,
      SUM(IFNULL(BASE.val_rtl_ejr_adj, 0)) AS val_rtl_ejr_adj,
      SUM(IFNULL(BASE.val_rtl_net_ejr_adj, 0)) AS val_rtl_net_ejr_adj,
      SUM(IFNULL(BASE.val_rtl_ejr_adj_py, 0)) AS val_rtl_ejr_adj_py,
      SUM(IFNULL(BASE.val_rtl_net_ejr_adj_py, 0)) AS val_rtl_net_ejr_adj_py,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_sfo) / IF(SUM(BASE.val_rtl_ejr_adj) = 0, NULL, SUM(BASE.val_rtl_ejr_adj)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_pct,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_net_sfo) / IF(SUM(BASE.val_rtl_net_ejr_adj) = 0, NULL, SUM(BASE.val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_net_pct,
      CAST(IFNULL(SUM(BASE.val_rtl_net_sfo_mhd_break) / IF(SUM(BASE.val_rtl_net_ejr_adj) = 0, NULL, SUM(BASE.val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
      AS sfo_mhd_break_to_val_retail_net_pct,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_sfo_py) / IF(SUM(BASE.val_rtl_ejr_adj_py) = 0, NULL, SUM(BASE.val_rtl_ejr_adj_py)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_pct_py,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_net_sfo_py) / IF(SUM(BASE.val_rtl_net_ejr_adj_py) = 0, NULL, SUM(BASE.val_rtl_net_ejr_adj_py)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_net_pct_py
     FROM ldl_p_lew_mart_msi.t_bo_base_abs_2 AS BASE
      INNER JOIN (SELECT CAL.cy_week,
        PARSE_DATE('%Y%m%d', SUBSTR(CAST(MIN(MTH.cy_month) AS STRING), 1, 6) || '01') AS date_from,
        DATE_ADD(CAL.cal_dt, INTERVAL 6 DAY) AS date_to
       FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL
        INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS MTH ON CAL.busyear = MTH.busyear AND CAL.cy_month >= MTH.cy_month
       WHERE CAL.cy_week_seq BETWEEN - 4 AND 0
        AND CAL.day_of_week = 1
       GROUP BY CAL.cal_dt,
        CAL.cy_week) AS cal ON BASE.dat_formdate BETWEEN cal.date_from AND cal.date_to
     WHERE BASE.itemgroup_int_id >= 0
     GROUP BY BASE.client_id,
      BASE.store_id,
      hierarchie_id,
      BASE.wh_id,
      BASE.cy_month,
      week_page_by,
      BASE.currency_iso_cd,
      BASE.country_id,
      BASE.country_desc,
      BASE.country_iso_cd,
      BASE.orig_store_nr,
      BASE.store_desc,
      BASE.wh_desc,
      BASE.city,
      BASE.account_manager_id,
      BASE.account_manager_name,
      BASE.sales_manager_id,
      BASE.sales_manager_name
     UNION ALL
     SELECT 'TOTAL' AS target_type,
      4 AS target_type_id,
      BASE.client_id,
      BASE.store_id,
      CAST(NULL AS BIGNUMERIC) AS hierarchie_id,
      BASE.cy_month,
      cal.cy_week AS week_page_by,
      BASE.currency_iso_cd,
      BASE.country_id,
      BASE.country_desc,
      BASE.country_iso_cd,
      BASE.orig_store_nr,
      BASE.store_desc,
      BASE.wh_id,
      BASE.wh_desc,
      BASE.city,
      BASE.account_manager_id,
      BASE.account_manager_name,
      BASE.sales_manager_id,
      BASE.sales_manager_name,
      SUM(IFNULL(BASE.val_rtl_rl_sfo, 0)) AS val_rtl_rl_sfo,
      SUM(IFNULL(BASE.val_rtl_rl_net_sfo, 0)) AS val_rtl_rl_net_sfo,
      SUM(IFNULL(BASE.val_rtl_net_sfo_mhd_break, 0)) AS val_rtl_net_sfo_mhd_break,
      SUM(IFNULL(BASE.val_rtl_net_sfo_other_stc_loss, 0)) AS val_rtl_net_sfo_other_stc_loss,
      SUM(IFNULL(BASE.val_rtl_net_sfo_str_deliv_qlty, 0)) AS val_rtl_net_sfo_str_deliv_qlty,
      SUM(IFNULL(BASE.val_rtl_rl_sfo_py, 0)) AS val_rtl_rl_sfo_py,
      SUM(IFNULL(BASE.val_rtl_rl_net_sfo_py, 0)) AS val_rtl_rl_net_sfo_py,
      SUM(IFNULL(BASE.val_net_sfo_mhd_break_py, 0)) AS val_net_sfo_mhd_break_py,
      SUM(IFNULL(BASE.val_net_sfo_other_stc_loss_py, 0)) AS val_net_sfo_other_stc_loss_py,
      SUM(IFNULL(BASE.val_net_sfo_str_deliv_qlty_py, 0)) AS val_net_sfo_str_deliv_qlty_py,
      SUM(IFNULL(BASE.val_wrtoff_zero, 0)) AS val_wrtoff_zero,
      SUM(IFNULL(BASE.val_wrtoff_zero_net, 0)) AS val_wrtoff_zero_net,
      SUM(IFNULL(BASE.val_wrtoff_zero_net_mhd_break, 0)) AS val_wrtoff_zero_net_mhd_break,
      SUM(IFNULL(BASE.val_wrtoff_zero_net_other_stc_loss, 0)) AS val_wrtoff_zero_net_other_stc_loss,
      SUM(IFNULL(BASE.val_wrtoff_zero_net_str_deliv_qlty, 0)) AS val_wrtoff_zero_net_str_deliv_qlty,
      SUM(IFNULL(BASE.val_discount_ejr, 0)) AS val_discount_ejr,
      SUM(IFNULL(BASE.val_discount_net_ejr, 0)) AS val_discount_net_sfo,
      SUM(IFNULL(BASE.val_rtl_ejr_adj, 0)) AS val_rtl_ejr_adj,
      SUM(IFNULL(BASE.val_rtl_net_ejr_adj, 0)) AS val_rtl_net_ejr_adj,
      SUM(IFNULL(BASE.val_rtl_ejr_adj_py, 0)) AS val_rtl_ejr_adj_py,
      SUM(IFNULL(BASE.val_rtl_net_ejr_adj_py, 0)) AS val_rtl_net_ejr_adj_py,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_sfo) / IF(SUM(BASE.val_rtl_ejr_adj) = 0, NULL, SUM(BASE.val_rtl_ejr_adj)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_pct,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_net_sfo) / IF(SUM(BASE.val_rtl_net_ejr_adj) = 0, NULL, SUM(BASE.val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_net_pct,
      CAST(IFNULL(SUM(BASE.val_rtl_net_sfo_mhd_break) / IF(SUM(BASE.val_rtl_net_ejr_adj) = 0, NULL, SUM(BASE.val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
      AS sfo_mhd_break_to_val_retail_net_pct,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_sfo_py) / IF(SUM(BASE.val_rtl_ejr_adj_py) = 0, NULL, SUM(BASE.val_rtl_ejr_adj_py)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_pct_py,
      CAST(IFNULL(SUM(BASE.val_rtl_rl_net_sfo_py) / IF(SUM(BASE.val_rtl_net_ejr_adj_py) = 0, NULL, SUM(BASE.val_rtl_net_ejr_adj_py)), 0) AS BIGNUMERIC)
      AS sfo_to_val_retail_net_pct_py
     FROM ldl_p_lew_mart_msi.t_bo_base_abs_2 AS BASE
      INNER JOIN (SELECT CAL.cy_week,
        PARSE_DATE('%Y%m%d', SUBSTR(CAST(MIN(MTH.cy_month) AS STRING), 1, 6) || '01') AS date_from,
        DATE_ADD(CAL.cal_dt, INTERVAL 6 DAY) AS date_to
       FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL
        INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS MTH ON CAL.busyear = MTH.busyear AND CAL.cy_month >= MTH.cy_month
       WHERE CAL.cy_week_seq BETWEEN - 4 AND 0
        AND CAL.day_of_week = 1
       GROUP BY CAL.cal_dt,
        CAL.cy_week) AS cal ON BASE.dat_formdate BETWEEN cal.date_from AND cal.date_to
     GROUP BY BASE.client_id,
      BASE.store_id,
      BASE.wh_id,
      BASE.cy_month,
      week_page_by,
      BASE.currency_iso_cd,
      BASE.country_id,
      BASE.country_desc,
      BASE.country_iso_cd,
      BASE.orig_store_nr,
      BASE.store_desc,
      BASE.wh_desc,
      BASE.city,
      BASE.account_manager_id,
      BASE.account_manager_name,
      BASE.sales_manager_id,
      BASE.sales_manager_name) AS lvl0
   LEFT JOIN (SELECT SALES.client_id,
     SALES.loc_sid_store,
     SALES.cy_month,
     cal.cy_week AS week_page_by,
     SUM(SALES.val_retail) AS val_rtl_total,
     SUM(SALES.val_retail_net) AS val_rtl_net_total
    FROM ldl_p_lew_bil_ac.v_agg_sales_store_day_2 AS SALES_2
     INNER JOIN (SELECT CAL0.cy_week,
       PARSE_DATE('%Y%m%d', SUBSTR(CAST(MIN(MTH0.cy_month) AS STRING), 1, 6) || '01') AS date_from,
       DATE_ADD(CAL0.cal_dt, INTERVAL 6 DAY) AS date_to
      FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL0
       INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS MTH0 ON CAL0.busyear = MTH0.busyear AND CAL0.cy_month >= MTH0.cy_month
         
      WHERE CAL0.cy_week_seq BETWEEN - 4 AND 0
       AND CAL0.day_of_week = 1
      GROUP BY CAL0.cal_dt,
       CAL0.cy_week) AS cal ON SALES.dat_formdate BETWEEN cal.date_from AND cal.date_to
    GROUP BY SALES.client_id,
     SALES.loc_sid_store,
     SALES.cy_month,
     week_page_by) AS ums ON lvl0.client_id = ums.client_id AND lvl0.store_id = ums.loc_sid_store AND lvl0.cy_month =
       ums.cy_month AND lvl0.week_page_by = ums.week_page_by AND lvl0.target_type_id IN (1, 3)) AS lvl2;

