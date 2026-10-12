
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_WH_DAY_SIG_DEL_ASIS_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
DescStart
$Revision: 9083 $, $LastChangedBy: aarnold $
SubjectAreas: Anliefermenge
DescEnd
2022-07-08 Martin Murtenthaler AP0138467 IT + INT-B-106 + MIS Web + Anliefermenge Malta in MSB Incident 4931547 Maltastores excluded from Italy
*/
SELECT
  aji.client_id
 ,wh.src_wh_id                                      AS wh_id
 ,aji.aspect_id                                     AS aspect_id
 ,CAST(s.src_subitemgrp_cd AS INTEGER)              AS subitemgroup_id
 ,aji.dat_formdate
 ,aji.cy_month
 ,aji.deliverytype_id
 ,b.curr_cd_from                                    AS currency_iso_cd
 ,aji.qty_total_del_asis
 ,aji.val_rtl_rl_del_asis / b.exchange_rate         AS val_rtl_rl_del_asis
 ,aji.val_rtl_rl_net_del_asis / b.exchange_rate     AS val_rtl_rl_net_del_asis
 ,aji.qty_piece_del_asis                            AS qty_piece_del_asis
 ,aji.val_piece_del_asis / b.exchange_rate          AS val_piece_del_asis
 ,aji.val_piece_net_del_asis / b.exchange_rate     AS val_piece_net_del_asis
 ,aji.val_pr_diff_del_asis / b.exchange_rate        AS val_pr_diff_del_asis
 ,aji.val_pr_diff_net_del_asis / b.exchange_rate    AS val_pr_diff_net_del_asis
 ,aji.qty_total_fa_del_asis
 ,aji.val_rtl_rl_fa_del_asis / b.exchange_rate      AS val_rtl_rl_fa_del_asis
 ,aji.val_rtl_rl_net_fa_del_asis / b.exchange_rate  AS val_rtl_rl_net_fa_del_asis
 ,aji.qty_piece_fa_del_asis
 ,aji.val_piece_fa_del_asis / b.exchange_rate       AS val_piece_fa_del_asis
 ,aji.val_piece_net_fa_del_asis / b.exchange_rate   AS val_piece_net_fa_del_asis
 ,aji.val_pr_diff_fa_del_asis / b.exchange_rate     AS val_pr_diff_fa_del_asis
 ,aji.val_pr_diff_net_fa_del_asis / b.exchange_rate AS val_pr_diff_net_fa_del_asis
FROM
(
  SELECT
    client_id
   ,loc_sid_wh_aspect1_asis  AS loc_sid_wh
   ,MAX(1)                   AS aspect_id
   ,sub_item_grp_sid_asis
   ,dat_formdate
   ,cy_month
   ,deliverytype_id
   ,SUM(qty_total_del)       AS qty_total_del_asis
   ,SUM(val_rtl_rl_del)      AS val_rtl_rl_del_asis
   ,SUM(val_rtl_rl_net_del)  AS val_rtl_rl_net_del_asis
   ,SUM(qty_piece_del_agg)   AS qty_piece_del_asis
   ,SUM(val_piece_del)       AS val_piece_del_asis
   ,SUM(val_piece_net_del)   AS val_piece_net_del_asis
   ,SUM(val_pr_diff_del)     AS val_pr_diff_del_asis
   ,SUM(val_pr_diff_net_del) AS val_pr_diff_net_del_asis
   ,SUM(
         CASE WHEN foodaction_fg = 1 AND qty_total_del       IS NOT NULL THEN qty_total_del
              WHEN src_fg = 1                                            THEN 0
              ELSE                                                            NULL
         END
       ) AS qty_total_fa_del_asis
   ,SUM(
         CASE WHEN foodaction_fg = 1 AND val_rtl_rl_del      IS NOT NULL THEN val_rtl_rl_del
              WHEN src_fg = 1                                            THEN 0
              ELSE                                                            NULL
         END
       ) AS val_rtl_rl_fa_del_asis
   ,SUM(
         CASE WHEN foodaction_fg = 1 AND val_rtl_rl_net_del  IS NOT NULL THEN val_rtl_rl_net_del
              WHEN src_fg = 1                                            THEN 0
              ELSE                                                            NULL
         END
       ) AS val_rtl_rl_net_fa_del_asis
   ,SUM(
         CASE WHEN foodaction_fg = 1 AND qty_piece_del_agg   IS NOT NULL THEN qty_piece_del_agg
              WHEN src_fg = 1                                            THEN 0
              ELSE                                                            NULL
         END
       ) AS qty_piece_fa_del_asis
   ,SUM(
         CASE WHEN foodaction_fg = 1 AND val_piece_del       IS NOT NULL THEN val_piece_del
              WHEN src_fg = 1                                            THEN 0
              ELSE                                                            NULL
         END
       ) AS val_piece_fa_del_asis
   ,SUM(
         CASE WHEN foodaction_fg = 1 AND val_piece_net_del   IS NOT NULL THEN val_piece_net_del
              WHEN src_fg = 1                                            THEN 0
              ELSE                                                            NULL
         END
       ) AS val_piece_net_fa_del_asis
   ,SUM(CASE WHEN foodaction_fg = 1 THEN val_pr_diff_del END) AS val_pr_diff_fa_del_asis
   ,SUM(CASE WHEN foodaction_fg = 1 THEN val_pr_diff_net_del END) AS val_pr_diff_net_fa_del_asis
  FROM p_lew_bil_ac.v_agg_deliv_base_1 AS a
  WHERE a.client_id<>18 OR a.loc_sid_store NOT IN(SELECT loc_sid FROM p_lew_core_ac.v_location_1 WHERE client_id=18 AND (src_orig_store_nr BETWEEN 7501 AND 7599 OR src_orig_store_nr=9988))
  GROUP BY 
    client_id
   ,loc_sid_wh_aspect1_asis
   ,sub_item_grp_sid_asis
   ,dat_formdate
   ,cy_month
   ,deliverytype_id
  UNION ALL
  SELECT
    client_id
   ,loc_sid_wh_aspect2_asis  AS loc_sid_wh
   ,MAX(2)                   AS aspect_id
   ,sub_item_grp_sid_asis
   ,dat_formdate
   ,cy_month
   ,deliverytype_id
   ,SUM(qty_total_del)       AS qty_total_del_asis
   ,SUM(val_rtl_rl_del)      AS val_rtl_rl_del_asis
   ,SUM(val_rtl_rl_net_del)  AS val_rtl_rl_net_del_asis
   ,SUM(qty_piece_del_agg)   AS qty_piece_del_asis
   ,SUM(val_piece_del)       AS val_piece_del_asis
   ,SUM(val_piece_net_del)   AS val_piece_net_del_asis
   ,SUM(val_pr_diff_del)     AS val_pr_diff_del_asis
   ,SUM(val_pr_diff_net_del) AS val_pr_diff_net_del_asis
   ,SUM(
         CASE WHEN foodaction_fg = 1 AND qty_total_del       IS NOT NULL THEN qty_total_del
              WHEN src_fg = 1                                            THEN 0
              ELSE                                                            NULL
         END
       ) AS qty_total_fa_del_asis
   ,SUM(
         CASE WHEN foodaction_fg = 1 AND val_rtl_rl_del      IS NOT NULL THEN val_rtl_rl_del
              WHEN src_fg = 1                                            THEN 0
              ELSE                                                            NULL
         END
       ) AS val_rtl_rl_fa_del_asis
   ,SUM(
         CASE WHEN foodaction_fg = 1 AND val_rtl_rl_net_del  IS NOT NULL THEN val_rtl_rl_net_del
              WHEN src_fg = 1                                            THEN 0
              ELSE                                                            NULL
         END
       ) AS val_rtl_rl_net_fa_del_asis
   ,SUM(
         CASE WHEN foodaction_fg = 1 AND qty_piece_del_agg   IS NOT NULL THEN qty_piece_del_agg
              WHEN src_fg = 1                                            THEN 0
              ELSE                                                            NULL
         END
       ) AS qty_piece_fa_del_asis
   ,SUM(
         CASE WHEN foodaction_fg = 1 AND val_piece_del       IS NOT NULL THEN val_piece_del
              WHEN src_fg = 1                                            THEN 0
              ELSE                                                            NULL
         END
       ) AS val_piece_fa_del_asis
   ,SUM(
         CASE WHEN foodaction_fg = 1 AND val_piece_net_del   IS NOT NULL THEN val_piece_net_del
              WHEN src_fg = 1                                            THEN 0
              ELSE                                                            NULL
         END
       ) AS val_piece_net_fa_del_asis
   ,SUM(CASE WHEN foodaction_fg = 1 THEN val_pr_diff_del END) AS val_pr_diff_fa_del_asis
   ,SUM(CASE WHEN foodaction_fg = 1 THEN val_pr_diff_net_del END) AS val_pr_diff_net_fa_del_asis
  FROM p_lew_bil_ac.v_agg_deliv_base_1 AS a
  WHERE a.client_id<>18 OR a.loc_sid_store NOT IN(SELECT loc_sid FROM p_lew_core_ac.v_location_1 WHERE client_id=18 AND src_orig_store_nr BETWEEN 7501 AND 7599)
  GROUP BY 
    client_id
   ,loc_sid_wh_aspect2_asis
   ,sub_item_grp_sid_asis
   ,dat_formdate
   ,cy_month
   ,deliverytype_id
) aji
  INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS b
  ON b.client_id = aji.client_id
  AND CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt
  AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
  AND b.deleted_fg = 0
  INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 AS c
  ON c.client_id = b.client_id
  AND c.x_rate_type_sid = b.x_rate_type_sid
  AND c.src_kurst = '@BEWE'
  INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
  ON wh.client_id = aji.client_id
  AND wh.loc_sid_wh = aji.loc_sid_wh
  AND wh.dwh_actual_fg = 1
  LEFT OUTER JOIN p_lew_core_ac.v_subitemgroup_1 s
  ON s.client_id = aji.client_id
  AND s.sub_item_grp_sid = aji.sub_item_grp_sid_asis
;
