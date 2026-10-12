
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_STORE_MTH_SIG_DEL_ASIS 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
     /*
     DescStart
     $Revision: 7254 $, $LastChangedBy: mmurtenthaler $
     SubjectAreas: Anliefermenge
     DescEnd
     */
     SELECT
       aji.client_id,
     aji.cy_month                                 AS month_id,
     aji.deliverytype_id,
     aji.orig_store_nr,
     aji.loc_sid_store                            AS store_id,
     CAST(s.src_subitemgrp_cd AS INTEGER )        AS subitemgroup_id,
     aji.qty_total_del                            AS qty_total_del_asis,
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
     FROM p_lew_bil_ac.v_aji_deliv_store_mth_sig AS aji
     INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS b
     ON b.client_id = aji.client_id
     AND CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt
     AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
     AND b.deleted_fg = 0
     INNER JOIN p_lew_core_ac.v_exchange_rate_type AS c
     ON c.client_id = b.client_id
     AND c.x_rate_type_sid = b.x_rate_type_sid
     AND c.src_kurst = '@BEWE'
     LEFT OUTER JOIN p_lew_core_ac.v_subitemgroup s
     ON s.client_id = aji.client_id
     AND s.sub_item_grp_sid = aji.sub_item_grp_sid_asis
;
