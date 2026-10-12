/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_INVENTORY_DIFF_BASE_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_INVENTORY_DIFF_BASE_2
(
 client_id
,iso_cd
,cy_month
,kpi_aspect
,wh_id
,wh_descr
,v_id
,v_descr
,currency_iso_cd
,inventory_diff_sic_val      /* inventurdifferenzenlautsic */
,inventory_turnover_sic_val  /* inventurumsatzlautsic */
,inventory_diff_percent      /* inventurdifferenz_procent */
 )
AS
   SELECT
     inv_base.client_id,
   inv_base.iso_cd                                 AS iso_cd,
   inv_base.cy_month                               AS cy_month,
   inv_base.aspect_cd                              AS kpi_aspect,
   inv_base.wh_id                                  AS wh_id,
   UPPER(SUBSTRING(inv_base.wh_descr, 1, 3))AS wh_descr,
   inv_base.v_id                                   AS v_id,
   UPPER(SUBSTRING(inv_base.v_descr, 1, 3)) AS v_descr,
   inv_base.currency_iso_cd                        AS currency_iso_cd,
   inv_base.inventory_diff_sic_val                 AS inventory_diff_sic_val,
   inv_base.inventory_turnover_sic_val             AS inventory_turnover_sic_val,
   inv_base.inventory_diff_percent                 AS inventory_diff_percent
   FROM
   (
   (
   /*
   #----------------------------------------------------------------------------
   #WAWI Laender
   #----------------------------------------------------------------------------
   */
   SELECT
     invs.client_id                                                                                       AS client_id,
   cl.src_country_lidl_cd                                                                               AS iso_cd,
   cal.busyear                                                                                          AS busyear,
   cal.cy_month                                                                                         AS cy_month,
   MAX(CASE WHEN asp.aspect_id = 1 THEN wh.src_wh_id ELSE 0 END) OVER (PARTITION BY whma.parent_wh_loc_sid ) AS wh_id,
   MAX(CASE WHEN asp.aspect_id = 1 THEN whma.wh_desc ELSE '' END) OVER (PARTITION BY whma.parent_wh_loc_sid )AS wh_descr,
   (CASE WHEN asp.aspect_id = 1 THEN 'BGES' ELSE 'VGES' END)                                            AS aspect_cd,
   (CASE WHEN asp.aspect_id = 2 THEN wh.src_wh_id ELSE null END)                                        AS v_id,
   (CASE WHEN asp.aspect_id = 2 THEN whma.wh_desc ELSE '' END)                                          AS v_descr,
   SUM(invs.diff_net_inv)                                                                               AS inventory_diff_sic_val,
   SUM(invs.val_retail_store_net_inv_stc)                                                               AS inventory_turnover_sic_val,
   cry.curr_cd_to                                                                                       AS currency_iso_cd,
   ZEROIFNULL((((inventory_diff_sic_val)/ CASE WHEN inventory_turnover_sic_val = 0 THEN null ELSE inventory_turnover_sic_val END)*100))                  AS inventory_diff_percent
   FROM p_lew_core_ac.v_wawi_inv_store_2 AS invs
   INNER JOIN p_lew_core_ac.v_client_2 AS cl
   ON invs.client_id = cl.client_id
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cal
   ON invs.dat_formdate = cal.cal_dt
   INNER JOIN p_lew_core_ac.v_cal_busyear_2 AS byr
   ON byr.busyear = cal.busyear
   AND byr.cy_by_seq IN (0,-1)
   INNER JOIN p_lew_core_ac.v_wawi_org_store_merge_act_2 AS asp
   ON asp.client_id = invs.client_id
   AND asp.st_loc_sid = invs.st_loc_sid
   INNER JOIN p_lew_core_ac.v_wawi_org_wh_merge_act_2 AS whma
   ON whma.client_id = asp.client_id
   AND whma.wh_loc_sid = asp.wh_loc_sid
   AND whma.aspect_id = asp.aspect_id
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
   ON wh.client_id = whma.client_id
   AND wh.loc_sid_wh = whma.wh_loc_sid
   AND CURRENT_DATE BETWEEN wh.dwh_valid_from AND wh.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_2 AS cry
   ON invs.client_id = cry.client_id
   AND cry.curr_cd_from = 'EUR' /* Filtering for Home currency */
   AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt     /*  latest rate (point in history)  */
   AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to     /*  latest history (version)  */
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 AS ert
   ON ert.client_id = cry.client_id
   AND ert.x_rate_type_sid = cry.x_rate_type_sid
   AND ert.src_kurst = '@BEWE'
 WHERE
 /*
 #----------------------------------------------------------------------------
 #Diese Teilmenge stellt wahrscheinlich die Vollinventuren dar ggue. den ausgeblendeten Teilinventuren (mit inv_fg=73 ?)
 #71:Inventur_2
 #73:Tageszaehlung
 #----------------------------------------------------------------------------
 */
      invs.inv_fg = 71 AND
 /*
 #----------------------------------------------------------------------------
 #Die Einschraenkung status_inv_sic = 64 kann nicht interpretiert werden. Es gibt noch Auspraegungen ""-99"" und ""0"" ohne Hinweis auf die Bedeutung.
 #=> Einfache Uebernahme aus der Alt-View.
 #64: Inventur_2 ist gespeichert und gebucht
 #----------------------------------------------------------------------------
 */
     invs.status_inv_sic = 64
 /*
 #----------------------------------------------------------------------------
 #moeglicherweise wegzulassende Einschaenkungen - falls obige Kommentierung falsch sein sollte, bitte wieder hereinnehmen
 #----------------------------------------------------------------------------
 */
 AND asp.test_store_fg= 0 AND
     asp.mis_store_active_fg = 1
 GROUP BY
   invs.client_id
  ,cl.src_country_lidl_cd
  ,cal.busyear
  ,cal.cy_month
  ,wh.src_wh_id
  ,whma.wh_desc
  ,asp.aspect_id
  ,cry.exchange_rate
  ,cry.curr_cd_to
  ,whma.parent_wh_loc_sid
 )
 UNION ALL
 (
 /*
 #----------------------------------------------------------------------------
 #SAP Laender
 #----------------------------------------------------------------------------
 */

 SELECT
   aisd.client_id                                                                                                   AS client_id,
   cl.src_country_lidl_cd                                                                                           AS iso_cd,
   cal.busyear                                                                                                      AS busyear,
   aisd.cy_month                                                                                                    AS cy_month,
   MAX(CASE WHEN asp.aspect_id = 1 THEN wh.src_wh_id ELSE 0 END) OVER (PARTITION BY whma.parent_wh_loc_sid )             AS wh_id,
   MAX(CASE WHEN asp.aspect_id = 1 THEN  whma.wh_desc ELSE '' END) OVER (PARTITION BY whma.parent_wh_loc_sid )           AS wh_descr,
   (CASE WHEN asp.aspect_id = 1 THEN 'BGES' ELSE 'VGES' END)                                                        AS aspect_cd,
   (CASE WHEN asp.aspect_id = 2 THEN wh.src_wh_id ELSE null END)                                                    AS v_id,
   (CASE WHEN asp.aspect_id = 2 THEN whma.wh_desc ELSE '' END)                                                      AS v_descr,
   SUM(COALESCE(aisd.diff_inv_stc_calc_net_val, 0) + COALESCE(aisd.diff_inv_return_net_val, 0))                     AS inventory_diff_sic_val,
   SUM(COALESCE(aisd.retail_net_val ,0))                                                                            AS inventory_turnover_sic_val,
   cry.curr_cd_to                                                                                                   AS currency_iso_cd,
   ZEROIFNULL((((inventory_diff_sic_val)/ CASE WHEN inventory_turnover_sic_val = 0 THEN null ELSE inventory_turnover_sic_val END)*100))                              AS inventory_diff_percent
   FROM p_lew_bil_ac.v_agg_item_store_day_2 AS aisd
   INNER JOIN p_lew_core_ac.v_client_2 AS cl
   ON aisd.client_id = cl.client_id
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cal
   ON aisd.dwh_cal_dt = cal.cal_dt
   INNER JOIN p_lew_core_ac.v_cal_busyear_2 AS byr
   ON byr.busyear = cal.busyear
   AND byr.cy_by_seq IN (0,-1)
   INNER JOIN p_lew_core_ac.v_wawi_org_store_merge_act_2 AS asp
   ON asp.client_id = aisd.client_id
   AND asp.st_loc_sid = aisd.loc_sid_store
   INNER JOIN p_lew_core_ac.v_wawi_org_wh_merge_act_2 AS whma
   ON whma.client_id = asp.client_id
   AND whma.wh_loc_sid = asp.wh_loc_sid
   AND whma.aspect_id = asp.aspect_id
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
   ON wh.client_id = whma.client_id
   AND wh.loc_sid_wh = whma.wh_loc_sid
   AND CURRENT_DATE BETWEEN wh.dwh_valid_from AND wh.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_2 AS cry
   ON cry.client_id = aisd.client_id
   AND cry.curr_cd_from = 'EUR' /* Filtering for Home currency */
   AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt    /*  latest rate (point in history)  */
   AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to    /*  latest history (version)  */
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 AS ert
   ON cry.client_id = ert.client_id
   AND cry.x_rate_type_sid = ert.x_rate_type_sid
   AND ert.src_kurst = '@BEWE'
  GROUP BY
    aisd.client_id
   ,cl.src_country_lidl_cd
   ,cal.busyear
   ,aisd.cy_month
   ,wh.src_wh_id
   ,whma.wh_desc
   ,asp.aspect_id
   ,cry.exchange_rate
   ,cry.curr_cd_to
   ,whma.parent_wh_loc_sid
  )
  ) AS inv_base
   ;