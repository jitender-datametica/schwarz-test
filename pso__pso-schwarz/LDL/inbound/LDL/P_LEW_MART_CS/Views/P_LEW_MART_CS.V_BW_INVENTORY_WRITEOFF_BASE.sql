/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_INVENTORY_WRITEOFF_BASE
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_INVENTORY_WRITEOFF_BASE
(
 client_id
,iso_cd
,cy_month
,kpi_aspect
,aspect_id
,wh_id
,v_id
,currency_iso_cd
,abschriften_betrieb
,abschriften_filiale
,abschriften_warengeschaeft
,restantenverwertung
,rabattierung
 )
AS

   SELECT client_id                                                            AS client_id,
   iso_cd                                                              AS iso_cd,
   cy_month                                                            AS cy_month,
   kpi_aspect                                                          AS kpi_aspect,
   aspect_id                                                           AS aspect_id,
   wh_id                                                               AS wh_id,
   v_id                                                                AS v_id,
   currency_iso_cd                                                     AS currency_iso_cd,
   (bruch_lager+wlzfehler)                              AS abschriften_betrieb,
   (mhd_filiale + bruch_filiale)                        AS abschriften_filiale,
   (ald_ueberschritten + restantenverwertung_aktion)     AS abschriften_warengeschaeft,
   (restantenverwertung_aktion)                          AS restantenverwertung,
   (rabattierung)                                        AS rabattierung
       FROM
           (
            SELECT abschriften.client_id  AS client_id,
   cty.src_country_lidl_cd   AS iso_cd,
   abschriften.cy_month     AS cy_month,
   CASE WHEN abschriften.aspect_id = 1 THEN 'BGES' ELSE 'VGES' END    AS kpi_aspect,
   abschriften.aspect_id,
   abschriften.wh_id                                                                                                 AS wh_id,
   abschriften.v_id                                                                                                  AS v_id,
   curr.curr_cd_to                                                                                                   AS currency_iso_cd,
   SUM((CASE WHEN (abschriften.sfotype_id IN (182, 192) AND abschriften.pcwo_reason_id IN (23)) THEN abschriften.val ELSE 0 END))  AS bruch_lager,
   SUM((CASE WHEN (abschriften.sfotype_id IN (182, 192) AND abschriften.pcwo_reason_id IN (24)) THEN abschriften.val ELSE 0 END))   AS wlzfehler,
   SUM((CASE WHEN (abschriften.sfotype_id IN (137, 147) AND abschriften.pcwo_reason_id IN (1, 127, 134, 135))  THEN abschriften.val  ELSE 0  END))  AS mhd_filiale,
   SUM((CASE WHEN (abschriften.sfotype_id IN (137, 147) AND abschriften.pcwo_reason_id IN (2, 128)) THEN abschriften.val  ELSE 0  END))  AS bruch_filiale,
   SUM((CASE WHEN ((abschriften.sfotype_id IN (182, 192) AND abschriften.pcwo_reason_id IN (21))  OR (abschriften.sfotype_id IN (181, 191) AND abschriften.pcwo_reason_id IN (83)))  THEN abschriften.val  ELSE 0  END))  AS ald_ueberschritten,
   SUM((CASE WHEN (abschriften.sfotype_id IN (182, 192) AND abschriften.pcwo_reason_id IN (22, 126)) THEN abschriften.val  ELSE 0  END))  AS restantenverwertung_aktion,
   SUM((CASE WHEN (abschriften.sfotype_id IN (137, 147) AND abschriften.pcwo_reason_id in (5))  THEN abschriften.val ELSE 0  END)) AS rabattierung,
   curr.exchange_rate  AS exchange_rate
              FROM (
                    SELECT agg.client_id                         AS client_id,
   CASE WHEN osm.aspect_id = 1 THEN stw.loc_sid_wh  ELSE osm.wh_loc_sid END  AS wh_loc_sid,
   stw.orig_wh_nr    AS wh_id,
   CASE WHEN osm.aspect_id = 2  THEN wh.src_wh_id  ELSE NULL  END  AS v_id,
   agg.cy_month                          AS cy_month,
   osm.aspect_id                         AS aspect_id,
   agg.sfotype_id                        AS sfotype_id,
   agg.pcwo_reason_id                    AS pcwo_reason_id,
   agg.sfo_total_rtl_rl_net_val_asis     AS  val
                      FROM p_lew_bil_ac.v_agg_store_day_sfo agg
   INNER JOIN p_lew_core_ac.v_wawi_org_store_merge_act osm
   ON agg.client_id = osm.client_id AND agg.loc_sid_store = osm.st_loc_sid
   INNER JOIN p_lew_core_ac.v_wawi_org_wh_merge_act AS owm
   ON osm.client_id = owm.client_id
   AND osm.wh_loc_sid = owm.wh_loc_sid
   AND osm.aspect_id = owm.aspect_id
   INNER JOIN p_lew_bil_ac.v_warehouse wh
   ON osm.client_id = osm.client_id AND osm.wh_loc_sid = wh.loc_sid_wh AND wh.dwh_valid_to = TO_DATE('12/30/9999', 'MM/DD/YYYY')
   INNER JOIN p_lew_core_ac.v_cal_calendarday cal
   ON agg.booking_dat = cal.cal_dt AND cal.busyear_seq IN (0,-1)
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse AS stw
   ON stw.client_id = agg.client_id AND stw.loc_sid_store = osm.move_to_st_loc_sid AND stw.dwh_valid_to = TO_DATE('12/30/9999', 'MM/DD/YYYY')
   WHERE (agg.sfotype_id IN (182, 192) AND agg.pcwo_reason_id IN (23, 24, 21, 22, 126))
         OR (agg.sfotype_id IN (137, 147) AND agg.pcwo_reason_id IN (1, 127, 134, 135, 2, 128, 5))
) AS abschriften
   INNER JOIN
   (
    SELECT curr.exchange_rate,
   curr.client_id,
   curr.curr_cd_to
                 FROM p_lew_core_ac.v_exchange_rate_known_hist curr
   INNER JOIN p_lew_core_ac.v_exchange_rate_type ert
   ON curr.x_rate_type_sid = ert.x_rate_type_sid AND ert.src_kurst = '@BEWE' AND curr.curr_cd_from = 'EUR' AND curr.dwh_valid_to = TO_DATE('12/30/9999', 'MM/DD/YYYY')
   WHERE CURRENT_DATE BETWEEN curr.active_from_dt AND curr.active_to_dt
) AS curr
   ON abschriften.client_id = curr.client_id
   INNER JOIN p_lew_core_ac.v_country cty
   ON abschriften.client_id = cty.country_sid
   GROUP BY abschriften.client_id
            ,cty.src_country_lidl_cd
            ,abschriften.cy_month
            ,abschriften.wh_id
            ,abschriften.v_id
            ,abschriften.wh_loc_sid
            ,curr.curr_cd_to
            ,abschriften.aspect_id
            ,curr.exchange_rate
) AS abschriften

   ;