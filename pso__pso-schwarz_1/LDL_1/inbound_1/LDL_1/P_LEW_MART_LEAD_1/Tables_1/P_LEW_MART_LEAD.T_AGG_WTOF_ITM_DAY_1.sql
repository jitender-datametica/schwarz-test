CREATE TABLE P_LEW_MART_LEAD.T_AGG_WTOF_ITM_DAY_1 CLUSTER BY (client_id,dat_formdate)(
  client_id                    NUMBER(38,0) NOT NULL
, item_sid                     NUMBER(38,0) NOT NULL
, loc_sid_store                NUMBER(38,0) NOT NULL
, dat_formdate                 DATE         NOT NULL
, cy_week                      NUMBER(38,0) NOT NULL
, cy_month                     NUMBER(38,0) NOT NULL
, busyear                      NUMBER(38,0) NOT NULL
, sfo_total_qty_brok           NUMBER(18,5)
, sfo_total_qty_mhd            NUMBER(18,5)
, sfo_total_qty_wtof           NUMBER(18,5)
, sfo_total_qty_brok_wh        NUMBER(18,5)
, sfo_total_qty_rl_defct       NUMBER(18,5)
, sfo_total_qty_ald_excd       NUMBER(18,5)
, sfo_total_qty_rem_utl        NUMBER(18,5)
, sfo_total_qty_hi_vlnc        NUMBER(18,5)
, sfo_total_qty_dntn           NUMBER(18,5)
, sfo_total_qty_gd_rmv         NUMBER(18,5)
, sfo_total_qty_disc           NUMBER(18,5)
, sfo_total_qty_veh_brk        NUMBER(18,5)
, sfo_total_qty_frc_maj        NUMBER(18,5)
, sfo_total_qty_dnt            NUMBER(18,5)
, sfo_total_qty_gd_remv_wh     NUMBER(18,5)
, sfo_total_qty_veh_brk_wh     NUMBER(18,5)
, sfo_total_qty_cmpnt_dir_delv NUMBER(18,5)
, sfo_total_qty_oth_lost_gd    NUMBER(18,5)
, sfo_total_qty_del_qual_str   NUMBER(18,5)
, sfo_total_qty_wtof_tot       NUMBER(18,5)
, dwh_updated                  TIMESTAMP_NTZ(9) NOT NULL
);