/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_bw_val_net_perform_hr_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  14.04.2021    Ulrich Ross                  Change for the new double digit WGI number
#                                                  https://jira.schwarz/browse/DDLE-1685
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_bw_val_net_perform_hr_1
 (
 client_id
,iso_cd
,cy_month
,calender_day
,orig_store_id
,currency_iso_cd
,net_store_productivity_val
,net_working_hrs
,turnover_val
,gross_working_hrs
,item_qty
)
AS
   (SELECT
   COALESCE(asis.client_id, apd.client_id)                                                                                                               AS client_id,
   cl.src_country_lidl_cd                                                                                                                               AS iso_cd,
   cal.cy_month                                                                                                                                         AS cy_month,
   TO_CHAR(COALESCE(asis.dwh_cal_dt,ext.dat_formdate),'YYYYMMDD')                                                                                       AS calender_day,
   str.src_orig_store_nr                                                                                                                                AS orig_store_id,
   cry.curr_cd_to                                                                                                                                       AS currency_iso_cd,
   ROUND(CAST(SUM(ext.val_rtl_net) AS DECIMAL (18,5))/ CASE WHEN SUM(ZEROIFNULL(asis.work_time_net_hr)+ ZEROIFNULL(asis.perform_relev_absence_hr)) = 0 THEN null ELSE SUM(ZEROIFNULL(asis.work_time_net_hr)+ ZEROIFNULL(asis.perform_relev_absence_hr)) END,2)  AS net_store_productivity_val,
   ROUND(SUM(asis.work_time_net_hr),2)                                                                                                                  AS net_working_hrs,
   ROUND(CAST(SUM(ext.val_rtl_net) AS DECIMAL (18,5)),2)                                                                                                AS turnover_val,
   ROUND(SUM(ZEROIFNULL(asis.work_time_net_hr)+ZEROIFNULL(asis.perform_relev_absence_hr)),2)                                                            AS gross_working_hrs,
   apd.item_qty                                                                                                                                         AS item_qty
   FROM p_lew_bil_ac.v_agg_work_time_store_day_1 AS asis
   FULL OUTER JOIN (SELECT
   SUM(a.sales_piece_qty + a.sales_weight_qty + a.return_qty) AS item_qty,
   a.client_id,
   a.dwh_cal_dt,
   a.cy_month,
   a.loc_sid_store
   FROM p_lew_bil_ac.v_agg_pos_store_item_day_1 AS a
   INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS cal
   ON a.dwh_cal_dt = cal.cal_dt
   INNER JOIN p_lew_core_ac.v_cal_busyear_1 AS byr
   ON byr.busyear = cal.busyear
   AND byr.cy_by_seq IN (0,-1)
   INNER JOIN
   (SELECT
   a.client_id AS client_id,
   CAST(a.item_sid AS DECIMAL(18,0)) AS item_id,
   CASE WHEN cmp.active_fg = 0 THEN wawi.subitemgroup_id ELSE CAST(e.src_matkl AS INTEGER) END AS subitemgroup_id
   FROM p_lew_core_ac.v_item_1 AS a
   INNER JOIN p_lew_core_ac.v_item_hist_1 AS b
   ON b.client_id = a.client_id
   AND b.item_sid = a.item_sid
   AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_client_migration_per_1 AS cmp    --To identify WAWI or ELWIS client

   ON a.client_id = cmp.client_id
   LEFT JOIN p_lew_core_ac.v_wawi_itm_item_act_1 AS wawi
   ON wawi.client_id = a.client_id
   AND wawi.item_sid = a.item_sid
   LEFT JOIN p_lew_core_ac.v_item_group_1 AS e
   ON e.client_id = b.client_id
   AND e.item_grp_sid = b.item_grp_sid
 WHERE TRY_CAST(COALESCE(a.src_orig_item_nr,a.config_item_cd,a.src_matnr) AS DECIMAL(18,0)) IS NOT NULL
   ) AS ith
   ON a.client_id = ith.client_id
   AND a.item_sid = ith.item_id
   INNER JOIN
   (SELECT
   max_az.subitemgroup_id,
   MAX(max_az.itemgroup_int_id) AS itemgroup_int_id
   FROM (
/* Nur die Zuordnungen übernehmen, die am Häufigsten auftreten
    Sollten Zuordnungen gleichhäufig auftreten, wird über die anschließende Gruppierung im äußersten Select per MAX()-Funktion willkürlich ein Datensatz bestimmt. Dieser Fall ist bisher nicht bekannt und stellt nur einen Sicherheitsmechanismus dar. */
SELECT
   az.subitemgroup_id,
   az.itemgroup_int_id
   FROM (
/* Alle aktuellen, distinkten Subitemgroup (SIG) - Mainitemgroup - Itemgroup_International (WGI) Zuordnungen bestimmen
    Dazu die Anz. an Client-übergreifenden Zuordnungen  ermitteln. Dies ist notwendig, falls Sonderfälle bestehen, bei denen nicht für alle Clients die gleichen Zuordnungen bestehen.
    Hierzu ist ein Sonderfall für die SIG 199 bekannt, bei der Client 4 eine_1 andere WGI als alle anderen Clients hat. Hierbei soll Client-übergreifend die WGI der Mehrheit angezeigt werden, damit pro SIG nur ein Satz zurückgegeben wird. */
SELECT DISTINCT
   TRY_CAST(s.src_subitemgrp_cd AS INTEGER)   AS subitemgroup_id,
   COALESCE(h.main_item_grp_cd, '-1')      AS mainitemgroup_id,
   TRY_CAST(h.item_grp_int_cd AS INTEGER)   AS itemgroup_int_id,
   COUNT(*) OVER (PARTITION BY s.src_subitemgrp_cd, COALESCE(h.main_item_grp_cd, ''), h.item_grp_int_cd) AS anz_zuordnungen
   FROM p_lew_core_ac.v_subitemgroup_1 AS s
   INNER JOIN p_lew_core_ac.v_subitemgroup_hist_1 AS h
   ON s.client_id = h.client_id
   AND s.sub_item_grp_sid = h.sub_item_grp_sid
AND CURRENT_DATE BETWEEN h.dwh_valid_from AND h.dwh_valid_to
) AS az
   QUALIFY az.anz_zuordnungen = MAX(az.anz_zuordnungen) OVER (PARTITION BY az.subitemgroup_id, az.mainitemgroup_id, az.itemgroup_int_id)
   ) AS max_az
   GROUP BY max_az.subitemgroup_id
   ) AS sih
   ON ith.subitemgroup_id = sih.subitemgroup_id

   WHERE a.discount_sid = -1 AND sih.itemgroup_int_id IN (1, 2, 3, 4, 5, 6, 7, 9, 10, 20, 30, 32, 40, 50, 60, 70, 90)
   GROUP BY  a.client_id
   , a.dwh_cal_dt
   , a.loc_sid_store
   , a.cy_month
   ) AS apd
   ON asis.client_id = apd.client_id
   AND asis.dwh_cal_dt = apd.dwh_cal_dt
   AND asis.loc_sid_store = apd.loc_sid_store
   INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS cal
   ON COALESCE(asis.dwh_cal_dt, apd.dwh_cal_dt) = cal.cal_dt
   INNER JOIN p_lew_core_ac.v_cal_busyear_1 AS byr
   ON byr.busyear = cal.busyear
   AND byr.cy_by_seq IN (0,-1)
   INNER JOIN p_lew_core_ac.v_client_1 AS cl
   ON COALESCE(asis.client_id, apd.client_id) = cl.client_id
   INNER JOIN p_lew_bil_ac.v_store_1 AS str
   ON COALESCE(asis.client_id, apd.client_id) = str.client_id
   AND COALESCE(asis.loc_sid_store, apd.loc_sid_store) = str.loc_sid_store
   AND str.dwh_actual_fg = 1
   LEFT OUTER JOIN p_lew_bil_ac.v_agg_store_day_turnover_ext_1 AS ext
   ON ext.client_id      = COALESCE(asis.client_id, apd.client_id)
   AND ext.loc_sid_store  = COALESCE(asis.loc_sid_store, apd.loc_sid_store)
   AND ext.dat_formdate   = COALESCE(asis.dwh_cal_dt, apd.dwh_cal_dt)
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS cry
   ON COALESCE(asis.client_id, apd.client_id)    = cry.client_id
   AND cry.curr_cd_from = 'EUR'
   AND ext.currency_iso_cd = cry.curr_cd_to
   AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 AS ert
   ON ert.client_id = COALESCE(asis.client_id, apd.client_id)
   AND ert.x_rate_type_sid = cry.x_rate_type_sid
   AND ert.src_kurst = '@BEWE'


   GROUP BY  COALESCE(asis.client_id, apd.client_id)
    ,cl.src_country_lidl_cd
    ,cal.cy_month
    ,calender_day
    ,str.src_orig_store_nr
    ,cry.curr_cd_to
    ,apd.item_qty
   )
   ;