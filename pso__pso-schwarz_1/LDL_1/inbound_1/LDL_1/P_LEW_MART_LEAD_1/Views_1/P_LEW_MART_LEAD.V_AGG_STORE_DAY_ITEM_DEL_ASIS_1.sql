CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_DEL_ASIS_1
AS
   /*
   #DescStart#
   #$Revision: 11490 $, $LastChangedBy: ckumbhale $
   #SubjectAreas#: Anliefermenge
   #DescEnd#
   */
   SELECT
      a.client_id,
   a.dat_formdate,
   a.cy_month,
   a.deliverytype_id,
   itmp.item_sid_map                                                            AS item_id,
   a.orig_store_nr,
   a.qty_total_del                                                              AS qty_total_del_asis,
   a.loc_sid_store                                                              AS store_id,
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
;