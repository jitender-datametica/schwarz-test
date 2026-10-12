/* #----------------------------------------------------------------------------
#  1.0  2018-10-16  Chandramani K          Initial Version
#                                          Patch 20181015_1861_Wtof_Item_Day_Brd_Rep5
#                                          https://jira-lidl-public.pixsoftware.de/browse/LEAD05-1604
#                                          https://jira-lidl-public.pixsoftware.de/browse/IDMO-1147
#  1.1  2018-12-23  Kiran N                Two columns added for 'ALD überschritten' and 'Restantenverwertung' 
#                                          Patch 20181224_1908_Abschriften_Warengeschäft_stkkg_Rep5
#                                          https://jira-lidl-public.pixsoftware.de/browse/LEAD05-1625
#                                          https://jira-lidl-public.pixsoftware.de/browse/IDMO-1348
#  1.2  2018-01-02  Kiran N                Changes naming convension for 'ALD überschritten'  
#                                          Patch 20181224_1908_Abschriften_Warengeschäft_stkkg_Rep5
#                                          https://jira-lidl-public.pixsoftware.de/browse/LEAD05-1625
#                                          https://jira-lidl-public.pixsoftware.de/browse/IDMO-1348
#  1.3  2019-02-25  Chandramani Kumbhale   Added three columns 'sfo_total_qty_hi_vlnc', 'sfo_total_qty_dntn' & 'sfo_total_qty_gd_rmv' for KPI Sonstige Warenverluste Filiale Stk./kg
#                                          20181224_1908_Abschriften_Warengeschäft_stkkg_Rep5
#                                          https://jira-lidl-public.pixsoftware.de/browse/LEAD05-1673
#  1.4  2019-07-24  Kiran N                Added Rabattierung stk per kg column
#                                          20190724_2168_Rabattierung_Rep5
#                                          https://jira-lidl-public.pixsoftware.de/browse/LEAD05-4043
#  1.5  2019-10-14  Kiran N                Added Sonstige Warenverluste WG,Betrieb ,Anlieferung  and Abshriften Gesamt in stk/kg.
#                                          20191014_2249_Quantity_KPI_LEAD_Rep5
#                                          https://jira-lidl-public.pixsoftware.de/browse/LEAD05-4044
#  1.6  2020-01-30  Chandramani Kumbhale   Added Anlieferung Qualität Filiale stk per kg column and CROSS JOIN for warehouse ID
#                                          20200130_2363_Anlieferung_qual_fil_stkkg_Rep4
#                                          https://jira.schwarz/browse/REP4-4768
#  1.7  2021-04-19  Marcin Malec           Reverted part of v1.6 - brought back warehouse ID columns
#                                          https://jira.schwarz/browse/REP2-9405
#  1.8  2022-10-07  Michael Morris         Changes: move_to_store_id reverted back to loc_sid_store in source table. wh_id, aspect_id and loc_sid_wh removed from source
#                                          table and added here. User Story 387869 for incident INC5283614.
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_wtof_itm_day_1 (client_id, item_sid, loc_sid_store_move_to, wh_loc_sid,
wh_id, aspect_id, currency_iso_cd, dat_formdate, cy_week, cy_month, busyear, sfo_total_qty_brok, sfo_total_qty_mhd,
sfo_total_qty_wtof, sfo_total_qty_brok_wh, sfo_total_qty_rl_defct, sfo_total_qty_ald_excd, sfo_total_qty_rem_utl,
sfo_total_qty_hi_vlnc, sfo_total_qty_dntn, sfo_total_qty_gd_rmv, sfo_total_qty_disc, sfo_total_qty_veh_brk,
sfo_total_qty_frc_maj, sfo_total_qty_dnt, sfo_total_qty_gd_remv_wh, sfo_total_qty_veh_brk_wh,
sfo_total_qty_cmpnt_dir_delv, sfo_total_qty_oth_lost_gd, sfo_total_qty_del_qual_str, sfo_total_qty_wtof_tot) AS SELECT
DISTINCT AGG.client_id,
 AGG.item_sid,
 OSM.move_to_store_id AS loc_sid_store_move_to,
 OSM.loc_sid_wh AS wh_loc_sid,
 OSM.wh_id,
 OSM.aspect_id,
 CRY.curr_cd_from AS currency_iso_cd,
 AGG.dat_formdate,
 AGG.cy_week,
 AGG.cy_month,
 AGG.busyear,
 SUM(AGG.sfo_total_qty_brok) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING), CAST(OSM.aspect_id AS STRING)
    , CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS sfo_total_qty_brok,
 SUM(AGG.sfo_total_qty_mhd) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING), CAST(OSM.aspect_id AS STRING)
    , CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS sfo_total_qty_mhd,
 SUM(AGG.sfo_total_qty_wtof) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING), CAST(OSM.aspect_id AS STRING)
    , CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS sfo_total_qty_wtof,
 SUM(AGG.sfo_total_qty_brok_wh) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING), CAST(OSM.aspect_id AS STRING)
    , CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS sfo_total_qty_brok_wh,
 SUM(AGG.sfo_total_qty_rl_defct) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING)
    , CAST(OSM.aspect_id AS STRING), CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sfo_total_qty_rl_defct,
 SUM(AGG.sfo_total_qty_ald_excd) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING)
    , CAST(OSM.aspect_id AS STRING), CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sfo_total_qty_ald_excd,
 SUM(AGG.sfo_total_qty_rem_utl) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING), CAST(OSM.aspect_id AS STRING)
    , CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS sfo_total_qty_rem_utl,
 SUM(AGG.sfo_total_qty_hi_vlnc) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING), CAST(OSM.aspect_id AS STRING)
    , CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS sfo_total_qty_hi_vlnc,
 SUM(AGG.sfo_total_qty_dntn) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING), CAST(OSM.aspect_id AS STRING)
    , CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS sfo_total_qty_dntn,
 SUM(AGG.sfo_total_qty_gd_rmv) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING), CAST(OSM.aspect_id AS STRING)
    , CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS sfo_total_qty_gd_rmv,
 SUM(COALESCE(AGG.sfo_total_qty_disc, 0)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING)
    , CAST(OSM.aspect_id AS STRING), CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sfo_total_qty_disc,
 SUM(COALESCE(AGG.sfo_total_qty_veh_brk, 0)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING)
    , CAST(OSM.aspect_id AS STRING), CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sfo_total_qty_veh_brk,
 SUM(COALESCE(AGG.sfo_total_qty_frc_maj, 0)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING)
    , CAST(OSM.aspect_id AS STRING), CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sfo_total_qty_frc_maj,
 SUM(COALESCE(AGG.sfo_total_qty_dnt, 0)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING)
    , CAST(OSM.aspect_id AS STRING), CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sfo_total_qty_dnt,
 SUM(COALESCE(AGG.sfo_total_qty_gd_remv_wh, 0)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING)
    , CAST(OSM.aspect_id AS STRING), CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sfo_total_qty_gd_remv_wh,
 SUM(COALESCE(AGG.sfo_total_qty_veh_brk_wh, 0)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING)
    , CAST(OSM.aspect_id AS STRING), CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sfo_total_qty_veh_brk_wh,
 SUM(COALESCE(AGG.sfo_total_qty_cmpnt_dir_delv, 0)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING)
    , CAST(OSM.aspect_id AS STRING), CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sfo_total_qty_cmpnt_dir_delv,
 SUM(COALESCE(AGG.sfo_total_qty_oth_lost_gd, 0)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING)
    , CAST(OSM.aspect_id AS STRING), CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sfo_total_qty_oth_lost_gd,
 SUM(COALESCE(AGG.sfo_total_qty_del_qual_str, 0)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING)
    , CAST(OSM.aspect_id AS STRING), CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sfo_total_qty_del_qual_str,
 SUM(COALESCE(AGG.sfo_total_qty_wtof_tot, 0)) OVER (PARTITION BY CAST(AGG.client_id AS STRING), CAST(OSM.move_to_store_id AS STRING)
    , CAST(OSM.aspect_id AS STRING), CRY.curr_cd_from, CAST(AGG.item_sid AS STRING), AGG.dat_formdate RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sfo_total_qty_wtof_tot
FROM ldl_p_lew_mart_lead.t_agg_wtof_itm_day_1 AS AGG
 INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge_1 AS OSM ON AGG.client_id = OSM.client_id AND AGG.loc_sid_store = OSM
   .store_id
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE';