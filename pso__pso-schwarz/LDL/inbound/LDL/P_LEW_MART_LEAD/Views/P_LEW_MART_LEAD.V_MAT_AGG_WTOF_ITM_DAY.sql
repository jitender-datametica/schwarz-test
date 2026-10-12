CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MAT_AGG_WTOF_ITM_DAY
/*
#DescStart#
#$Revision: 12456 $, $LastChangedBy: knagmote $
#SubjectAreas#: Writeoff KPIs at store and day level
#DescEnd#
*/
(
  client_id
, item_sid
, loc_sid_store
, dat_formdate
, cy_week
, cy_month
, busyear
, sfo_total_qty_brok
, sfo_total_qty_mhd
, sfo_total_qty_wtof
, sfo_total_qty_brok_wh
, sfo_total_qty_rl_defct
, sfo_total_qty_ald_excd
, sfo_total_qty_rem_utl
, sfo_total_qty_hi_vlnc
, sfo_total_qty_dntn
, sfo_total_qty_gd_rmv
, sfo_total_qty_disc
, sfo_total_qty_veh_brk
, sfo_total_qty_frc_maj
, sfo_total_qty_dnt
, sfo_total_qty_gd_remv_wh
, sfo_total_qty_veh_brk_wh
, sfo_total_qty_cmpnt_dir_delv
, sfo_total_qty_oth_lost_gd
, sfo_total_qty_del_qual_str
, sfo_total_qty_wtof_tot
, dwh_updated
)
AS
SELECT   sfo.client_id
       , sfo.item_sid
       , sfo.loc_sid_store
       , sfo.dat_formdate
       , sfo.cy_week
       , sfo.cy_month
       , sfo.busyear
       , 1 AS sfo_total_qty_brok
       , 1 AS sfo_total_qty_mhd
       , 1 AS sfo_total_qty_wtof
       , 1 AS sfo_total_qty_brok_wh
       , 1 AS sfo_total_qty_rl_defct
       , 1 AS sfo_total_qty_ald_excd
       , 1 AS sfo_total_qty_rem_utl
       , 1 AS sfo_total_qty_hi_vlnc
       , 1 AS sfo_total_qty_dntn
       , 1 AS sfo_total_qty_gd_rmv
       , 1 AS sfo_total_qty_disc
       , 1 AS sfo_total_qty_veh_brk
       , 1 AS sfo_total_qty_frc_maj
       , 1 AS sfo_total_qty_dnt
       , 1 AS sfo_total_qty_gd_remv_wh
       , 1 AS sfo_total_qty_veh_brk_wh
       , 1 AS sfo_total_qty_cmpnt_dir_delv
       , 1 AS sfo_total_qty_oth_lost_gd
       , 1 AS sfo_total_qty_del_qual_str  
       , 1 AS sfo_total_qty_wtof_tot
       , CURRENT_TIMESTAMP(6) AS dwh_updated
  FROM P_LEW_MART_LEAD.t_agg_wtof_itm_day sfo
;