/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_AGG_STORE_DAY_ITEM_DEL_ASIS_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.03.2022    Białek, Aleksander        Implementing Container context (part of Sortimentmodularity, AzureDevops: US 298238, BBT-3750, AP0101040)
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_STORE_DAY_ITEM_DEL_ASIS_SOMO_1 (
  CLIENT_ID
, DAT_FORMDATE
, CY_MONTH
, DELIVERYTYPE_ID
, ITEM_ID
, ORIG_STORE_NR
, QTY_TOTAL_DEL_ASIS
, STORE_ID
, CONTAINER_ID
, CONTAINER_HIST_ID
, VAL_RTL_RL_DEL_ASIS
, VAL_RTL_RL_NET_DEL_ASIS
, QTY_PIECE_DEL_ASIS
, VAL_PIECE_DEL_ASIS
, VAL_PIECE_NET_DEL_ASIS
, VAL_PR_DIFF_DEL
, VAL_PR_DIFF_NET_DEL
, QTY_TOTAL_FA_DEL_ASIS
, VAL_RTL_RL_FA_DEL_ASIS
, VAL_RTL_RL_NET_FA_DEL_ASIS
, QTY_PIECE_FA_DEL_ASIS
, VAL_PIECE_FA_DEL_ASIS
, VAL_PIECE_NET_FA_DEL_ASIS
, VAL_PR_DIFF_FA_DEL
, VAL_PR_DIFF_NET_FA_DEL
, CURRENCY_ISO_CD
) AS
   /*
   #DescStart#
   #$Revision: 8320 $, $LastChangedBy: mueding $
   #SubjectAreas#: Anliefermenge
   #DescEnd#
   */
   SELECT
  a.client_id
, a.dat_formdate
, a.cy_month
, a.deliverytype_id
, itmp.item_sid_map                                                            AS item_id
, a.orig_store_nr
, a.qty_total_del                                                              AS qty_total_del_asis
, a.loc_sid_store                                                              AS store_id
, sm.container_id                                                              AS container_id
, sm_hist.container_id                                                         AS container_hist_id
, a.val_rtl_rl_del / b.exchange_rate                                           AS val_rtl_rl_del_asis
, a.val_rtl_rl_net_del / b.exchange_rate                                       AS val_rtl_rl_net_del_asis
, a.qty_piece_del_agg                                                          AS qty_piece_del_asis
, a.val_piece_del / b.exchange_rate                                            AS val_piece_del_asis
, a.val_piece_net_del / b.exchange_rate                                        AS val_piece_net_del_asis
, a.val_pr_diff_del / b.exchange_rate                                          AS val_pr_diff_del
, a.val_pr_diff_net_del / b.exchange_rate                                      AS val_pr_diff_net_del
, CASE WHEN a.foodaction_fg = 1   THEN qty_total_del_asis        ELSE NULL END AS qty_total_fa_del_asis
, CASE WHEN a.foodaction_fg = 1   THEN val_rtl_rl_del_asis       ELSE NULL END AS val_rtl_rl_fa_del_asis
, CASE WHEN a.foodaction_fg = 1   THEN val_rtl_rl_net_del_asis   ELSE NULL END AS val_rtl_rl_net_fa_del_asis
, CASE WHEN a.foodaction_fg = 1   THEN qty_piece_del_asis        ELSE NULL END AS qty_piece_fa_del_asis
, CASE WHEN a.foodaction_fg = 1   THEN val_piece_del_asis        ELSE NULL END AS val_piece_fa_del_asis
, CASE WHEN a.foodaction_fg = 1   THEN val_piece_net_del_asis    ELSE NULL END AS val_piece_net_fa_del_asis
, CASE WHEN a.foodaction_fg = 1   THEN val_pr_diff_del           ELSE NULL END AS val_pr_diff_fa_del
, CASE WHEN a.foodaction_fg = 1   THEN val_pr_diff_net_del       ELSE NULL END AS val_pr_diff_net_fa_del
, b.curr_cd_from                                                               AS currency_iso_cd
   FROM p_lew_bil_ac.v_agg_deliv_base_1 AS a
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS b
   ON b.client_id = a.client_id
   AND CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt
   AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
   AND b.deleted_fg = 0
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 AS c
   ON c.client_id = b.client_id
   AND c.x_rate_type_sid = b.x_rate_type_sid
   AND c.src_kurst = '@BEWE'
   INNER JOIN p_lew_core_ac.v_item_map_key_1 itmp
   ON itmp.client_id = a.client_id
   AND itmp.item_sid = a.item_sid
   
   LEFT OUTER JOIN p_lew_bil_ac.v_org_store_merge_1 AS osm
   ON  a.client_id     = osm.client_id
   AND a.loc_sid_store = osm.loc_sid_store
   AND osm.aspect_id     = 1

   LEFT OUTER JOIN p_lew_BIL_ac.v_sm_map_item_container_str_1 sm_1
   ON a.client_id = sm.client_id
   AND a.item_sid = sm.item_sid
   AND osm.loc_sid_store_move_to = sm.move_to_store_id
   AND CURRENT_DATE BETWEEN sm.dat_rec_start AND sm.dat_rec_end

   LEFT OUTER JOIN p_lew_bil_ac.v_sm_map_item_container_str_1 sm_hist
   ON a.client_id = sm_hist.client_id
   AND a.item_sid = sm_hist.item_sid
   AND osm.loc_sid_store_move_to = sm_hist.move_to_store_id
   AND a.dat_formdate BETWEEN sm_hist.dat_rec_start AND sm_hist.dat_rec_end   
;