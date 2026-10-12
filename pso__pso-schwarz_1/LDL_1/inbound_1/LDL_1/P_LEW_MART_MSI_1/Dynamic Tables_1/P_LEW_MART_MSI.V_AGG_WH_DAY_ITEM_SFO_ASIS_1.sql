
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_WH_DAY_ITEM_SFO_ASIS_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
      agg.client_id,
   wh.src_wh_id AS wh_id,
   agg.booking_dat                            AS dat_formdate,
   itmp.item_sid_map                            AS item_id,
   agg.sfotype_id,
   agg.pcwo_reason_id,
   agg.sfo_total_qty_asis                     AS qty_total_sfo_asis,
   agg.sfo_wrtoff_zero_qty_asis               AS qty_total_sfo_wrtoff_zero_asis,
   agg.sfo_total_rtl_rl_val_asis              AS val_rtl_rcptline_sfo_asis,
   agg.sfo_total_rtl_rl_net_val_asis          AS val_rtl_rl_net_sfo_asis,
   agg.sfo_wrtoff_zero_rtl_rl_val_asis        AS val_wrtoff_zero_asis,
   agg.sfo_wrtoff_zero_rtl_rl_net_val_asis    AS val_wrtoff_zero_net_asis,
   agg.val_pr_diff_sfo_asis,
   agg.val_pr_diff_net_sfo_asis,
   agg.sfo_total_fa_qty_asis                  AS qty_total_fa_sfo_asis,
   agg.sfo_wrtoff_zero_fa_qty_asis            AS qty_tot_sfo_wrtoff_zr_fa_asis,
   agg.sfo_total_rtl_rl_fa_val_asis           AS val_rtl_rcptline_fa_sfo_asis,
   agg.sfo_total_rtl_rl_net_fa_val_asis       AS val_rtl_rl_net_fa_sfo_asis,
   agg.sfo_wrtoff_zero_rtl_rl_fa_val_asis     AS val_wrtoff_zero_fa_asis,
   agg.sfo_wrtoff_zero_rtl_rl_net_fa_val_asis AS val_wrtoff_zero_net_fa_asis,
   agg.val_pr_diff_fa_sfo_asis,
   agg.val_pr_diff_net_fa_sfo_asis,
   agg.curr_cd_from                            AS currency_iso_cd
   FROM p_lew_bil_ac.v_agg_wh_day_item_sfo_asis_1 AS agg
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
   ON agg.client_id=wh.client_id
   AND agg.loc_sid_wh=wh.loc_sid_wh
   AND wh.dwh_actual_fg = 1
   INNER JOIN p_lew_core_ac.v_item_map_key_1 AS itmp
   ON itmp.client_id = agg.client_id
   AND itmp.item_sid = agg.item_sid
;
