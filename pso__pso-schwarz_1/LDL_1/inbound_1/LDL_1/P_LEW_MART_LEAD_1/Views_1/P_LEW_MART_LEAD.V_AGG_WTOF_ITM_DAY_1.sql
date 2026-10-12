CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_WTOF_ITM_DAY_1(
  client_id
, item_sid
, loc_sid_store_move_to
, wh_loc_sid
, wh_id
, aspect_id
, currency_iso_cd
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
) AS
/*
#----------------------------------------------------------------------------
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
#  1.6  2020-01-30  Chandramani Kumbhale   Added Anlieferung Qualität Filiale stk per kg column and join for warehouse ID
#                                          20200130_2363_Anlieferung_qual_fil_stkkg_Rep4
#                                          https://jira.schwarz/browse/REP4-4768
#  1.7  2021-04-19  Marcin Malec           Reverted part of v1.6 - brought back warehouse ID columns
#                                          https://jira.schwarz/browse/REP2-9405
#  1.8  2022-10-07  Michael Morris         Changes: move_to_store_id reverted back to loc_sid_store in source table. wh_id, aspect_id and loc_sid_wh removed from source
#                                          table and added here. User Story 387869 for incident INC5283614.
#
#----------------------------------------------------------------------------
*/
SELECT DISTINCT agg.client_id
       , agg.item_sid
       , osm.move_to_store_id
       , osm.loc_sid_wh
       , osm.wh_id
       , osm.aspect_id
       , cry.curr_cd_from AS currency_iso_cd
       , agg.dat_formdate
       , agg.cy_week
       , agg.cy_month
       , agg.busyear
       , SUM(agg.sfo_total_qty_brok                       )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_brok
       , SUM(agg.sfo_total_qty_mhd                        )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_mhd
       , SUM(agg.sfo_total_qty_wtof                       )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_wtof
       , SUM(agg.sfo_total_qty_brok_wh                    )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_brok_wh
       , SUM(agg.sfo_total_qty_rl_defct                   )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_rl_defct
       , SUM(agg.sfo_total_qty_ald_excd                   )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_ald_excd
       , SUM(agg.sfo_total_qty_rem_utl                    )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_rem_utl
       , SUM(agg.sfo_total_qty_hi_vlnc                    )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_hi_vlnc
       , SUM(agg.sfo_total_qty_dntn                       )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_dntn
       , SUM(agg.sfo_total_qty_gd_rmv                     )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_gd_rmv
       , SUM(COALESCE(agg.sfo_total_qty_disc,0)           )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_disc
       , SUM(COALESCE(agg.sfo_total_qty_veh_brk ,0)       )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_veh_brk
       , SUM(COALESCE(agg.sfo_total_qty_frc_maj ,0)       )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_frc_maj
       , SUM(COALESCE(agg.sfo_total_qty_dnt ,0)           )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_dnt
       , SUM(COALESCE(agg.sfo_total_qty_gd_remv_wh ,0)    )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_gd_remv_wh
       , SUM(COALESCE(agg.sfo_total_qty_veh_brk_wh ,0)    )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_veh_brk_wh
       , SUM(COALESCE(agg.sfo_total_qty_cmpnt_dir_delv ,0))  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_cmpnt_dir_delv
       , SUM(COALESCE(agg.sfo_total_qty_oth_lost_gd ,0)   )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_oth_lost_gd
       , SUM(COALESCE(agg.sfo_total_qty_del_qual_str ,0)  )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_del_qual_str
       , SUM(COALESCE(agg.sfo_total_qty_wtof_tot  ,0)     )  OVER (PARTITION BY agg.client_id, osm.move_to_store_id, osm.aspect_id, cry.curr_cd_from, agg.item_sid, agg.dat_formdate) AS sfo_total_qty_wtof_tot
   
  FROM p_lew_mart_lead.t_agg_wtof_itm_day_1      AS agg
  
 INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge_1     AS osm
    ON agg.client_id      = osm.client_id
   AND agg.loc_sid_store  = osm.store_id
   
 INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS cry
    ON agg.client_id      = cry.client_id
   AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   
 INNER JOIN p_lew_core_ac.v_exchange_rate_type_1       AS c
    ON c.client_id        = cry.client_id
   AND c.x_rate_type_sid  = cry.x_rate_type_sid
   AND c.src_kurst        = '@BEWE'
;