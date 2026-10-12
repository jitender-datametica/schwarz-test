
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS.
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_msi.v_bo_base_abs_mth_1
#----------------------------------------------------------------------------
# History:
#  1.0  19.06.2018    Arnold, Arne             Neuanlage
#  1.1  03.07.2018    Arnold,Arne              Umsatzquelle angepasst
#  1.2  09.07.2018    Arnold,Arne              Spaltendreher bei UNION ALL fuer TARGET_TYP_ID = 4 (Total) korrigiert
#  1.3  28.09.2018    Wandtke,Andrzej          20180925_1840_FBO_Provide_Filial_Abschriften_Part2 - Add columns related to specific types of writeoffs
#  1.4  16.11.2018    Michael Strauch          20181113_1882_Differ_writeoff_reasons_FBO_Rep1 - extended by some columns to differenziate the values by pcwo_resons
#  1.5  08.10.2020    Stephane Tonga           20201007_2609_WG_id_ext_Frischfisch - Extending the view with new WG-ids
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_BO_BASE_ABS_MTH_1 COMMENT = 'Monthly Basis Abschriften_1'
(
       target_type
     , target_type_id
     , client_id
     , store_id
     , subitemgroup_id
     , itemgroup_int_id
     , cy_month
     , week_page_by
     , currency_iso_cd
     , country_id
     , country_desc
     , country_iso_cd
     , orig_store_nr
     , store_desc
     , wh_id
     , wh_desc
     , city
     , account_manager_id
     , account_manager_name
     , sales_manager_id
     , sales_manager_name
     , val_rtl_rl_sfo
     , val_rtl_rl_net_sfo
     , val_rtl_net_sfo_mhd_break
     , val_rtl_net_sfo_other_stc_loss
     , val_rtl_net_sfo_str_deliv_qlty
     , val_rtl_rl_sfo_py
     , val_rtl_rl_net_sfo_py
     , val_net_sfo_mhd_break_py
     , val_net_sfo_other_stc_loss_py
     , val_net_sfo_str_deliv_qlty_py
     , val_wrtoff_zero
     , val_wrtoff_zero_net
     , val_wrtoff_zero_net_mhd_break
     , val_wrtoff_zero_net_other_stc_loss
     , val_wrtoff_zero_net_str_deliv_qlty
     , val_discount_ejr
     , val_discount_net_ejr
     , val_rtl_ejr_adj
     , val_rtl_net_ejr_adj
     , val_rtl_ejr_adj_py
     , val_rtl_net_ejr_adj_py
     , sfo_to_val_retail_pct
     , sfo_to_val_retail_net_pct
     , sfo_to_val_retail_pct_py
     , sfo_to_val_retail_net_pct_py
     , val_rtl_total
     , val_rtl_net_total
     , val_rtl_wgi_to_total_pct
     , val_rtl_net_wgi_to_net_tot_pct
     , top20_val_rtl_sfo_st_sfo_rel
     , top20_val_rtl_net_st_sfo_rel
     , top20_val_rtl_net_st_sfo_rel_mhd_brk
     , top20_val_rtl_ejr_adj_sfo_rel
     , top20_val_rtl_net_ejr_sfo_rel
     , top20_val_rtl_net_ejr_sfo_rel_mhd_brk
     , top20_val_rtl_total_rev
     , top20_val_rtl_net_total_rev
     , top20_val_rtl_pct_rev
     , top20_val_rtl_net_pct_rev
     , top20_sfo_to_val_retail_pct
     , top20_sfo_to_val_rtl_net_pct
     , top20_val_rtl_to_val_total_pct
     , top20_val_rtl_to_net_tot_pct
) 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT   lvl2.target_type
       , lvl2.target_type_id
       , lvl2.client_id
       , lvl2.store_id
       , CASE WHEN lvl2.target_type_id = 1
                  THEN lvl2.hierarchie_id
                  ELSE NULL
          END AS subitemgroup_id
       , CASE WHEN lvl2.target_type_id = 3
                  THEN lvl2.hierarchie_id
                  ELSE NULL
           END AS itemgroup_int_id
       , lvl2.cy_month
       , lvl2.week_page_by
       , lvl2.currency_iso_cd
       , lvl2.country_id
       , lvl2.country_desc
       , lvl2.country_iso_cd
       , lvl2.orig_store_nr
       , lvl2.store_desc
       , lvl2.wh_id
       , lvl2.wh_desc
       , lvl2.city
       , lvl2.account_manager_id
       , lvl2.account_manager_name
       , lvl2.sales_manager_id
       , lvl2.sales_manager_name
       , lvl2.val_rtl_rl_sfo
       , lvl2.val_rtl_rl_net_sfo
       , lvl2.val_rtl_net_sfo_mhd_break
       , lvl2.val_rtl_net_sfo_other_stc_loss
       , lvl2.val_rtl_net_sfo_str_deliv_qlty
       , lvl2.val_rtl_rl_sfo_py
       , lvl2.val_rtl_rl_net_sfo_py
       , lvl2.val_net_sfo_mhd_break_py
       , lvl2.val_net_sfo_other_stc_loss_py
       , lvl2.val_net_sfo_str_deliv_qlty_py
       , lvl2.val_wrtoff_zero
       , lvl2.val_wrtoff_zero_net
       , lvl2.val_wrtoff_zero_net_mhd_break
       , lvl2.val_wrtoff_zero_net_other_stc_loss
       , lvl2.val_wrtoff_zero_net_str_deliv_qlty
       , lvl2.val_discount_ejr
       , lvl2.val_discount_net_ejr
       , lvl2.val_rtl_ejr_adj
       , lvl2.val_rtl_net_ejr_adj
       , lvl2.val_rtl_ejr_adj_py
       , lvl2.val_rtl_net_ejr_adj_py
       , lvl2.sfo_to_val_retail_pct
       , lvl2.sfo_to_val_retail_net_pct
       , lvl2.sfo_to_val_retail_pct_py
       , lvl2.sfo_to_val_retail_net_pct_py
       , lvl2.val_rtl_total
       , lvl2.val_rtl_net_total
       , lvl2.val_rtl_wgi_to_total_pct
       , lvl2.val_rtl_net_wgi_to_net_tot_pct
       , SUM(CASE WHEN lvl2.rank_sfo_to_val_retail_pct <= 20                         THEN lvl2.val_rtl_rl_sfo            ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id) AS top20_val_rtl_sfo_st_sfo_rel
       , SUM(CASE WHEN lvl2.rank_sfo_to_val_retail_net_pct <= 20                     THEN lvl2.val_rtl_rl_net_sfo        ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id) AS top20_val_rtl_net_st_sfo_rel
       , SUM(CASE WHEN lvl2.rank_sfo_mhd_break_to_val_retail_net_pct <= 20           THEN lvl2.val_rtl_net_sfo_mhd_break ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id) AS top20_val_rtl_net_st_sfo_rel_mhd_brk
       , SUM(CASE WHEN lvl2.rank_sfo_to_val_retail_pct <= 20                         THEN lvl2.val_rtl_ejr_adj           ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id) AS top20_val_rtl_ejr_adj_sfo_rel
       , SUM(CASE WHEN lvl2.rank_sfo_to_val_retail_net_pct <= 20                     THEN lvl2.val_rtl_net_ejr_adj       ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id) AS top20_val_rtl_net_ejr_sfo_rel
       , SUM(CASE WHEN lvl2.rank_sfo_mhd_break_to_val_retail_net_pct <= 20           THEN lvl2.val_rtl_net_ejr_adj       ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id) AS top20_val_rtl_net_ejr_sfo_rel_mhd_brk
       , SUM(CASE WHEN lvl2.rank_val_rtl_wgi_to_total_pct <= 20                      THEN lvl2.val_rtl_total             ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id) AS top20_val_rtl_total_rev
       , SUM(CASE WHEN lvl2.rank_val_rtl_net_wgi_to_net_tot_pct <= 20                THEN lvl2.val_rtl_net_total         ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id) AS top20_val_rtl_net_total_rev
       , SUM(CASE WHEN lvl2.rank_val_rtl_wgi_to_total_pct <= 20                      THEN lvl2.val_rtl_ejr_adj           ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id) AS top20_val_rtl_pct_rev
       , SUM(CASE WHEN lvl2.rank_val_rtl_net_wgi_to_net_tot_pct <= 20                THEN lvl2.val_rtl_net_ejr_adj       ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id) AS top20_val_rtl_net_pct_rev
       /* top20_val_rtl_sfo_st_sfo_rel / top20_val_rtl_ejr_adj_sfo_rel         */      
       , SUM(CASE WHEN lvl2.rank_sfo_to_val_retail_pct <= 20                         THEN lvl2.val_rtl_rl_sfo            ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id)
           / NULLIFZERO(SUM(CASE WHEN lvl2.rank_sfo_to_val_retail_pct <= 20          THEN lvl2.val_rtl_ejr_adj           ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id))  * 100 AS top20_sfo_to_val_retail_pct
       /* top20_val_rtl_net_st_sfo_rel / top20_val_rtl_net_ejr_sfo_rel         */      
       , SUM(CASE WHEN lvl2.rank_sfo_to_val_retail_net_pct <= 20                     THEN lvl2.val_rtl_rl_net_sfo        ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id)
           / NULLIFZERO(SUM(CASE WHEN lvl2.rank_sfo_to_val_retail_net_pct <= 20      THEN lvl2.val_rtl_net_ejr_adj       ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id)) *  100 AS top20_sfo_to_val_rtl_net_pct
       /* top20_val_rtl_pct_rev / top20_val_rtl_total_rev                      */                                          
       , SUM(CASE WHEN lvl2.rank_val_rtl_wgi_to_total_pct <= 20                      THEN lvl2.val_rtl_ejr_adj           ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id)
           / NULLIFZERO(SUM(CASE WHEN lvl2.rank_val_rtl_wgi_to_total_pct <= 20       THEN lvl2.val_rtl_total             ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id)) * 100  AS top20_val_rtl_to_val_total_pct
       /* top20_val_rtl_net_pct_rev / top20_val_rtl_net_total_rev              */                                         
       , SUM(CASE WHEN lvl2.rank_val_rtl_net_wgi_to_net_tot_pct <= 20                THEN lvl2.val_rtl_net_ejr_adj       ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id)
           / NULLIFZERO(SUM(CASE WHEN lvl2.rank_val_rtl_net_wgi_to_net_tot_pct <= 20 THEN lvl2.val_rtl_net_total         ELSE 0 END) OVER (PARTITION BY lvl2.target_type, lvl2.target_type_id, lvl2.client_id, lvl2.wh_id, lvl2.cy_month, lvl2.week_page_by, lvl2.hierarchie_id)) * 100  AS top20_val_rtl_to_net_tot_pct
FROM ( 
    /* LVL1: Ranking durchführen */
    SELECT lvl1.target_type
        , lvl1.target_type_id
        , lvl1.client_id
        , lvl1.store_id
        , lvl1.hierarchie_id
        , lvl1.cy_month
        , lvl1.week_page_by
        , lvl1.currency_iso_cd
        , lvl1.country_id
        , lvl1.country_desc
        , lvl1.country_iso_cd
        , lvl1.orig_store_nr
        , lvl1.store_desc
        , lvl1.wh_id
        , lvl1.wh_desc
        , lvl1.city
        , lvl1.account_manager_id
        , lvl1.account_manager_name
        , lvl1.sales_manager_id
        , lvl1.sales_manager_name
        , lvl1.val_rtl_rl_sfo
        , lvl1.val_rtl_rl_net_sfo
        , lvl1.val_rtl_net_sfo_mhd_break
        , lvl1.val_rtl_net_sfo_other_stc_loss
        , lvl1.val_rtl_net_sfo_str_deliv_qlty
        , lvl1.val_rtl_rl_sfo_py
        , lvl1.val_rtl_rl_net_sfo_py
        , lvl1.val_net_sfo_mhd_break_py
        , lvl1.val_net_sfo_other_stc_loss_py
        , lvl1.val_net_sfo_str_deliv_qlty_py
        , lvl1.val_wrtoff_zero
        , lvl1.val_wrtoff_zero_net
        , lvl1.val_wrtoff_zero_net_mhd_break
        , lvl1.val_wrtoff_zero_net_other_stc_loss
        , lvl1.val_wrtoff_zero_net_str_deliv_qlty
        , lvl1.val_discount_ejr
        , lvl1.val_discount_net_ejr
        , lvl1.val_rtl_ejr_adj
        , lvl1.val_rtl_net_ejr_adj
        , lvl1.val_rtl_ejr_adj_py
        , lvl1.val_rtl_net_ejr_adj_py
        , lvl1.sfo_to_val_retail_pct
        , lvl1.sfo_to_val_retail_net_pct
        , lvl1.sfo_mhd_break_to_val_retail_net_pct
        , lvl1.sfo_to_val_retail_pct_py
        , lvl1.sfo_to_val_retail_net_pct_py
        , lvl1.val_rtl_total
        , lvl1.val_rtl_net_total
        , lvl1.val_rtl_wgi_to_total_pct
        , lvl1.val_rtl_net_wgi_to_net_tot_pct
        , ROW_NUMBER() OVER (
            PARTITION BY lvl1.target_type, lvl1.target_type_id, lvl1.client_id, lvl1.wh_id, lvl1.cy_month, lvl1.week_page_by, lvl1.hierarchie_id
            ORDER BY CASE WHEN lvl1.val_rtl_ejr_adj > 0 THEN lvl1.sfo_to_val_retail_pct ELSE -999999999 END DESC
                , lvl1.val_rtl_rl_sfo ASC
                , lvl1.store_id ASC
                            )                                  AS rank_sfo_to_val_retail_pct
        , ROW_NUMBER() OVER (
            PARTITION BY lvl1.target_type, lvl1.target_type_id, lvl1.client_id, lvl1.wh_id, lvl1.cy_month, lvl1.week_page_by, lvl1.hierarchie_id
            ORDER BY CASE WHEN lvl1.val_rtl_net_ejr_adj > 0 THEN lvl1.sfo_to_val_retail_net_pct ELSE -999999999 END DESC
                , lvl1.val_rtl_rl_net_sfo ASC
                , lvl1.store_id ASC
                            )                                  AS rank_sfo_to_val_retail_net_pct
        , ROW_NUMBER() OVER (
            PARTITION BY lvl1.target_type, lvl1.target_type_id, lvl1.client_id, lvl1.wh_id, lvl1.cy_month, lvl1.week_page_by, lvl1.hierarchie_id
            ORDER BY CASE WHEN lvl1.val_rtl_net_ejr_adj > 0 THEN lvl1.sfo_mhd_break_to_val_retail_net_pct ELSE -999999999 END DESC
                , lvl1.val_rtl_net_sfo_mhd_break ASC
                , lvl1.store_id ASC
                            )                                  AS rank_sfo_mhd_break_to_val_retail_net_pct
        , ROW_NUMBER () OVER(
              PARTITION BY lvl1.target_type, lvl1.target_type_id, lvl1.client_id, lvl1.wh_id, lvl1.cy_month, lvl1.week_page_by, lvl1.hierarchie_id
              ORDER BY lvl1.val_rtl_wgi_to_total_pct DESC
                  , lvl1.store_id ASC
                            )                                  AS rank_val_rtl_wgi_to_total_pct
        , ROW_NUMBER () OVER(
              PARTITION BY lvl1.target_type, lvl1.target_type_id, lvl1.client_id, lvl1.wh_id, lvl1.cy_month, lvl1.week_page_by, lvl1.hierarchie_id
              ORDER BY lvl1.val_rtl_net_wgi_to_net_tot_pct DESC
                  , lvl1.store_id
                            )                                  AS rank_val_rtl_net_wgi_to_net_tot_pct
    FROM (
        /* LVL0 */
        SELECT   lvl0.target_type
               , lvl0.target_type_id
               , lvl0.client_id
               , lvl0.store_id
               , lvl0.hierarchie_id
               , lvl0.cy_month
               , lvl0.week_page_by
               , lvl0.currency_iso_cd
               , lvl0.country_id
               , lvl0.country_desc
               , lvl0.country_iso_cd
               , lvl0.orig_store_nr
               , lvl0.store_desc
               , lvl0.wh_id
               , lvl0.wh_desc
               , lvl0.city
               , lvl0.account_manager_id
               , lvl0.account_manager_name
               , lvl0.sales_manager_id
               , lvl0.sales_manager_name
               , lvl0.val_rtl_rl_sfo
               , lvl0.val_rtl_rl_net_sfo
               , lvl0.val_rtl_net_sfo_mhd_break
               , lvl0.val_rtl_net_sfo_other_stc_loss
               , lvl0.val_rtl_net_sfo_str_deliv_qlty
               , lvl0.val_rtl_rl_sfo_py
               , lvl0.val_rtl_rl_net_sfo_py
               , lvl0.val_net_sfo_mhd_break_py
               , lvl0.val_net_sfo_other_stc_loss_py
               , lvl0.val_net_sfo_str_deliv_qlty_py
               , lvl0.val_wrtoff_zero
               , lvl0.val_wrtoff_zero_net
               , lvl0.val_wrtoff_zero_net_mhd_break
               , lvl0.val_wrtoff_zero_net_other_stc_loss
               , lvl0.val_wrtoff_zero_net_str_deliv_qlty
               , lvl0.val_discount_ejr
               , lvl0.val_discount_net_ejr
               , lvl0.val_rtl_ejr_adj
               , lvl0.val_rtl_net_ejr_adj
               , lvl0.val_rtl_ejr_adj_py
               , lvl0.val_rtl_net_ejr_adj_py
               , lvl0.sfo_to_val_retail_pct
               , lvl0.sfo_to_val_retail_net_pct
               , lvl0.sfo_mhd_break_to_val_retail_net_pct
               , lvl0.sfo_to_val_retail_pct_py
               , lvl0.sfo_to_val_retail_net_pct_py
               /* Umsätze verdichtet auf Store-Ebene bestimmen */
               , ums.val_rtl_total
               , ums.val_rtl_net_total
               , CAST(ZEROIFNULL(lvl0.val_rtl_ejr_adj     / NULLIFZERO(ums.val_rtl_total)     * 100.0) AS DECIMAL(36,10)) AS val_rtl_wgi_to_total_pct
               , CAST(ZEROIFNULL(lvl0.val_rtl_net_ejr_adj / NULLIFZERO(ums.val_rtl_net_total) * 100.0) AS DECIMAL(36,10)) AS val_rtl_net_wgi_to_net_tot_pct
        FROM (
            /* SIG-Ebene  */
            SELECT CAST('SIG' AS VARCHAR(9)) AS target_type
                , CAST(1 AS SMALLINT) AS target_type_id
                , base.client_id
                , base.store_id
                , base.subitemgroup_id AS hierarchie_id
                , base.cy_month
                , cal.cy_week AS week_page_by
                , base.currency_iso_cd
                , base.country_id
                , base.country_desc
                , base.country_iso_cd
                , base.orig_store_nr
                , base.store_desc
                , base.wh_id
                , base.wh_desc
                , base.city
                , base.account_manager_id
                , base.account_manager_name
                , base.sales_manager_id
                , base.sales_manager_name
                , SUM(ZEROIFNULL(base.val_rtl_rl_sfo)) AS val_rtl_rl_sfo
                , SUM(ZEROIFNULL(base.val_rtl_rl_net_sfo)) AS val_rtl_rl_net_sfo
                , SUM(ZEROIFNULL(base.val_rtl_net_sfo_mhd_break)) AS val_rtl_net_sfo_mhd_break
                , SUM(ZEROIFNULL(base.val_rtl_net_sfo_other_stc_loss)) AS val_rtl_net_sfo_other_stc_loss
                , SUM(ZEROIFNULL(base.val_rtl_net_sfo_str_deliv_qlty)) AS val_rtl_net_sfo_str_deliv_qlty
                , SUM(ZEROIFNULL(base.val_rtl_rl_sfo_py)) AS val_rtl_rl_sfo_py
                , SUM(ZEROIFNULL(base.val_rtl_rl_net_sfo_py)) AS val_rtl_rl_net_sfo_py
                , SUM(ZEROIFNULL(base.val_net_sfo_mhd_break_py)) AS val_net_sfo_mhd_break_py
                , SUM(ZEROIFNULL(base.val_net_sfo_other_stc_loss_py)) AS val_net_sfo_other_stc_loss_py
                , SUM(ZEROIFNULL(base.val_net_sfo_str_deliv_qlty_py)) AS val_net_sfo_str_deliv_qlty_py
                , SUM(ZEROIFNULL(base.val_wrtoff_zero)) AS val_wrtoff_zero
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net)) AS val_wrtoff_zero_net
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net_mhd_break)) AS val_wrtoff_zero_net_mhd_break
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net_other_stc_loss)) AS val_wrtoff_zero_net_other_stc_loss
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net_str_deliv_qlty)) AS val_wrtoff_zero_net_str_deliv_qlty
                , SUM(ZEROIFNULL(base.val_discount_ejr)) AS val_discount_ejr
                , SUM(ZEROIFNULL(base.val_discount_net_ejr)) AS val_discount_net_ejr
                , SUM(ZEROIFNULL(base.val_rtl_ejr_adj)) AS val_rtl_ejr_adj
                , SUM(ZEROIFNULL(base.val_rtl_net_ejr_adj)) AS val_rtl_net_ejr_adj
                , SUM(ZEROIFNULL(base.val_rtl_ejr_adj_py)) AS val_rtl_ejr_adj_py
                , SUM(ZEROIFNULL(base.val_rtl_net_ejr_adj_py)) AS val_rtl_net_ejr_adj_py
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_sfo) / NULLIFZERO(SUM(base.val_rtl_ejr_adj))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_pct
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_net_sfo) / NULLIFZERO(SUM(base.val_rtl_net_ejr_adj))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_net_pct
                , CAST(ZEROIFNULL(SUM(base.val_rtl_net_sfo_mhd_break) / NULLIFZERO(SUM(base.val_rtl_net_ejr_adj))) AS DECIMAL(36, 10)) AS sfo_mhd_break_to_val_retail_net_pct
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_sfo_py) / NULLIFZERO(SUM(base.val_rtl_ejr_adj_py))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_pct_py
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_net_sfo_py) / NULLIFZERO(SUM(base.val_rtl_net_ejr_adj_py))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_net_pct_py
            FROM P_LEW_MART_MSI.t_bo_base_abs_1 AS base
                /* Fünf Wochenprompts mit deren Zeitbereich bestimmen */
                INNER JOIN (
                    SELECT cal.cy_week
                        , TO_DATE(CAST(MIN(mth.cy_month) AS CHAR(6)) || '01', 'YYYYMMDD') AS date_from /* Startzeitpunkt ist immer der 1. Tag_1 eines Geschäftsjahres */
                        , cal.cal_dt + 6 AS date_to                                                               /* Endzeitpunkt ist immer der Wochendtag */
                    FROM P_LEW_CORE_AC.v_cal_calendarday_1   AS cal
                   INNER JOIN P_LEW_CORE_AC.v_cal_month_1    AS mth
                      ON cal.busyear   = mth.busyear
                     AND cal.cy_month >= mth.cy_month
                   WHERE cal.cy_week_seq BETWEEN -4 AND 0
                     AND cal.day_of_week = 1
                   GROUP BY cal.cy_week
                        , cal.cal_dt
                ) AS cal
                    ON base.dat_formdate BETWEEN cal.date_from AND cal.date_to
            WHERE base.itemgroup_int_id IN (9,90)                                             /* Frischbrot / Hot Convenience */
            GROUP BY base.client_id
                , base.store_id
                , base.subitemgroup_id
                , base.wh_id
                , base.cy_month
                , cal.cy_week
                , base.currency_iso_cd
                , base.country_id
                , base.country_desc
                , base.country_iso_cd
                , base.orig_store_nr
                , base.store_desc
                , base.wh_id
                , base.wh_desc
                , base.city
                , base.account_manager_id
                , base.account_manager_name
                , base.sales_manager_id
                , base.sales_manager_name
            UNION ALL
            /* TOTAL_SIG  */
            SELECT CAST('TOTAL_SIG' AS VARCHAR(9)) AS target_type
                , CAST(2 AS SMALLINT) AS target_type_id
                , base.client_id
                , base.store_id
                , CAST(NULL AS INTEGER) AS hierarchie_id
                , base.cy_month
                , cal.cy_week AS week_page_by
                , base.currency_iso_cd
                , base.country_id
                , base.country_desc
                , base.country_iso_cd
                , base.orig_store_nr
                , base.store_desc
                , base.wh_id
                , base.wh_desc
                , base.city
                , base.account_manager_id
                , base.account_manager_name
                , base.sales_manager_id
                , base.sales_manager_name
                , SUM(ZEROIFNULL(base.val_rtl_rl_sfo)) AS val_rtl_rl_sfo
                , SUM(ZEROIFNULL(base.val_rtl_rl_net_sfo)) AS val_rtl_rl_net_sfo
                , SUM(ZEROIFNULL(base.val_rtl_net_sfo_mhd_break)) AS val_rtl_net_sfo_mhd_break
                , SUM(ZEROIFNULL(base.val_rtl_net_sfo_other_stc_loss)) AS val_rtl_net_sfo_other_stc_loss
                , SUM(ZEROIFNULL(base.val_rtl_net_sfo_str_deliv_qlty)) AS val_rtl_net_sfo_str_deliv_qlty
                , SUM(ZEROIFNULL(base.val_rtl_rl_sfo_py)) AS val_rtl_rl_sfo_py
                , SUM(ZEROIFNULL(base.val_rtl_rl_net_sfo_py)) AS val_rtl_rl_net_sfo_py
                , SUM(ZEROIFNULL(base.val_net_sfo_mhd_break_py)) AS val_net_sfo_mhd_break_py
                , SUM(ZEROIFNULL(base.val_net_sfo_other_stc_loss_py)) AS val_net_sfo_other_stc_loss_py
                , SUM(ZEROIFNULL(base.val_net_sfo_str_deliv_qlty_py)) AS val_net_sfo_str_deliv_qlty_py
                , SUM(ZEROIFNULL(base.val_wrtoff_zero)) AS val_wrtoff_zero
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net)) AS val_wrtoff_zero_net
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net_mhd_break)) AS val_wrtoff_zero_net_mhd_break
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net_other_stc_loss)) AS val_wrtoff_zero_net_other_stc_loss
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net_str_deliv_qlty)) AS val_wrtoff_zero_net_str_deliv_qlty
                , SUM(ZEROIFNULL(base.val_discount_ejr)) AS val_discount_ejr
                , SUM(ZEROIFNULL(base.val_discount_net_ejr)) AS val_discount_net_ejr
                , SUM(ZEROIFNULL(base.val_rtl_ejr_adj)) AS val_rtl_ejr_adj
                , SUM(ZEROIFNULL(base.val_rtl_net_ejr_adj)) AS val_rtl_net_ejr_adj
                , SUM(ZEROIFNULL(base.val_rtl_ejr_adj_py)) AS val_rtl_ejr_adj_py
                , SUM(ZEROIFNULL(base.val_rtl_net_ejr_adj_py)) AS val_rtl_net_ejr_adj_py
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_sfo) / NULLIFZERO(SUM(base.val_rtl_ejr_adj))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_pct
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_net_sfo) / NULLIFZERO(SUM(base.val_rtl_net_ejr_adj))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_net_pct
                , CAST(ZEROIFNULL(SUM(base.val_rtl_net_sfo_mhd_break) / NULLIFZERO(SUM(base.val_rtl_net_ejr_adj))) AS DECIMAL(36, 10)) AS sfo_mhd_break_to_val_retail_net_pct
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_sfo_py) / NULLIFZERO(SUM(base.val_rtl_ejr_adj_py))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_pct_py
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_net_sfo_py) / NULLIFZERO(SUM(base.val_rtl_net_ejr_adj_py))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_net_pct_py
            FROM P_LEW_MART_MSI.t_bo_base_abs_1 AS base
                /* Fünf Wochenprompts mit deren Zeitbereich bestimmen  */
                INNER JOIN (
                    SELECT cal.cy_week
                        , TO_DATE(CAST(MIN(mth.cy_month) AS CHAR(6)) || '01', 'YYYYMMDD') AS date_from /* Startzeitpunkt ist immer der 1. Tag_1 eines Geschäftsjahres */
                        , cal.cal_dt + 6 AS date_to                                                               /* Endzeitpunkt ist immer der Wochendtag */
                    FROM P_LEW_CORE_AC.v_cal_calendarday_1 AS cal
                   INNER JOIN P_LEW_CORE_AC.v_cal_month_1  AS mth
                      ON cal.busyear = mth.busyear
                     AND cal.cy_month >= mth.cy_month
                   WHERE cal.cy_week_seq BETWEEN -4 AND 0
                     AND cal.day_of_week = 1
                   GROUP BY cal.cy_week
                        , cal.cal_dt
                ) AS cal
                    ON base.dat_formdate BETWEEN cal.date_from AND cal.date_to
            WHERE base.itemgroup_int_id IN(9,90) /* Frischbrot / Hot Convenience  */
            GROUP BY base.client_id
                , base.store_id
                , base.cy_month
                , cal.cy_week
                , base.currency_iso_cd
                , base.country_id
                , base.country_desc
                , base.country_iso_cd
                , base.orig_store_nr
                , base.store_desc
                , base.wh_id
                , base.wh_desc
                , base.city
                , base.account_manager_id
                , base.account_manager_name
                , base.sales_manager_id
                , base.sales_manager_name
            UNION ALL
            /* WGI */
            SELECT CAST('WGI' AS VARCHAR(9)) AS target_type
                , CAST(3 AS SMALLINT) AS target_type_id
                , base.client_id
                , base.store_id
                , base.itemgroup_int_id AS hierarchie_id
                , base.cy_month
                , cal.cy_week AS week_page_by
                , base.currency_iso_cd
                , base.country_id
                , base.country_desc
                , base.country_iso_cd
                , base.orig_store_nr
                , base.store_desc
                , base.wh_id
                , base.wh_desc
                , base.city
                , base.account_manager_id
                , base.account_manager_name
                , base.sales_manager_id
                , base.sales_manager_name
                , SUM(ZEROIFNULL(base.val_rtl_rl_sfo)) AS val_rtl_rl_sfo
                , SUM(ZEROIFNULL(base.val_rtl_rl_net_sfo)) AS val_rtl_rl_net_sfo
                , SUM(ZEROIFNULL(base.val_rtl_net_sfo_mhd_break)) AS val_rtl_net_sfo_mhd_break
                , SUM(ZEROIFNULL(base.val_rtl_net_sfo_other_stc_loss)) AS val_rtl_net_sfo_other_stc_loss
                , SUM(ZEROIFNULL(base.val_rtl_net_sfo_str_deliv_qlty)) AS val_rtl_net_sfo_str_deliv_qlty
                , SUM(ZEROIFNULL(base.val_rtl_rl_sfo_py)) AS val_rtl_rl_sfo_py
                , SUM(ZEROIFNULL(base.val_rtl_rl_net_sfo_py)) AS val_rtl_rl_net_sfo_py
                , SUM(ZEROIFNULL(base.val_net_sfo_mhd_break_py)) AS val_net_sfo_mhd_break_py
                , SUM(ZEROIFNULL(base.val_net_sfo_other_stc_loss_py)) AS val_net_sfo_other_stc_loss_py
                , SUM(ZEROIFNULL(base.val_net_sfo_str_deliv_qlty_py)) AS val_net_sfo_str_deliv_qlty_py
                , SUM(ZEROIFNULL(base.val_wrtoff_zero)) AS val_wrtoff_zero
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net)) AS val_wrtoff_zero_net
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net_mhd_break)) AS val_wrtoff_zero_net_mhd_break
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net_other_stc_loss)) AS val_wrtoff_zero_net_other_stc_loss
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net_str_deliv_qlty)) AS val_wrtoff_zero_net_str_deliv_qlty
                /* Unterscheidung nach WGI entfernt */
                , SUM(ZEROIFNULL(base.val_discount_ejr)) AS val_discount_ejr
                , SUM(ZEROIFNULL(base.val_discount_net_ejr)) AS val_discount_net_ejr
                , SUM(ZEROIFNULL(base.val_rtl_ejr_adj)) AS val_rtl_ejr_adj
                , SUM(ZEROIFNULL(base.val_rtl_net_ejr_adj)) AS val_rtl_net_ejr_adj
                , SUM(ZEROIFNULL(base.val_rtl_ejr_adj_py)) AS val_rtl_ejr_adj_py
                , SUM(ZEROIFNULL(base.val_rtl_net_ejr_adj_py)) AS val_rtl_net_ejr_adj_py
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_sfo) / NULLIFZERO(SUM(base.val_rtl_ejr_adj))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_pct
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_net_sfo) / NULLIFZERO(SUM(base.val_rtl_net_ejr_adj))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_net_pct
                , CAST(ZEROIFNULL(SUM(base.val_rtl_net_sfo_mhd_break) / NULLIFZERO(SUM(base.val_rtl_net_ejr_adj))) AS DECIMAL(36, 10)) AS sfo_mhd_break_to_val_retail_net_pct
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_sfo_py) / NULLIFZERO(SUM(base.val_rtl_ejr_adj_py))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_pct_py
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_net_sfo_py) / NULLIFZERO(SUM(base.val_rtl_net_ejr_adj_py))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_net_pct_py
            FROM P_LEW_MART_MSI.t_bo_base_abs_1 AS base
                /* Fünf Wochenprompts mit deren Zeitbereich bestimmen */
                INNER JOIN (
                    SELECT cal.cy_week
                        , TO_DATE(CAST(MIN(mth.cy_month) AS CHAR(6)) || '01', 'YYYYMMDD') AS date_from /* Startzeitpunkt ist immer der 1. Tag_1 eines Geschäftsjahres */
                        , cal.cal_dt + 6 AS date_to                                                               /* Endzeitpunkt ist immer der Wochendtag */
                    FROM P_LEW_CORE_AC.v_cal_calendarday_1 AS cal
                   INNER JOIN P_LEW_CORE_AC.v_cal_month_1  AS mth
                      ON cal.busyear = mth.busyear
                     AND cal.cy_month >= mth.cy_month
                   WHERE cal.cy_week_seq BETWEEN -4 AND 0
                     AND cal.day_of_week = 1
                   GROUP BY cal.cy_week
                        , cal.cal_dt
                ) AS cal
                    ON base.dat_formdate BETWEEN cal.date_from AND cal.date_to
            /* Keine Dummy_1 WGIs anzeigen. In der alten Version wurden hierzu alle Sätze mit einer SIG < -2 ausgeschlosen, dies hat nur WGIs < 0 betroffen.
               Ansonsten werden nur Sätze mit WGI >= 0 selektiert, weshalb auch eine_1 Umschlüsselung negativer WGIs auf 0 unnötig ist. */
            WHERE base.itemgroup_int_id >= 0
            GROUP BY base.client_id
                , base.store_id
                , base.itemgroup_int_id
                , base.wh_id
                , base.cy_month
                , cal.cy_week
                , base.currency_iso_cd
                , base.country_id
                , base.country_desc
                , base.country_iso_cd
                , base.orig_store_nr
                , base.store_desc
                , base.wh_id
                , base.wh_desc
                , base.city
                , base.account_manager_id
                , base.account_manager_name
                , base.sales_manager_id
                , base.sales_manager_name
            UNION ALL
            /* TOTAL  */
            SELECT CAST('TOTAL' AS VARCHAR(9)) AS target_type
                , CAST(4 AS SMALLINT) AS target_type_id
                , base.client_id
                , base.store_id
                , CAST(NULL AS INTEGER) AS hierarchie_id
                , base.cy_month
                , cal.cy_week AS week_page_by
                , base.currency_iso_cd
                , base.country_id
                , base.country_desc
                , base.country_iso_cd
                , base.orig_store_nr
                , base.store_desc
                , base.wh_id
                , base.wh_desc
                , base.city
                , base.account_manager_id
                , base.account_manager_name
                , base.sales_manager_id
                , base.sales_manager_name
                , SUM(ZEROIFNULL(base.val_rtl_rl_sfo)) AS val_rtl_rl_sfo
                , SUM(ZEROIFNULL(base.val_rtl_rl_net_sfo)) AS val_rtl_rl_net_sfo
                , SUM(ZEROIFNULL(base.val_rtl_net_sfo_mhd_break)) AS val_rtl_net_sfo_mhd_break
                , SUM(ZEROIFNULL(base.val_rtl_net_sfo_other_stc_loss)) AS val_rtl_net_sfo_other_stc_loss
                , SUM(ZEROIFNULL(base.val_rtl_net_sfo_str_deliv_qlty)) AS val_rtl_net_sfo_str_deliv_qlty
                , SUM(ZEROIFNULL(base.val_rtl_rl_sfo_py)) AS val_rtl_rl_sfo_py
                , SUM(ZEROIFNULL(base.val_rtl_rl_net_sfo_py)) AS val_rtl_rl_net_sfo_py
                , SUM(ZEROIFNULL(base.val_net_sfo_mhd_break_py)) AS val_net_sfo_mhd_break_py
                , SUM(ZEROIFNULL(base.val_net_sfo_other_stc_loss_py)) AS val_net_sfo_other_stc_loss_py
                , SUM(ZEROIFNULL(base.val_net_sfo_str_deliv_qlty_py)) AS val_net_sfo_str_deliv_qlty_py
                , SUM(ZEROIFNULL(base.val_wrtoff_zero)) AS val_wrtoff_zero
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net)) AS val_wrtoff_zero_net
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net_mhd_break)) AS val_wrtoff_zero_net_mhd_break
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net_other_stc_loss)) AS val_wrtoff_zero_net_other_stc_loss
                , SUM(ZEROIFNULL(base.val_wrtoff_zero_net_str_deliv_qlty)) AS val_wrtoff_zero_net_str_deliv_qlty
                /* Unterscheidung nach ITEMGROUP_INT_ID für VAL_DISCOUNT_EJR und VAL_DISCOUNT_NET_EJR entfernt, da dies bei den anderen TARGET_TYPEs auch nicht erfolgt und die Logik nicht nachvollziehbar ist. */
                , SUM(ZEROIFNULL(base.val_discount_ejr)) AS val_discount_ejr
                , SUM(ZEROIFNULL(base.val_discount_net_ejr)) AS val_discount_net_sfo
                , SUM(ZEROIFNULL(base.val_rtl_ejr_adj)) AS val_rtl_ejr_adj
                , SUM(ZEROIFNULL(base.val_rtl_net_ejr_adj)) AS val_rtl_net_ejr_adj
                , SUM(ZEROIFNULL(base.val_rtl_ejr_adj_py)) AS val_rtl_ejr_adj_py
                , SUM(ZEROIFNULL(base.val_rtl_net_ejr_adj_py)) AS val_rtl_net_ejr_adj_py
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_sfo) / NULLIFZERO(SUM(base.val_rtl_ejr_adj))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_pct
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_net_sfo) / NULLIFZERO(SUM(base.val_rtl_net_ejr_adj))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_net_pct
                , CAST(ZEROIFNULL(SUM(base.val_rtl_net_sfo_mhd_break) / NULLIFZERO(SUM(base.val_rtl_net_ejr_adj))) AS DECIMAL(36, 10)) AS sfo_mhd_break_to_val_retail_net_pct
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_sfo_py) / NULLIFZERO(SUM(base.val_rtl_ejr_adj_py))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_pct_py
                , CAST(ZEROIFNULL(SUM(base.val_rtl_rl_net_sfo_py) / NULLIFZERO(SUM(base.val_rtl_net_ejr_adj_py))) AS DECIMAL(36, 10)) AS sfo_to_val_retail_net_pct_py
            FROM P_LEW_MART_MSI.t_bo_base_abs_1 AS base
                /* Fünf Wochenprompts mit deren Zeitbereich bestimmen */
                INNER JOIN (
                    SELECT cal.cy_week
                        , TO_DATE(CAST(MIN(mth.cy_month) AS CHAR(6)) || '01', 'YYYYMMDD') AS date_from /* Startzeitpunkt ist immer der 1. Tag_1 eines Geschäftsjahres  */
                        , cal.cal_dt + 6 AS date_to                                                               /* Endzeitpunkt ist immer der Wochendtag */
                    FROM P_LEW_CORE_AC.v_cal_calendarday_1 AS cal
                   INNER JOIN P_LEW_CORE_AC.v_cal_month_1  AS mth
                      ON cal.busyear = mth.busyear
                     AND cal.cy_month >= mth.cy_month
                   WHERE cal.cy_week_seq BETWEEN -4 AND 0
                     AND cal.day_of_week = 1
                   GROUP BY cal.cy_week
                        , cal.cal_dt
                ) AS cal
                    ON base.dat_formdate BETWEEN cal.date_from AND cal.date_to
            GROUP BY base.client_id
                , base.store_id
                , base.wh_id
                , base.cy_month
                , cal.cy_week
                , base.currency_iso_cd
                , base.country_id
                , base.country_desc
                , base.country_iso_cd
                , base.orig_store_nr
                , base.store_desc
                , base.wh_id
                , base.wh_desc
                , base.city
                , base.account_manager_id
                , base.account_manager_name
                , base.sales_manager_id
                , base.sales_manager_name
        ) AS lvl0
            /* Umsätze über alle Store-Daten für den Zeitraum bestimmen  */
            LEFT OUTER JOIN (
                SELECT sales.client_id
                    , sales.loc_sid_store
                    , sales.cy_month
                    , cal.cy_week AS week_page_by
                    , SUM(sales.val_retail) AS val_rtl_total
                    , SUM(sales.val_retail_net) AS val_rtl_net_total
                 FROM P_LEW_BIL_AC.v_agg_sales_store_day_1 AS sales_1
                    /* Fünf Wochenprompts mit deren Zeitbereich bestimmen  */
                INNER JOIN (
                            SELECT cal.cy_week
                                , TO_DATE(CAST(MIN(mth.cy_month) AS CHAR(6)) || '01', 'YYYYMMDD') AS date_from /* Startzeitpunkt ist immer der 1. Tag_1 eines Geschäftsjahres */
                                , cal.cal_dt + 6 AS date_to                                                               /* Endzeitpunkt ist immer der Wochendtag  */
                            FROM P_LEW_CORE_AC.v_cal_calendarday_1 AS cal
                           INNER JOIN P_LEW_CORE_AC.v_cal_month_1 AS mth
                              ON cal.busyear = mth.busyear
                             AND cal.cy_month >= mth.cy_month
                           WHERE cal.cy_week_seq BETWEEN -4 AND 0
                             AND cal.day_of_week = 1
                           GROUP BY cal.cy_week
                                , cal.cal_dt
                            ) AS cal
                   ON sales.dat_formdate BETWEEN cal.date_from AND cal.date_to
                GROUP BY sales.client_id
                    , sales.loc_sid_store
                    , sales.cy_month
                    , cal.cy_week
            ) AS ums
                 ON lvl0.client_id    = ums.client_id
                AND lvl0.store_id     = ums.loc_sid_store
                AND lvl0.cy_month     = ums.cy_month
                AND lvl0.week_page_by = ums.week_page_by
                AND lvl0.target_type_id IN (1, 3)
    ) AS lvl1
) AS lvl2
;
