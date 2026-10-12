/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_AGG_STORE_DAY_ITEM_DEL_ASIS_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* * Date: 27.11.2019  User: wieberadm_asp
   * View ist 1:1 aus MART_MSI und müsste in dem BIL überführt werden 
   ************************************************************************************************************ */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_agg_store_day_item_del_asis_1 AS SELECT A.client_id,
 A.dat_formdate,
 A.cy_month,
 A.deliverytype_id,
 ITMP.item_sid_map,
 A.orig_store_nr,
 A.qty_total_del AS qty_total_del_asis,
 A.loc_sid_store,
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
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON A.client_id = ITMP.client_id AND A.item_sid = ITMP.item_sid;