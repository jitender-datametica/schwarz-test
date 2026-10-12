/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_AGG_STORE_DAY_ITEM_DEL_ASIS
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_AGG_STORE_DAY_ITEM_DEL_ASIS
AS
   /*************************************************************************************************************
   * Date: 27.11.2019  User: wieberadm_asp
   * View ist 1:1 aus MART_MSI und müsste in dem BIL überführt werden 
   *************************************************************************************************************/
   SELECT
   a.client_id,
   a.dat_formdate,
   a.cy_month,
   a.deliverytype_id,
   itmp.item_sid_map,
   a.orig_store_nr,
   a.qty_total_del                                                              AS qty_total_del_asis,
   a.loc_sid_store,
   a.val_rtl_rl_del / b.exchange_rate                                           AS val_rtl_rl_del_asis,
   a.val_rtl_rl_net_del / b.exchange_rate                                       AS val_rtl_rl_net_del_asis,
   a.qty_piece_del_agg                                                          AS qty_piece_del_asis,
   a.val_piece_del / b.exchange_rate                                            AS val_piece_del_asis,
   a.val_piece_net_del / b.exchange_rate                                        AS val_piece_net_del_asis,
   a.val_pr_diff_del / b.exchange_rate                                          AS val_pr_diff_del,
   a.val_pr_diff_net_del / b.exchange_rate                                      AS val_pr_diff_net_del,
   CASE WHEN a.foodaction_fg = 1   THEN qty_total_del_asis        ELSE NULL END AS qty_total_fa_del_asis,
   CASE WHEN a.foodaction_fg = 1   THEN val_rtl_rl_del_asis       ELSE NULL END AS val_rtl_rl_fa_del_asis,
   CASE WHEN a.foodaction_fg = 1   THEN val_rtl_rl_net_del_asis   ELSE NULL END AS val_rtl_rl_net_fa_del_asis,
   CASE WHEN a.foodaction_fg = 1   THEN qty_piece_del_asis        ELSE NULL END AS qty_piece_fa_del_asis,
   CASE WHEN a.foodaction_fg = 1   THEN val_piece_del_asis        ELSE NULL END AS val_piece_fa_del_asis,
   CASE WHEN a.foodaction_fg = 1   THEN val_piece_net_del_asis    ELSE NULL END AS val_piece_net_fa_del_asis,
   CASE WHEN a.foodaction_fg = 1   THEN val_pr_diff_del           ELSE NULL END AS val_pr_diff_fa_del,
   CASE WHEN a.foodaction_fg = 1   THEN val_pr_diff_net_del       ELSE NULL END AS val_pr_diff_net_fa_del,
   b.curr_cd_from                                                               AS currency_iso_cd
   FROM p_lew_bil_ac.v_agg_deliv_base AS a
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS b
   ON b.client_id = a.client_id
   AND CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt
   AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
   AND b.deleted_fg = 0
   INNER JOIN p_lew_core_ac.v_exchange_rate_type AS c
   ON c.client_id = b.client_id
   AND c.x_rate_type_sid = b.x_rate_type_sid
   AND c.src_kurst = '@BEWE'
   INNER JOIN p_lew_core_ac.v_item_map_key itmp
   ON itmp.client_id = a.client_id
   AND itmp.item_sid = a.item_sid
;