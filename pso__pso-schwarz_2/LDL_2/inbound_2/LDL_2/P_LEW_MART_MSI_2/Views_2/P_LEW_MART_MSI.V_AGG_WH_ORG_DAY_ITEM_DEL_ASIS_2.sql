CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_WH_ORG_DAY_ITEM_DEL_ASIS_2 AS
/*
#DescStart#
#$Revision: 13744 $, $LastChangedBy: cbarlow $
#SubjectAreas#: Anliefermenge
2022-07-08 Martin Murtenthaler AP0138467 IT + INT-B-106 + MIS Web + Anliefermenge Malta in MSB Incident 4931547 Maltastores excluded from Italy
#DescEnd#
*/
SELECT
  aji.client_id
 ,aji.dat_formdate
 ,aji.deliverytype_id
 ,itmp.item_sid_map                                 AS item_id
 ,wh.src_wh_id                                      AS wh_id
 ,aji.aspect_id                                     AS aspect_id
 ,aji.qty_total_del_asis                            AS qty_total_del_asis
 ,aji.val_rtl_rl_del_asis / b.exchange_rate         AS val_rtl_rl_del_asis
 ,aji.val_rtl_rl_net_del_asis / b.exchange_rate     AS val_rtl_rl_net_del_asis
 ,aji.qty_piece_del_asis                            AS qty_piece_del_asis
 ,aji.val_piece_del_asis / b.exchange_rate          AS val_piece_del_asis
 ,aji.val_piece_net_del_asis / b.exchange_rate      AS val_piece_net_del_asis
 ,aji.val_pr_diff_del_asis / b.exchange_rate        AS val_pr_diff_del_asis
 ,aji.val_pr_diff_net_del_asis / b.exchange_rate    AS val_pr_diff_net_del_asis
 ,aji.qty_total_fa_del_asis                         AS qty_total_fa_del_asis
 ,aji.val_rtl_rl_fa_del_asis / b.exchange_rate      AS val_rtl_rl_fa_del_asis
 ,aji.val_rtl_rl_net_fa_del_asis / b.exchange_rate  AS val_rtl_rl_net_fa_del_asis
 ,aji.qty_piece_fa_del_asis                         AS qty_piece_fa_del_asis
 ,aji.val_piece_fa_del_asis / b.exchange_rate       AS val_piece_fa_del_asis
 ,aji.val_piece_net_fa_del_asis / b.exchange_rate   AS val_piece_net_fa_del_asis
 ,aji.val_pr_diff_fa_del_asis / b.exchange_rate     AS val_pr_diff_fa_del_asis
 ,aji.val_pr_diff_net_fa_del_asis / b.exchange_rate AS val_pr_diff_net_fa_del_asis
 ,b.curr_cd_from                                    AS currency_iso_cd
FROM
(
  SELECT
    client_id
   ,loc_sid_wh_aspect1_asis  AS loc_sid_wh
   ,MAX(1)                   AS aspect_id
   ,item_sid
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
  FROM p_lew_bil_ac.v_agg_deliv_base_2 AS a
  WHERE a.client_id<>18 OR a.loc_sid_store NOT IN(SELECT loc_sid FROM p_lew_core_ac.v_location_2 WHERE client_id=18 AND (src_orig_store_nr BETWEEN 7501 AND 7599 OR src_orig_store_nr=9988))
  GROUP BY 
    client_id
   ,loc_sid_wh_aspect1_asis
   ,item_sid
   ,dat_formdate
   ,cy_month
   ,deliverytype_id

  UNION ALL

  SELECT
    client_id
   ,loc_sid_wh_aspect2_asis  AS loc_sid_wh
   ,MAX(2)                   AS aspect_id
   ,item_sid
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
  FROM p_lew_bil_ac.v_agg_deliv_base_2 AS a
  WHERE a.client_id<>18 OR a.loc_sid_store NOT IN(SELECT loc_sid FROM p_lew_core_ac.v_location_2 WHERE client_id=18 AND src_orig_store_nr BETWEEN 7501 AND 7599)
  GROUP BY 
    client_id
   ,loc_sid_wh_aspect2_asis
   ,item_sid
   ,dat_formdate
   ,cy_month
   ,deliverytype_id
 ) aji
INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_2 AS b
ON b.client_id = aji.client_id
AND CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt
AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
AND b.deleted_fg = 0
INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 AS c
ON c.client_id = b.client_id
AND c.x_rate_type_sid = b.x_rate_type_sid
AND c.src_kurst = '@BEWE'
INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
ON wh.client_id = aji.client_id
AND wh.loc_sid_wh = aji.loc_sid_wh
AND wh.dwh_actual_fg = 1
INNER JOIN p_lew_core_ac.v_item_map_key_2 itmp
ON itmp.client_id = aji.client_id
AND itmp.item_sid = aji.item_sid
;