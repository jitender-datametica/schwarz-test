
/*
Subversion Infostamp END.
#----------------------------------------------------------------------------
# History:
#                                              Neuanlage
#                                              Konsolidierung
#  1.2  03.07.2018    Arnold,Arne              Umsatzquelle angepasst
#  1.3  28.09.2018    Wandtke,Andrzej          20180925_1840_FBO_Provide_Filial_Abschriften_Part2 - Add columns related to specific types of writeoffs
#  1.4  16.11.2018    Michael Strauch          20181113_1882_Differ_writeoff_reasons_FBO_Rep1 - extENDed by some columns to differenziate the values by pcwo_resons
#  1.5  08.10.2020    Kiran N                  20201007_2609_WG_id_ext_Frischfisch
#                                              ExtENDing the view with new WG-ids.
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_bo_base_abs_week_1
OPTIONS(DESCRIPTION = 'ABSCHRIFTEN_1 AUF WEEKLY BASIS', ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
)
AS
SELECT lvl3.target_type,
 lvl3.target_type_id,
 lvl3.client_id,
 lvl3.store_id,
 PROMPT.cy_week AS week_page_by,
 lvl3.cy_week,
 lvl3.subitemgroup_id,
 lvl3.itemgroup_int_id,
 lvl3.currency_iso_cd,
 lvl3.country_id,
 lvl3.country_desc,
 lvl3.country_iso_cd,
 lvl3.orig_store_nr,
 lvl3.store_desc,
 lvl3.wh_id,
 lvl3.wh_desc,
 lvl3.city,
 lvl3.account_manager_id,
 lvl3.account_manager_name,
 lvl3.sales_manager_id,
 lvl3.sales_manager_name,
 lvl3.val_rtl_rl_sfo,
 lvl3.val_rtl_rl_net_sfo,
 lvl3.val_rtl_net_sfo_mhd_break,
 lvl3.val_rtl_net_sfo_other_stc_loss,
 lvl3.val_rtl_net_sfo_str_deliv_qlty,
 lvl3.val_rtl_rl_sfo_py,
 lvl3.val_rtl_rl_net_sfo_py,
 lvl3.val_net_sfo_mhd_break_py,
 lvl3.val_net_sfo_other_stc_loss_py,
 lvl3.val_net_sfo_str_deliv_qlty_py,
 lvl3.val_wrtoff_zero,
 lvl3.val_wrtoff_zero_net,
 lvl3.val_wrtoff_zero_net_mhd_break,
 lvl3.val_wrtoff_zero_net_other_stc_loss,
 lvl3.val_wrtoff_zero_net_str_deliv_qlty,
 lvl3.val_discount_ejr,
 lvl3.val_discount_net_ejr,
 lvl3.val_rtl_ejr_adj,
 lvl3.val_rtl_net_ejr_adj,
 lvl3.val_rtl_ejr_adj_py,
 lvl3.val_rtl_net_ejr_adj_py,
 lvl3.sfo_to_val_retail_pct,
 lvl3.sfo_to_val_retail_net_pct,
 lvl3.sfo_to_val_retail_pct_py,
 lvl3.sfo_to_val_retail_net_pct_py,
 lvl3.val_rtl_total,
 lvl3.val_rtl_net_total,
 lvl3.val_rtl_wgi_to_total_pct,
 lvl3.val_rtl_net_wgi_to_net_tot_pct,
 lvl3.top20_val_rtl_sfo_st_sfo_rel,
 lvl3.top20_val_rtl_net_st_sfo_rel,
 lvl3.top20_val_rtl_net_st_sfo_rel_mhd_brk,
 lvl3.top20_val_rtl_ejr_adj_sfo_rel,
 lvl3.top20_val_rtl_net_ejr_sfo_rel,
 lvl3.top20_val_rtl_net_ejr_sfo_rel_mhd_brk,
 lvl3.top20_sfo_to_val_retail_pct,
 lvl3.top20_sfo_to_val_rtl_net_pct,
 lvl3.top20_val_rtl_pct_rev,
 lvl3.top20_val_rtl_net_pct_rev,
 lvl3.top20_val_rtl_total_rev,
 lvl3.top20_val_rtl_net_total_rev,
 lvl3.top20_val_rtl_to_val_total_pct,
 lvl3.top20_val_rtl_to_net_tot_pct
FROM (SELECT target_type,
   target_type_id,
   client_id,
   store_id,
   cy_week,
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
      , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS top20_val_rtl_sfo_st_sfo_rel,
   SUM(CASE
     WHEN rank_sfo_to_val_retail_net_pct <= 20
     THEN val_rtl_rl_net_sfo
     ELSE 0
     END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
      , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS top20_val_rtl_net_st_sfo_rel,
   SUM(CASE
     WHEN rank_sfo_mhd_break_to_val_retail_net_pct <= 20
     THEN val_rtl_net_sfo_mhd_break
     ELSE 0
     END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
      , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS top20_val_rtl_net_st_sfo_rel_mhd_brk,
   SUM(CASE
     WHEN rank_sfo_to_val_retail_pct <= 20
     THEN val_rtl_ejr_adj
     ELSE 0
     END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
      , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS top20_val_rtl_ejr_adj_sfo_rel,
   SUM(CASE
     WHEN rank_sfo_to_val_retail_net_pct <= 20
     THEN val_rtl_net_ejr_adj
     ELSE 0
     END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
      , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS top20_val_rtl_net_ejr_sfo_rel,
   SUM(CASE
     WHEN rank_sfo_mhd_break_to_val_retail_net_pct <= 20
     THEN val_rtl_net_ejr_adj
     ELSE 0
     END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
      , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS top20_val_rtl_net_ejr_sfo_rel_mhd_brk,
      (SUM(CASE
        WHEN rank_sfo_to_val_retail_pct <= 20
        THEN val_rtl_rl_sfo
        ELSE 0
        END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
         , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
       UNBOUNDED FOLLOWING)) / IF((SUM(CASE
          WHEN rank_sfo_to_val_retail_pct <= 20
          THEN val_rtl_ejr_adj
          ELSE 0
          END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
           , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING)) = 0, NULL, SUM(CASE
        WHEN rank_sfo_to_val_retail_pct <= 20
        THEN val_rtl_ejr_adj
        ELSE 0
        END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
         , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
       UNBOUNDED FOLLOWING)) * 100 AS top20_sfo_to_val_retail_pct,
      (SUM(CASE
        WHEN rank_sfo_to_val_retail_net_pct <= 20
        THEN val_rtl_rl_net_sfo
        ELSE 0
        END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
         , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
       UNBOUNDED FOLLOWING)) / IF((SUM(CASE
          WHEN rank_sfo_to_val_retail_net_pct <= 20
          THEN val_rtl_net_ejr_adj
          ELSE 0
          END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
           , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING)) = 0, NULL, SUM(CASE
        WHEN rank_sfo_to_val_retail_net_pct <= 20
        THEN val_rtl_net_ejr_adj
        ELSE 0
        END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
         , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
       UNBOUNDED FOLLOWING)) * 100 AS top20_sfo_to_val_rtl_net_pct,
   SUM(CASE
     WHEN rank_val_rtl_wgi_to_total_pct <= 20
     THEN val_rtl_ejr_adj
     ELSE 0
     END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
      , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS top20_val_rtl_pct_rev,
   SUM(CASE
     WHEN rank_val_rtl_net_wgi_to_net_tot_pct <= 20
     THEN val_rtl_net_ejr_adj
     ELSE 0
     END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
      , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS top20_val_rtl_net_pct_rev,
   SUM(CASE
     WHEN rank_val_rtl_wgi_to_total_pct <= 20
     THEN val_rtl_total
     ELSE 0
     END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
      , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS top20_val_rtl_total_rev,
   SUM(CASE
     WHEN rank_val_rtl_net_wgi_to_net_tot_pct <= 20
     THEN val_rtl_net_total
     ELSE 0
     END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
      , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS top20_val_rtl_net_total_rev,
      (SUM(CASE
        WHEN rank_val_rtl_wgi_to_total_pct <= 20
        THEN val_rtl_ejr_adj
        ELSE 0
        END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
         , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
       UNBOUNDED FOLLOWING)) / IF((SUM(CASE
          WHEN rank_val_rtl_wgi_to_total_pct <= 20
          THEN val_rtl_total
          ELSE 0
          END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
           , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING)) = 0, NULL, SUM(CASE
        WHEN rank_val_rtl_wgi_to_total_pct <= 20
        THEN val_rtl_total
        ELSE 0
        END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
         , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
       UNBOUNDED FOLLOWING)) * 100 AS top20_val_rtl_to_val_total_pct,
      (SUM(CASE
        WHEN rank_val_rtl_net_wgi_to_net_tot_pct <= 20
        THEN val_rtl_net_ejr_adj
        ELSE 0
        END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
         , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
       UNBOUNDED FOLLOWING)) / IF((SUM(CASE
          WHEN rank_val_rtl_net_wgi_to_net_tot_pct <= 20
          THEN val_rtl_net_total
          ELSE 0
          END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
           , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING)) = 0, NULL, SUM(CASE
        WHEN rank_val_rtl_net_wgi_to_net_tot_pct <= 20
        THEN val_rtl_net_total
        ELSE 0
        END) OVER (PARTITION BY target_type, CAST(target_type_id AS STRING), CAST(client_id AS STRING), CAST(wh_id AS STRING)
         , CAST(hierarchie_id AS STRING), CAST(cy_week AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
       UNBOUNDED FOLLOWING)) * 100 AS top20_val_rtl_to_net_tot_pct
  FROM (SELECT lvl0.target_type,
     lvl0.target_type_id,
     lvl0.client_id,
     lvl0.store_id,
     lvl0.cy_week,
     lvl0.hierarchie_id,
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
        , CAST(lvl0.wh_id AS STRING), CAST(lvl0.hierarchie_id AS STRING), CAST(lvl0.cy_week AS STRING) ORDER BY CASE
         WHEN lvl0.val_rtl_ejr_adj > 0
         THEN lvl0.sfo_to_val_retail_pct
         ELSE CAST(- 999999999 AS BIGNUMERIC)
         END IS NULL, CASE
         WHEN lvl0.val_rtl_ejr_adj > 0
         THEN lvl0.sfo_to_val_retail_pct
         ELSE CAST(- 999999999 AS BIGNUMERIC)
         END, lvl0.val_rtl_rl_sfo, lvl0.store_id) AS rank_sfo_to_val_retail_pct,
     ROW_NUMBER() OVER (PARTITION BY lvl0.target_type, CAST(lvl0.target_type_id AS STRING), CAST(lvl0.client_id AS STRING)
        , CAST(lvl0.wh_id AS STRING), CAST(lvl0.hierarchie_id AS STRING), CAST(lvl0.cy_week AS STRING) ORDER BY CASE
         WHEN lvl0.val_rtl_net_ejr_adj > 0
         THEN lvl0.sfo_to_val_retail_net_pct
         ELSE CAST(- 999999999 AS BIGNUMERIC)
         END IS NULL, CASE
         WHEN lvl0.val_rtl_net_ejr_adj > 0
         THEN lvl0.sfo_to_val_retail_net_pct
         ELSE CAST(- 999999999 AS BIGNUMERIC)
         END, lvl0.val_rtl_rl_net_sfo, lvl0.store_id) AS rank_sfo_to_val_retail_net_pct,
     ROW_NUMBER() OVER (PARTITION BY lvl0.target_type, CAST(lvl0.target_type_id AS STRING), CAST(lvl0.client_id AS STRING)
        , CAST(lvl0.wh_id AS STRING), CAST(lvl0.hierarchie_id AS STRING), CAST(lvl0.cy_week AS STRING) ORDER BY CASE
         WHEN lvl0.val_rtl_net_ejr_adj > 0
         THEN lvl0.sfo_mhd_break_to_val_retail_net_pct
         ELSE CAST(- 999999999 AS BIGNUMERIC)
         END IS NULL, CASE
         WHEN lvl0.val_rtl_net_ejr_adj > 0
         THEN lvl0.sfo_mhd_break_to_val_retail_net_pct
         ELSE CAST(- 999999999 AS BIGNUMERIC)
         END, lvl0.val_rtl_rl_net_sfo, lvl0.store_id) AS rank_sfo_mhd_break_to_val_retail_net_pct,
     ROW_NUMBER() OVER (PARTITION BY lvl0.target_type, CAST(lvl0.target_type_id AS STRING), CAST(lvl0.client_id AS STRING)
        , CAST(lvl0.wh_id AS STRING), CAST(lvl0.hierarchie_id AS STRING), CAST(lvl0.cy_week AS STRING) ORDER BY CAST(IFNULL(lvl0.val_rtl_ejr_adj / IF(ums.val_rtl_total = 0, NULL, ums.val_rtl_total) * 100.0, 0) AS BIGNUMERIC)
        IS NULL, CAST(IFNULL(lvl0.val_rtl_ejr_adj / IF(ums.val_rtl_total = 0, NULL, ums.val_rtl_total) * 100.0, 0) AS BIGNUMERIC)
        , lvl0.store_id) AS rank_val_rtl_wgi_to_total_pct,
     ROW_NUMBER() OVER (PARTITION BY lvl0.target_type, CAST(lvl0.target_type_id AS STRING), CAST(lvl0.client_id AS STRING)
        , CAST(lvl0.wh_id AS STRING), CAST(lvl0.hierarchie_id AS STRING), CAST(lvl0.cy_week AS STRING) ORDER BY CAST(IFNULL(lvl0.val_rtl_net_ejr_adj / IF(ums.val_rtl_net_total = 0, NULL, ums.val_rtl_net_total) * 100.0, 0) AS BIGNUMERIC)
        IS NULL, CAST(IFNULL(lvl0.val_rtl_net_ejr_adj / IF(ums.val_rtl_net_total = 0, NULL, ums.val_rtl_net_total) * 100.0, 0) AS BIGNUMERIC)
        , lvl0.store_id) AS rank_val_rtl_net_wgi_to_net_tot_pct
    FROM (SELECT 'SIG' AS target_type,
        1 AS target_type_id,
        client_id,
        store_id,
        cy_week,
        subitemgroup_id AS hierarchie_id,
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
        SUM(val_rtl_rl_sfo) AS val_rtl_rl_sfo,
        SUM(val_rtl_rl_net_sfo) AS val_rtl_rl_net_sfo,
        SUM(val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break,
        SUM(val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss,
        SUM(val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty,
        SUM(val_rtl_rl_sfo_py) AS val_rtl_rl_sfo_py,
        SUM(val_rtl_rl_net_sfo_py) AS val_rtl_rl_net_sfo_py,
        SUM(val_net_sfo_mhd_break_py) AS val_net_sfo_mhd_break_py,
        SUM(val_net_sfo_other_stc_loss_py) AS val_net_sfo_other_stc_loss_py,
        SUM(val_net_sfo_str_deliv_qlty_py) AS val_net_sfo_str_deliv_qlty_py,
        SUM(val_wrtoff_zero) AS val_wrtoff_zero,
        SUM(val_wrtoff_zero_net) AS val_wrtoff_zero_net,
        SUM(val_wrtoff_zero_net_mhd_break) AS val_wrtoff_zero_net_mhd_break,
        SUM(val_wrtoff_zero_net_other_stc_loss) AS val_wrtoff_zero_net_other_stc_loss,
        SUM(val_wrtoff_zero_net_str_deliv_qlty) AS val_wrtoff_zero_net_str_deliv_qlty,
        SUM(val_discount_ejr) AS val_discount_ejr,
        SUM(val_discount_net_ejr) AS val_discount_net_ejr,
        SUM(val_rtl_ejr_adj) AS val_rtl_ejr_adj,
        SUM(val_rtl_net_ejr_adj) AS val_rtl_net_ejr_adj,
        SUM(val_rtl_ejr_adj_py) AS val_rtl_ejr_adj_py,
        SUM(val_rtl_net_ejr_adj_py) AS val_rtl_net_ejr_adj_py,
        CAST(IFNULL(SUM(val_rtl_rl_sfo) / IF(SUM(val_rtl_ejr_adj) = 0, NULL, SUM(val_rtl_ejr_adj)), 0) AS BIGNUMERIC) AS
        sfo_to_val_retail_pct,
        CAST(IFNULL(SUM(val_rtl_rl_net_sfo) / IF(SUM(val_rtl_net_ejr_adj) = 0, NULL, SUM(val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
        AS sfo_to_val_retail_net_pct,
        CAST(IFNULL(SUM(val_rtl_net_sfo_mhd_break) / IF(SUM(val_rtl_net_ejr_adj) = 0, NULL, SUM(val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
        AS sfo_mhd_break_to_val_retail_net_pct,
        CAST(IFNULL(SUM(val_rtl_rl_sfo_py) / IF(SUM(val_rtl_ejr_adj_py) = 0, NULL, SUM(val_rtl_ejr_adj_py)), 0) AS BIGNUMERIC)
        AS sfo_to_val_retail_pct_py,
        CAST(IFNULL(SUM(val_rtl_rl_net_sfo_py) / IF(SUM(val_rtl_net_ejr_adj_py) = 0, NULL, SUM(val_rtl_net_ejr_adj_py)), 0) AS BIGNUMERIC)
        AS sfo_to_val_retail_net_pct_py
       FROM ldl_p_lew_mart_msi.t_bo_base_abs_1 AS BASE
       WHERE cy_week_seq BETWEEN - 17 AND (- 1)
        AND itemgroup_int_id IN (9, 90)
       GROUP BY client_id,
        store_id,
        wh_id,
        cy_week,
        hierarchie_id,
        currency_iso_cd,
        country_id,
        country_desc,
        country_iso_cd,
        orig_store_nr,
        store_desc,
        wh_desc,
        city,
        account_manager_id,
        account_manager_name,
        sales_manager_id,
        sales_manager_name
       UNION ALL
       SELECT 'TOTAL_SIG' AS target_type,
        2 AS target_type_id,
        client_id,
        store_id,
        cy_week,
        CAST(NULL AS BIGNUMERIC) AS hierarchie_id,
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
        SUM(val_rtl_rl_sfo) AS val_rtl_rl_sfo,
        SUM(val_rtl_rl_net_sfo) AS val_rtl_rl_net_sfo,
        SUM(val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break,
        SUM(val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss,
        SUM(val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty,
        SUM(val_rtl_rl_sfo_py) AS val_rtl_rl_sfo_py,
        SUM(val_rtl_rl_net_sfo_py) AS val_rtl_rl_net_sfo_py,
        SUM(val_net_sfo_mhd_break_py) AS val_net_sfo_mhd_break_py,
        SUM(val_net_sfo_other_stc_loss_py) AS val_net_sfo_other_stc_loss_py,
        SUM(val_net_sfo_str_deliv_qlty_py) AS val_net_sfo_str_deliv_qlty_py,
        SUM(val_wrtoff_zero) AS val_wrtoff_zero,
        SUM(val_wrtoff_zero_net) AS val_wrtoff_zero_net,
        SUM(val_wrtoff_zero_net_mhd_break) AS val_wrtoff_zero_net_mhd_break,
        SUM(val_wrtoff_zero_net_other_stc_loss) AS val_wrtoff_zero_net_other_stc_loss,
        SUM(val_wrtoff_zero_net_str_deliv_qlty) AS val_wrtoff_zero_net_str_deliv_qlty,
        SUM(val_discount_ejr) AS val_discount_sfo,
        SUM(val_discount_net_ejr) AS val_discount_net_sfo,
        SUM(val_rtl_ejr_adj) AS val_rtl_ejr_adj,
        SUM(val_rtl_net_ejr_adj) AS val_rtl_net_ejr_adj,
        SUM(val_rtl_ejr_adj_py) AS val_rtl_ejr_adj_py,
        SUM(val_rtl_net_ejr_adj_py) AS val_rtl_net_ejr_adj_py,
        CAST(IFNULL(SUM(val_rtl_rl_sfo) / IF(SUM(val_rtl_ejr_adj) = 0, NULL, SUM(val_rtl_ejr_adj)), 0) AS BIGNUMERIC) AS
        sfo_to_val_retail_pct,
        CAST(IFNULL(SUM(val_rtl_rl_net_sfo) / IF(SUM(val_rtl_net_ejr_adj) = 0, NULL, SUM(val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
        AS sfo_to_val_retail_net_pct,
        CAST(IFNULL(SUM(val_rtl_net_sfo_mhd_break) / IF(SUM(val_rtl_net_ejr_adj) = 0, NULL, SUM(val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
        AS sfo_mhd_break_to_val_retail_net_pct,
        CAST(IFNULL(SUM(val_rtl_rl_sfo_py) / IF(SUM(val_rtl_ejr_adj_py) = 0, NULL, SUM(val_rtl_ejr_adj_py)), 0) AS BIGNUMERIC)
        AS sfo_to_val_retail_pct_py,
        CAST(IFNULL(SUM(val_rtl_rl_net_sfo_py) / IF(SUM(val_rtl_net_ejr_adj_py) = 0, NULL, SUM(val_rtl_net_ejr_adj_py)), 0) AS BIGNUMERIC)
        AS sfo_to_val_retail_net_pct_py
       FROM ldl_p_lew_mart_msi.t_bo_base_abs_1 AS BASE
       WHERE cy_week_seq BETWEEN - 17 AND (- 1)
        AND itemgroup_int_id IN (9, 90)
       GROUP BY client_id,
        store_id,
        cy_week,
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
        sales_manager_name
       UNION ALL
       SELECT 'WGI' AS target_type,
        3 AS target_type_id,
        client_id,
        store_id,
        cy_week,
        itemgroup_int_id AS hierarchie_id,
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
        SUM(val_rtl_rl_sfo) AS val_rtl_rl_sfo,
        SUM(val_rtl_rl_net_sfo) AS val_rtl_rl_net_sfo,
        SUM(val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break,
        SUM(val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss,
        SUM(val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty,
        SUM(val_rtl_rl_sfo_py) AS val_rtl_rl_sfo_py,
        SUM(val_rtl_rl_net_sfo_py) AS val_rtl_rl_net_sfo_py,
        SUM(val_net_sfo_mhd_break_py) AS val_net_sfo_mhd_break_py,
        SUM(val_net_sfo_other_stc_loss_py) AS val_net_sfo_other_stc_loss_py,
        SUM(val_net_sfo_str_deliv_qlty_py) AS val_net_sfo_str_deliv_qlty_py,
        SUM(val_wrtoff_zero) AS val_wrtoff_zero,
        SUM(val_wrtoff_zero_net) AS val_wrtoff_zero_net,
        SUM(val_wrtoff_zero_net_mhd_break) AS val_wrtoff_zero_net_mhd_break,
        SUM(val_wrtoff_zero_net_other_stc_loss) AS val_wrtoff_zero_net_other_stc_loss,
        SUM(val_wrtoff_zero_net_str_deliv_qlty) AS val_wrtoff_zero_net_str_deliv_qlty,
        SUM(val_discount_ejr) AS val_discount_ejr,
        SUM(val_discount_net_ejr) AS val_discount_net_ejr,
        SUM(val_rtl_ejr_adj) AS val_rtl_ejr_adj,
        SUM(val_rtl_net_ejr_adj) AS val_rtl_net_ejr_adj,
        SUM(val_rtl_ejr_adj_py) AS val_rtl_ejr_adj_py,
        SUM(val_rtl_net_ejr_adj_py) AS val_rtl_net_ejr_adj_py,
        CAST(IFNULL(SUM(val_rtl_rl_sfo) / IF(SUM(val_rtl_ejr_adj) = 0, NULL, SUM(val_rtl_ejr_adj)), 0) AS BIGNUMERIC) AS
        sfo_to_val_retail_pct,
        CAST(IFNULL(SUM(val_rtl_rl_net_sfo) / IF(SUM(val_rtl_net_ejr_adj) = 0, NULL, SUM(val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
        AS sfo_to_val_retail_net_pct,
        CAST(IFNULL(SUM(val_rtl_net_sfo_mhd_break) / IF(SUM(val_rtl_net_ejr_adj) = 0, NULL, SUM(val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
        AS sfo_mhd_break_to_val_retail_net_pct,
        CAST(IFNULL(SUM(val_rtl_rl_sfo_py) / IF(SUM(val_rtl_ejr_adj_py) = 0, NULL, SUM(val_rtl_ejr_adj_py)), 0) AS BIGNUMERIC)
        AS sfo_to_val_retail_pct_py,
        CAST(IFNULL(SUM(val_rtl_rl_net_sfo_py) / IF(SUM(val_rtl_net_ejr_adj_py) = 0, NULL, SUM(val_rtl_net_ejr_adj_py)), 0) AS BIGNUMERIC)
        AS sfo_to_val_retail_net_pct_py
       FROM ldl_p_lew_mart_msi.t_bo_base_abs_1 AS BASE
       WHERE cy_week_seq BETWEEN - 17 AND (- 1)
        AND itemgroup_int_id >= 0
       GROUP BY client_id,
        store_id,
        wh_id,
        cy_week,
        hierarchie_id,
        currency_iso_cd,
        country_id,
        country_desc,
        country_iso_cd,
        orig_store_nr,
        store_desc,
        wh_desc,
        city,
        account_manager_id,
        account_manager_name,
        sales_manager_id,
        sales_manager_name
       UNION ALL
       SELECT 'TOTAL' AS target_type,
        4 AS target_type_id,
        client_id,
        store_id,
        cy_week,
        CAST(NULL AS BIGNUMERIC) AS hierarchie_id,
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
        SUM(val_rtl_rl_sfo) AS val_rtl_rl_sfo,
        SUM(val_rtl_rl_net_sfo) AS val_rtl_rl_net_sfo,
        SUM(val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break,
        SUM(val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss,
        SUM(val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty,
        SUM(val_rtl_rl_sfo_py) AS val_rtl_rl_sfo_py,
        SUM(val_rtl_rl_net_sfo_py) AS val_rtl_rl_net_sfo_py,
        SUM(val_net_sfo_mhd_break_py) AS val_net_sfo_mhd_break_py,
        SUM(val_net_sfo_other_stc_loss_py) AS val_net_sfo_other_stc_loss_py,
        SUM(val_net_sfo_str_deliv_qlty_py) AS val_net_sfo_str_deliv_qlty_py,
        SUM(val_wrtoff_zero) AS val_wrtoff_zero,
        SUM(val_wrtoff_zero_net) AS val_wrtoff_zero_net,
        SUM(val_wrtoff_zero_net_mhd_break) AS val_wrtoff_zero_net_mhd_break,
        SUM(val_wrtoff_zero_net_other_stc_loss) AS val_wrtoff_zero_net_other_stc_loss,
        SUM(val_wrtoff_zero_net_str_deliv_qlty) AS val_wrtoff_zero_net_str_deliv_qlty,
        SUM(val_discount_ejr) AS val_discount_ejr,
        SUM(val_discount_net_ejr) AS val_discount_net_ejr,
        SUM(val_rtl_ejr_adj) AS val_rtl_ejr_adj,
        SUM(val_rtl_net_ejr_adj) AS val_rtl_net_ejr_adj,
        SUM(val_rtl_ejr_adj_py) AS val_rtl_ejr_adj_py,
        SUM(val_rtl_net_ejr_adj_py) AS val_rtl_net_ejr_adj_py,
        CAST(IFNULL(SUM(val_rtl_rl_sfo) / IF(SUM(val_rtl_ejr_adj) = 0, NULL, SUM(val_rtl_ejr_adj)), 0) AS BIGNUMERIC) AS
        sfo_to_val_retail_pct,
        CAST(IFNULL(SUM(val_rtl_rl_net_sfo) / IF(SUM(val_rtl_net_ejr_adj) = 0, NULL, SUM(val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
        AS sfo_to_val_retail_net_pct,
        CAST(IFNULL(SUM(val_rtl_net_sfo_mhd_break) / IF(SUM(val_rtl_net_ejr_adj) = 0, NULL, SUM(val_rtl_net_ejr_adj)), 0) AS BIGNUMERIC)
        AS sfo_mhd_break_to_val_retail_net_pct,
        CAST(IFNULL(SUM(val_rtl_rl_sfo_py) / IF(SUM(val_rtl_ejr_adj_py) = 0, NULL, SUM(val_rtl_ejr_adj_py)), 0) AS BIGNUMERIC)
        AS sfo_to_val_retail_pct_py,
        CAST(IFNULL(SUM(val_rtl_rl_net_sfo_py) / IF(SUM(val_rtl_net_ejr_adj_py) = 0, NULL, SUM(val_rtl_net_ejr_adj_py)), 0) AS BIGNUMERIC)
        AS sfo_to_val_retail_net_pct_py
       FROM ldl_p_lew_mart_msi.t_bo_base_abs_1 AS BASE
       WHERE cy_week_seq BETWEEN - 17 AND (- 1)
       GROUP BY client_id,
        store_id,
        cy_week,
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
        sales_manager_name) AS lvl0
     LEFT JOIN (SELECT SALES.client_id,
       SALES.loc_sid_store,
       CAL.cy_week,
       SUM(SALES.val_retail) AS val_rtl_total,
       SUM(SALES.val_retail_net) AS val_rtl_net_total
      FROM ldl_p_lew_bil_ac.v_agg_sales_store_day_1 AS SALES_1
       INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON SALES.dat_formdate = CAL.cal_dt
      WHERE CAL.cy_week_seq BETWEEN - 17 AND (- 1)
      GROUP BY SALES.client_id,
       SALES.loc_sid_store,
       CAL.cy_week) AS ums ON lvl0.client_id = ums.client_id AND lvl0.store_id = ums.loc_sid_store AND lvl0.cy_week =
        ums.cy_week AND lvl0.target_type_id IN (1, 3)) AS lvl2) AS lvl3
 INNER JOIN ldl_p_lew_core_ac.v_cal_week_1 AS WEEKS_PER_PROMPT ON lvl3.cy_week = WEEKS_PER_PROMPT.cy_week
 INNER JOIN ldl_p_lew_core_ac.v_cal_week_1 AS PROMPT ON WEEKS_PER_PROMPT.cy_week_seq BETWEEN PROMPT.cy_week_seq - 12 AND (PROMPT
    .cy_week_seq - 1)
WHERE PROMPT.cy_week_seq BETWEEN - 4 AND 0;


