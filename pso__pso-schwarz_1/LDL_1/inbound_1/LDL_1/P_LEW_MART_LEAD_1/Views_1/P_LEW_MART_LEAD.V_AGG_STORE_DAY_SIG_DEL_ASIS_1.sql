CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_STORE_DAY_SIG_DEL_ASIS_1
AS
   /*
   DescStart
   $Revision: 11490 $, $LastChangedBy: ckumbhale $
   SubjectAreas: Anliefermenge
   DescEnd
   */
   SELECT
     aji.client_id,
   aji.dat_formdate,
   aji.deliverytype_id,
   aji.orig_store_nr,
   aji.qty_total_del                            AS qty_total_del_asis,
   aji.loc_sid_store                            AS store_id,
   CAST(s.src_subitemgrp_cd AS INTEGER)         AS subitemgroup_id,
   aji.val_rtl_rl_del / b.exchange_rate         AS val_rtl_rl_del_asis,
   aji.val_rtl_rl_net_del / b.exchange_rate     AS val_rtl_rl_net_del_asis,
   aji.qty_piece_del                            AS qty_piece_del_asis,
   aji.val_piece_del / b.exchange_rate          AS val_piece_del_asis,
   aji.val_piece_net_del / b.exchange_rate      AS val_piece_net_del_asis,
   aji.val_pr_diff_del / b.exchange_rate        AS val_pr_diff_del_asis,
   aji.val_pr_diff_net_del / b.exchange_rate    AS val_pr_diff_net_del_asis,
   aji.qty_total_fa_del                         AS qty_total_fa_del_asis,
   aji.val_rtl_rl_fa_del / b.exchange_rate      AS val_rtl_rl_fa_del_asis,
   aji.val_rtl_rl_net_fa_del / b.exchange_rate  AS val_rtl_rl_net_fa_del_asis,
   aji.qty_piece_fa_del                         AS qty_piece_fa_del_asis,
   aji.val_piece_fa_del / b.exchange_rate       AS val_piece_fa_del_asis,
   aji.val_piece_net_fa_del / b.exchange_rate   AS val_piece_net_fa_del_asis,
   aji.val_pr_diff_fa_del / b.exchange_rate     AS val_pr_diff_fa_del_asis,
   aji.val_pr_diff_net_fa_del / b.exchange_rate AS val_pr_diff_net_fa_del_asis,
   b.curr_cd_from                               AS currency_iso_cd
   FROM p_lew_bil_ac.v_aji_deliv_store_day_sig_1 AS aji
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS b
   ON b.client_id = aji.client_id
   AND Current_Date BETWEEN b.active_from_dt AND b.active_to_dt
   AND Current_Date BETWEEN b.dwh_valid_from AND b.dwh_valid_to
   AND b.deleted_fg = 0
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 AS c
   ON c.client_id = b.client_id
   AND c.x_rate_type_sid = b.x_rate_type_sid
   AND c.src_kurst = '@BEWE'
   LEFT OUTER JOIN p_lew_core_ac.v_subitemgroup_1 s
   ON s.client_id = aji.client_id
   AND s.sub_item_grp_sid = aji.sub_item_grp_sid_asis
;