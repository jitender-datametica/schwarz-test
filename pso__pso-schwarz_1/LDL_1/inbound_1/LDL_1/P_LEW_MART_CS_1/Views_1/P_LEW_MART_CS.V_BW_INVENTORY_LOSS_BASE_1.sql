/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_INVENTORY_LOSS_BASE_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_INVENTORY_LOSS_BASE_1
(
 client_id
,iso_cd
,cy_month
,kpi_aspect
,aspect_id
,wh_id
,v_id
,currency_iso_cd
,warenverlust_anlieferung_val      /* sonstige Warenverluste Anlieferung */
,warenverlust_betrieb_val  /* sonstige Warenverluste Betrieb */
,warenverlust_filiale_val      /* sonstige Warenverluste Filiale */
,warenverlust_wg_val   /* sonstige Warenverluste WG (WarengeschÃ¸Âýft) */
,anlieferung_qual_filiale_val   /*Anlieferung QualitÃ¸Âýt Filiale */
 )
AS
   SELECT
       inv_base.client_id,
   inv_base.iso_cd                                 AS iso_cd,
   inv_base.cy_month                               AS cy_month,
   inv_base.kpi_aspect                             AS kpi_aspect,
   inv_base.aspect_id,
   inv_base.wh_id                                  AS wh_id,
   inv_base.v_id                                   AS v_id,
   inv_base.currency_iso_cd                        AS currency_iso_cd,
   ROUND(inv_base.warenverlust_anlieferung_val, 2) AS warenverlust_anlieferung_val,
   ROUND(inv_base.warenverlust_betrieb_val,2)      AS warenverlust_betrieb_val,
   ROUND(inv_base.warenverlust_filiale_val,2)      AS warenverlust_filiale_val,
   ROUND(inv_base.warenverlust_wg_val,2)           AS warenverlust_wg_val,
   ROUND(inv_base.anlieferung_qual_filiale_val,2)  AS anlieferung_qual_filiale_val
   FROM
   (
   (
   /*
   #----------------------------------------------------------------------------
   #WAWI Laender
   #----------------------------------------------------------------------------
   */
   SELECT
       warenverluste.client_id                                                                                               AS client_id,
   warenverluste.src_country_lidl_cd                                                                                    AS iso_cd,
   warenverluste.cy_month                                                                                               AS cy_month,
   CASE WHEN warenverluste.aspect_id = 1 THEN 'BGES' ELSE 'VGES' END                                                    AS kpi_aspect,
   warenverluste.aspect_id,
   warenverluste.src_wh_id                                                                                              AS wh_id,
   warenverluste.v_id                                                                                                   AS v_id,
   warenverluste.wh_loc_sid                                                                                             AS store_location,
   curr.curr_cd_to                                                                                                      AS currency_iso_cd,
   ROUND(SUM(fuhrenbruch_lager + reklamation_direktlieferung))                                     AS warenverlust_anlieferung_val,
   ROUND(SUM(fuhrenbruch_filiale + hoehere_gewalt_lager + spenden_lager + warenentnahme_lager))    AS warenverlust_betrieb_val,
   ROUND(SUM(hoehere_gewalt_filiale + spenden_filiale + warenentnahme_filiale))  AS warenverlust_filiale_val,
   ROUND(SUM(defektes_non_food_filiale))                                                           AS warenverlust_wg_val,
   ROUND(SUM(qualitaet_filiale))                                                                   AS anlieferung_qual_filiale_val
   FROM
   (
   SELECT
      agg.client_id,
   CASE WHEN osm.aspect_id = 1 THEN stw.orig_wh_nr END AS src_wh_id,
   CASE WHEN osm.aspect_id = 1 THEN stw.loc_sid_wh ELSE osm.wh_loc_sid END AS wh_loc_sid,
   agg.cy_month,
   osm.aspect_id,
   (CASE WHEN osm.aspect_id = 2 THEN wh.src_wh_id ELSE null END) AS v_id,
   cl.src_country_lidl_cd,
   ZEROIFNULL(SUM((CASE WHEN ((agg.sfotype_id IN (182, 192) AND agg.pcwo_reason_id IN (28)) OR (agg.sfotype_id IN (181, 191) AND agg.pcwo_reason_id IN (84))) THEN agg.sfo_total_rtl_rl_net_val_asis ELSE NULL END)))      AS fuhrenbruch_lager,
   ZEROIFNULL(SUM((CASE WHEN (agg.sfotype_id IN (182, 192) AND agg.pcwo_reason_id IN (27)) THEN agg.sfo_total_rtl_rl_net_val_asis ELSE NULL END)))                                                                         AS reklamation_direktlieferung,
   ZEROIFNULL(SUM((CASE WHEN ((agg.sfotype_id IN (182, 192) AND agg.pcwo_reason_id IN (26, 132)) OR (agg.sfotype_id IN (181, 191) AND agg.pcwo_reason_id IN (82))) THEN agg.sfo_total_rtl_rl_net_val_asis ELSE NULL END))) AS fuhrenbruch_filiale,
   ZEROIFNULL(SUM((CASE WHEN (agg.sfotype_id IN (182, 192) AND agg.pcwo_reason_id IN (29)) THEN agg.sfo_total_rtl_rl_net_val_asis ELSE NULL END)))                                                                         AS hoehere_gewalt_lager,
   ZEROIFNULL(SUM((CASE WHEN (agg.sfotype_id IN (182, 192) AND agg.pcwo_reason_id IN (31, 103, 104, 123, 124)) THEN agg.sfo_total_rtl_rl_net_val_asis ELSE NULL END)))                                                     AS spenden_lager,
   ZEROIFNULL(SUM((CASE WHEN (agg.sfotype_id IN (182, 192) AND agg.pcwo_reason_id IN (30, 105, 106, 107, 108, 109, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 125, 133)) THEN agg.sfo_total_rtl_rl_net_val_asis ELSE NULL END))) AS warenentnahme_lager,
   ZEROIFNULL(SUM((CASE WHEN (agg.sfotype_id IN (137, 147) AND agg.pcwo_reason_id IN (3)) THEN agg.sfo_total_rtl_rl_net_val_asis ELSE NULL END))) AS hoehere_gewalt_filiale,
   ZEROIFNULL(SUM((CASE WHEN (agg.sfotype_id IN (137, 147) AND agg.pcwo_reason_id IN (7, 130, 131)) THEN agg.sfo_total_rtl_rl_net_val_asis ELSE NULL END))) AS spenden_filiale,
   ZEROIFNULL(SUM((CASE WHEN (agg.sfotype_id IN (137, 147) AND agg.pcwo_reason_id IN (4, 101, 102, 110, 111, 129)) THEN agg.sfo_total_rtl_rl_net_val_asis ELSE NULL END))) AS warenentnahme_filiale,
   ZEROIFNULL(SUM((CASE WHEN (agg.sfotype_id IN (182, 192) AND agg.pcwo_reason_id IN (25)) THEN agg.sfo_total_rtl_rl_net_val_asis ELSE NULL END))) AS defektes_non_food_filiale,
   ZEROIFNULL(SUM((CASE WHEN(agg.sfotype_id IN (137, 147) AND agg.pcwo_reason_id IN(8)) THEN agg.sfo_total_rtl_rl_net_val_asis ELSE NULL END))) AS qualitaet_filiale
   FROM p_lew_bil_ac.v_agg_store_day_sfo_1 agg
   INNER JOIN p_lew_core_ac.v_wawi_org_store_merge_act_1 AS osm
   ON agg.client_id = osm.client_id
   AND agg.loc_sid_store = osm.st_loc_sid
   INNER JOIN p_lew_core_ac.v_wawi_org_wh_merge_act_1 AS owm
   ON osm.client_id = owm.client_id
   AND osm.wh_loc_sid = owm.wh_loc_sid
   AND osm.aspect_id = owm.aspect_id
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
   ON osm.client_id = osm.client_id
   AND osm.wh_loc_sid = wh.loc_sid_wh
   AND wh.dwh_valid_to = TO_DATE('12/30/9999', 'MM_1/DD/YYYY')
   INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS cal
   ON agg.booking_dat = cal.cal_dt
   AND cal.busyear_seq IN (0,-1)
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_1 AS stw
   ON stw.client_id = agg.client_id
   AND stw.loc_sid_store = osm.move_to_st_loc_sid
   AND stw.dwh_valid_to = TO_DATE('12/30/9999', 'MM_1/DD/YYYY')
   INNER JOIN p_lew_core_ac.v_client_1 AS cl
   ON agg.client_id = cl.client_id
   GROUP BY
       agg.client_id
      ,wh.src_wh_id
      ,stw.orig_wh_nr
      ,agg.cy_month
      ,osm.aspect_id
      ,stw.loc_sid_wh
      ,osm.wh_loc_sid
      ,cl.src_country_lidl_cd
      ,v_id
   ) AS warenverluste
   INNER JOIN
   (
SELECT curr.exchange_rate,
   curr.client_id,
   curr.curr_cd_to
FROM p_lew_core_ac.v_exchange_rate_known_hist_1 AS curr
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 AS ert
   ON curr.x_rate_type_sid = ert.x_rate_type_sid
   AND ert.src_kurst = '@BEWE'
   AND curr.curr_cd_from = 'EUR'
   AND curr.dwh_valid_to = TO_DATE('12/30/9999', 'MM_1/DD/YYYY')
 WHERE CURRENT_DATE BETWEEN curr.active_from_dt AND curr.active_to_dt
  ) AS curr
   ON warenverluste.client_id = curr.client_id

   GROUP BY
     warenverluste.client_id
    ,warenverluste.cy_month
    ,warenverluste.src_wh_id
    ,warenverluste.wh_loc_sid
    ,curr.curr_cd_to
    ,warenverluste.aspect_id
    ,curr.exchange_rate
    ,warenverluste.src_country_lidl_cd
    ,warenverluste.v_id
 )
 ) AS inv_base
   ;