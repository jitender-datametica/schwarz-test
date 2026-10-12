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


/* #DescStart#
   #$Revision: 8320 $, $LastChangedBy: mueding $
   #SubjectAreas#: Anliefermenge
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_store_day_item_del_asis_somo_1 (client_id, dat_formdate, cy_month,
deliverytype_id, item_id, orig_store_nr, qty_total_del_asis, store_id, container_id, container_hist_id,
val_rtl_rl_del_asis, val_rtl_rl_net_del_asis, qty_piece_del_asis, val_piece_del_asis, val_piece_net_del_asis,
val_pr_diff_del, val_pr_diff_net_del, qty_total_fa_del_asis, val_rtl_rl_fa_del_asis, val_rtl_rl_net_fa_del_asis,
qty_piece_fa_del_asis, val_piece_fa_del_asis, val_piece_net_fa_del_asis, val_pr_diff_fa_del, val_pr_diff_net_fa_del,
currency_iso_cd) AS SELECT A.client_id,
 A.dat_formdate,
 A.cy_month,
 A.deliverytype_id,
 ITMP.item_sid_map AS item_id,
 A.orig_store_nr,
 A.qty_total_del AS qty_total_del_asis,
 A.loc_sid_store AS store_id,
 SM.container_id,
 SM_HIST.container_id AS container_hist_id,
  A.val_rtl_rl_del / B.exchange_rate AS val_rtl_rl_del_asis,
  A.val_rtl_rl_net_del / B.exchange_rate AS val_rtl_rl_net_del_asis,
 A.qty_piece_del_agg AS qty_piece_del_asis,
  A.val_piece_del / B.exchange_rate AS val_piece_del_asis,
  A.val_piece_net_del / B.exchange_rate AS val_piece_net_del_asis,
  A.val_pr_diff_del / B.exchange_rate AS val_pr_diff_del,
  A.val_pr_diff_net_del / B.exchange_rate AS val_pr_diff_net_del,
  CASE
  WHEN A.foodaction_fg = 1
  THEN A.qty_total_del
  ELSE NULL
  END AS qty_total_fa_del_asis,
  CASE
  WHEN A.foodaction_fg = 1
  THEN A.val_rtl_rl_del / B.exchange_rate
  ELSE NULL
  END AS val_rtl_rl_fa_del_asis,
  CASE
  WHEN A.foodaction_fg = 1
  THEN A.val_rtl_rl_net_del / B.exchange_rate
  ELSE NULL
  END AS val_rtl_rl_net_fa_del_asis,
  CASE
  WHEN A.foodaction_fg = 1
  THEN A.qty_piece_del_agg
  ELSE NULL
  END AS qty_piece_fa_del_asis,
  CASE
  WHEN A.foodaction_fg = 1
  THEN A.val_piece_del / B.exchange_rate
  ELSE NULL
  END AS val_piece_fa_del_asis,
  CASE
  WHEN A.foodaction_fg = 1
  THEN A.val_piece_net_del / B.exchange_rate
  ELSE NULL
  END AS val_piece_net_fa_del_asis,
  CASE
  WHEN A.foodaction_fg = 1
  THEN A.val_pr_diff_del
  ELSE NULL
  END AS val_pr_diff_fa_del,
  CASE
  WHEN A.foodaction_fg = 1
  THEN A.val_pr_diff_net_del
  ELSE NULL
  END AS val_pr_diff_net_fa_del,
 B.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_bil_ac.v_agg_deliv_base_1 AS A
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS B ON A.client_id = B.client_id AND CURRENT_DATE BETWEEN B.active_from_dt
     AND B.active_to_dt AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to AND B.deleted_fg = 0
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS C ON B.client_id = C.client_id AND B.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE'
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON A.client_id = ITMP.client_id AND A.item_sid = ITMP.item_sid
 LEFT JOIN ldl_p_lew_bil_ac.v_org_store_merge_1 AS OSM ON A.client_id = OSM.client_id AND A.loc_sid_store = OSM.loc_sid_store
     AND OSM.aspect_id = 1
 LEFT JOIN ldl_p_lew_bil_ac.v_sm_map_item_container_str_1 AS SM_1 ON A.client_id = SM.client_id AND A.item_sid = SM.item_sid
      AND OSM.loc_sid_store_move_to = SM.move_to_store_id AND CURRENT_DATE BETWEEN SM.dat_rec_start AND SM.dat_rec_end
 LEFT JOIN ldl_p_lew_bil_ac.v_sm_map_item_container_str_1 AS SM_HIST ON A.client_id = SM_HIST.client_id AND A.item_sid =
     SM_HIST.item_sid AND OSM.loc_sid_store_move_to = SM_HIST.move_to_store_id AND A.dat_formdate BETWEEN SM_HIST.dat_rec_start
   AND SM_HIST.dat_rec_end;