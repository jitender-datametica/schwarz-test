create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_MSI.V_AGG_STORE_DAY_ITEM_SFO_ASIS_SOMO_1(
	CLIENT_ID,
	STORE_ID,
	ORIG_STORE_NR,
	DAT_FORMDATE,
	CY_MONTH,
	ITEM_ID,
	CONTAINER_ID,
	CONTAINER_HIST_ID,
	SFOTYPE_ID,
	PCWO_REASON_ID,
	QTY_TOTAL_SFO_ASIS,
	QTY_TOTAL_WTOF_SFO_ASIS,
	QTY_TOTAL_SFO_WRTOFF_ZERO_ASIS,
	VAL_RTL_RCPTLINE_SFO_ASIS,
	VAL_RTL_RL_NET_SFO_ASIS,
	VAL_WRTOFF_ZERO_ASIS,
	VAL_WRTOFF_ZERO_NET_ASIS,
	PRICE_WH_SFO_ASIS,
	PRICE_WH_NET_SFO_ASIS,
	PRICE_STR_SFO_ASIS,
	PRICE_STR_NET_SFO_ASIS,
	VAL_PR_DIFF_SFO_ASIS,
	VAL_PR_DIFF_NET_SFO_ASIS,
	QTY_TOTAL_FA_SFO_ASIS,
	QTY_TOT_SFO_WRTOFF_ZR_FA_ASIS,
	VAL_RTL_RCPTLINE_FA_SFO_ASIS,
	VAL_RTL_RL_NET_FA_SFO_ASIS,
	VAL_WRTOFF_ZERO_FA_ASIS,
	VAL_WRTOFF_ZERO_NET_FA_ASIS,
	PRICE_WH_FA_SFO_ASIS,
	PRICE_WH_NET_FA_SFO_ASIS,
	PRICE_STR_FA_SFO_ASIS,
	PRICE_STR_NET_FA_SFO_ASIS,
	VAL_PR_DIFF_FA_SFO_ASIS,
	VAL_PR_DIFF_NET_FA_SFO_ASIS,
	CURRENCY_ISO_CD,
	SRC_FG
) as
   SELECT
  a.client_id
, a.loc_sid_store store_id
, a.src_orig_store_nr orig_store_nr
, a.booking_dat dat_formdate
, a.cy_month
, itmp.item_sid_map                                            AS item_id
, sm.container_id
, sm_hist.container_id                                           AS container_hist_id   
, a.sfotype_id
, a.pcwo_reason_id
, a.sfo_total_qty_asis                                         AS qty_total_sfo_asis
, CASE WHEN (a.sfotype_id IN (182, 192)
   AND a.pcwo_reason_id IN (21, 23, 24, 22, 126, 28, 27, 26, 132, 29, 31, 103, 104, 123, 124, 30, 105, 106, 107, 108, 109, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 125, 133, 25, 112, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153, 154, 156, 157))
   OR (a.sfotype_id IN (137, 147)
   AND a.pcwo_reason_id IN (2, 9, 10, 11, 128, 1, 127, 134, 135, 5, 3, 7, 130, 131, 4, 101, 102, 110, 111, 129, 8, 136, 137, 152, 155))
   OR (a.sfotype_id IN (181, 191)
   AND a.pcwo_reason_id IN (82, 83, 84)) 
   THEN a.sfo_total_qty_asis ELSE NULL END                     AS qty_total_wtof_sfo_asis
, a.sfo_wrtoff_zero_qty_asis                                   AS qty_total_sfo_wrtoff_zero_asis
, a.sfo_total_rtl_rl_val_asis / cry.exchange_rate              AS val_rtl_rcptline_sfo_asis
, a.sfo_total_rtl_rl_net_val_asis / cry.exchange_rate          AS val_rtl_rl_net_sfo_asis
, a.sfo_wrtoff_zero_rtl_rl_val_asis / cry.exchange_rate        AS val_wrtoff_zero_asis
, a.sfo_wrtoff_zero_rtl_rl_net_val_asis / cry.exchange_rate    AS val_wrtoff_zero_net_asis
, a.price_wh_sfo_asis / cry.exchange_rate                      AS price_wh_sfo_asis
, a.price_wh_net_sfo_asis / cry.exchange_rate                  AS price_wh_net_sfo_asis
, a.price_str_sfo_asis / cry.exchange_rate                     AS price_str_sfo_asis
, a.price_str_net_sfo_asis / cry.exchange_rate                 AS price_str_net_sfo_asis
, a.val_pr_diff_sfo_asis / cry.exchange_rate                   AS val_pr_diff_sfo_asis
, a.val_pr_diff_net_sfo_asis / cry.exchange_rate               AS val_pr_diff_net_sfo_asis
, a.sfo_total_fa_qty_asis                                      AS qty_total_fa_sfo_asis
, a.sfo_wrtoff_zero_fa_qty_asis                                AS qty_tot_sfo_wrtoff_zr_fa_asis
, a.sfo_total_rtl_rl_fa_val_asis / cry.exchange_rate           AS val_rtl_rcptline_fa_sfo_asis
, a.sfo_total_rtl_rl_net_fa_val_asis / cry.exchange_rate       AS val_rtl_rl_net_fa_sfo_asis
, a.sfo_wrtoff_zero_rtl_rl_fa_val_asis    / cry.exchange_rate  AS val_wrtoff_zero_fa_asis
, a.sfo_wrtoff_zero_rtl_rl_net_fa_val_asis / cry.exchange_rate AS val_wrtoff_zero_net_fa_asis
, a.price_wh_fa_sfo_asis / cry.exchange_rate                   AS price_wh_fa_sfo_asis
, a.price_wh_net_fa_sfo_asis / cry.exchange_rate               AS price_wh_net_fa_sfo_asis
, a.price_str_fa_sfo_asis / cry.exchange_rate                  AS price_str_fa_sfo_asis
, a.price_str_net_fa_sfo_asis / cry.exchange_rate              AS price_str_net_fa_sfo_asis
, a.val_pr_diff_fa_sfo_asis / cry.exchange_rate                AS val_pr_diff_fa_sfo_asis
, a.val_pr_diff_net_fa_sfo_asis / cry.exchange_rate            AS val_pr_diff_net_fa_sfo_asis
, cry.curr_cd_from                                             AS currency_iso_cd
, a.src_fg
   FROM p_lew_bil_ac.v_agg_store_day_item_sfo_asis_1 a
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS cry
   ON a.client_id = cry.client_id
   AND Current_Date BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND Current_Date BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 c
   ON c.client_id = cry.client_id
   AND c.x_rate_type_sid = cry.x_rate_type_sid
   AND c.src_kurst = '@BEWE'
   INNER JOIN p_lew_core_ac.v_item_map_key_1 itmp
   ON itmp.client_id = a.client_id
   AND itmp.item_sid = a.item_sid
   
   LEFT OUTER JOIN p_lew_bil_ac.v_org_store_merge_1 AS osm
   ON  a.client_id     = osm.client_id
   AND a.loc_sid_store = osm.loc_sid_store
   AND osm.aspect_id     = 1   
   
   LEFT OUTER JOIN p_lew_BIL_ac.v_sm_map_item_container_str_1 sm_1
   ON a.client_id = sm.client_id
   AND a.item_sid = sm.item_sid
   AND osm.loc_sid_store_move_to = sm.move_to_store_id
   AND CURRENT_DATE BETWEEN sm.dat_rec_start AND sm.dat_rec_end

   LEFT OUTER JOIN p_lew_bil_ac.v_sm_map_item_container_str_1 sm_hist
   ON a.client_id = sm_hist.client_id
   AND a.item_sid = sm_hist.item_sid
   AND osm.loc_sid_store_move_to = sm_hist.move_to_store_id
   AND a.booking_dat BETWEEN sm_hist.dat_rec_start AND sm_hist.dat_rec_end
;
