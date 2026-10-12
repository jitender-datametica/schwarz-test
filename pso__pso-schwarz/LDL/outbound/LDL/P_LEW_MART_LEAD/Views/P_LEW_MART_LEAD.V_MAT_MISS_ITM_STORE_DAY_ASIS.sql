/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_MAT_MISS_ITM_STORE_DAY_ASIS
#----------------------------------------------------------------------------
# History:
#  1.0  09.12.2017    Kiran N                  Initial Version
#  1.1  09.03.2018    Aparna R                 Pointed calendar table to core layer
#  1.2  28.06.2018    Davis,Mike               replace lew_core_ac.v_wawi_agg_store_day_item_ejr with lew_bil_ac.v_agg_pos_store_item_day
#  1.3  27.03.2019    Thole,Jens               replace stock-base to new bil-object
#  1.4  19.06.2019    Kiran N                  Added Comments
#                                              Patch 20190408_2028_Fehlartikel_system_updates
#                                              https://jira-lidl-public.pixsoftware.de/browse/LEAD05-3383
#                                              https://jira-lidl-public.pixsoftware.de/browse/IDMO-1695
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_mat_miss_itm_store_day_asis (client_id OPTIONS(description='MIS Client ID'),
loc_sid_store OPTIONS(description='S-Key der Location, hier der Filiale'), item_sid
OPTIONS(description='S-Key fuer Item Id'), wh_loc_sid OPTIONS(description='S-Key fuer Gesellschaftsnummer'),
dat_formdate OPTIONS(description='Bezugsdatum'), cy_month
OPTIONS(description='Monat des Geschaeftsjahres im Format "JJJJMM"'), cy_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_week
OPTIONS(description='Geschaeftsjahr - Woche Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschaeftsjahr'),
miss_item_fg OPTIONS(description='Flag fuer Fehlartikel Filiale')) OPTIONS(DESCRIPTION = `VIEW`) AS SELECT Stc.client_id
 ,
 Stc.st_loc_sid AS loc_sid_store,
 Stc.item_sid,
 ORG.loc_sid_wh AS wh_loc_sid,
 Stc.dat_formdate,
 CAL.cy_month,
 CAL.cy_week_part AS cy_partial_week_id,
 CAL.cy_week,
 CAL.busyear,
  CASE
  WHEN EJR.client_id IS NULL AND DELI.client_id IS NULL
  THEN 1
  ELSE 0
  END AS miss_item_fg
FROM (SELECT client_id,
   loc_sid AS st_loc_sid,
   item_sid,
   dwh_cal_dt AS dat_formdate,
   stock_real_qty AS qty_stc_real
  FROM ldl_p_lew_bil_ac.v_stock_location_item AS WSSI
  WHERE stock_real_qty <= 0) AS Stc
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON Stc.dat_formdate = CAL.cal_dt
 INNER JOIN ldl_p_lew_bil_ac.v_item AS ITM ON Stc.client_id = ITM.client_id AND Stc.item_sid = ITM.item_sid AND Stc.dat_formdate
   BETWEEN ITM.dwh_valid_from AND ITM.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist AS SITM ON ITM.sub_item_grp_sid_asis = SITM.sub_item_grp_sid AND Stc.dat_formdate
   BETWEEN SITM.dwh_valid_from AND SITM.dwh_valid_to /* no sales */
 LEFT JOIN ldl_p_lew_bil_ac.v_agg_pos_store_item_day AS EJR ON Stc.client_id = EJR.client_id AND Stc.st_loc_sid = EJR.loc_sid_store
      AND Stc.item_sid = EJR.item_sid AND Stc.dat_formdate /* no delivery or supply */ = EJR.dwh_cal_dt
 LEFT JOIN ldl_p_lew_bil_ac.v_agg_deliv_base AS DELI ON Stc.client_id = DELI.client_id AND Stc.st_loc_sid = DELI.loc_sid_store
      AND Stc.item_sid = DELI.item_sid AND Stc.dat_formdate = DELI.dat_formdate
 LEFT JOIN ldl_p_lew_bil_ac.v_org_store_merge AS ORG ON Stc.client_id = ORG.client_id AND Stc.st_loc_sid = ORG.loc_sid_store
   /* WGI (item Groups) 1, 3, 4 , 5, 6 and 9 */
WHERE CAST(SITM.item_grp_int_cd AS INTEGER) IN (1, 3, 4, 5, 6, 9)
 AND ORG.aspect_id = 1
GROUP BY Stc.client_id,
 loc_sid_store,
 Stc.item_sid,
 wh_loc_sid,
 Stc.dat_formdate,
 CAL.cy_month,
 cy_partial_week_id,
 CAL.cy_week,
 CAL.busyear,
 miss_item_fg;