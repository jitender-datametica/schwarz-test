CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_WTOF_ITM_DAY_2
AS
   SELECT
     client_id,
   item_sid,
   loc_sid_store_move_to,
   wh_loc_sid,
   wh_id,
   aspect_id,
   currency_iso_cd,
   dat_formdate,
   cy_week,
   cy_month,
   busyear,
   sfo_total_qty_brok,
   sfo_total_qty_mhd,
   sfo_total_qty_wtof,
   sfo_total_qty_brok_wh,
   sfo_total_qty_rl_defct,
   sfo_total_qty_ald_excd,
   sfo_total_qty_rem_utl,
   sfo_total_qty_hi_vlnc,
   sfo_total_qty_dntn,
   sfo_total_qty_gd_rmv,
   sfo_total_qty_disc,
   sfo_total_qty_veh_brk,
   sfo_total_qty_frc_maj,
   sfo_total_qty_dnt,
   sfo_total_qty_gd_remv_wh,
   sfo_total_qty_veh_brk_wh,
   sfo_total_qty_cmpnt_dir_delv,
   sfo_total_qty_oth_lost_gd,
   sfo_total_qty_del_qual_str,
   sfo_total_qty_wtof_tot

  FROM p_lew_mart_lead.v_agg_wtof_itm_day_2
;