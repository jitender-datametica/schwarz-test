/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_bw_val_net_perform_hr_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  14.04.2021    Ulrich Ross                  Change for the new double digit WGI number
#                                                  https://jira.schwarz/browse/DDLE-1685
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_val_net_perform_hr_2 (client_id, iso_cd, cy_month, calender_day,
orig_store_id, currency_iso_cd, net_store_productivity_val, net_working_hrs, turnover_val, gross_working_hrs, item_qty)
AS -- To identify WAWI or ELWIS client

/* Nur die Zuordnungen übernehmen, die am Häufigsten auftreten
    Sollten Zuordnungen gleichhäufig auftreten, wird über die anschließende Gruppierung im äußersten Select per MAX()-Funktion willkürlich ein Datensatz bestimmt. Dieser Fall ist bisher nicht bekannt und stellt nur einen Sicherheitsmechanismus dar. */
/* Alle aktuellen, distinkten Subitemgroup (SIG) - Mainitemgroup - Itemgroup_International (WGI) Zuordnungen bestimmen
    Dazu die Anz. an Client-übergreifenden Zuordnungen  ermitteln. Dies ist notwendig, falls Sonderfälle bestehen, bei denen nicht für alle Clients die gleichen Zuordnungen bestehen.
    Hierzu ist ein Sonderfall für die SIG 199 bekannt, bei der Client 4 eine_2 andere WGI als alle anderen Clients hat. Hierbei soll Client-übergreifend die WGI der Mehrheit angezeigt werden, damit pro SIG nur ein Satz zurückgegeben wird. */
SELECT COALESCE(ASIS.client_id, apd.client_id) AS client_id,
 CL.src_country_lidl_cd AS iso_cd,
 CAL0.cy_month,
 FORMAT_DATE('%Y%m%d', COALESCE(ASIS.dwh_cal_dt, EXT.dat_formdate)) AS calender_day,
 STR.src_orig_store_nr AS orig_store_id,
 CRY.curr_cd_to AS currency_iso_cd,
 ROUND(CAST(SUM(EXT.val_rtl_net) AS NUMERIC) / CASE
    WHEN SUM(IFNULL(ASIS.work_time_net_hr, 0) + IFNULL(ASIS.perform_relev_absence_hr, 0)) = 0
    THEN NULL
    ELSE SUM(IFNULL(ASIS.work_time_net_hr, 0) + IFNULL(ASIS.perform_relev_absence_hr, 0))
    END, 2) AS net_store_productivity_val,
 ROUND(SUM(ASIS.work_time_net_hr), 2) AS net_working_hrs,
 ROUND(CAST(SUM(EXT.val_rtl_net) AS NUMERIC), 2) AS turnover_val,
 ROUND(SUM(IFNULL(ASIS.work_time_net_hr, 0) + IFNULL(ASIS.perform_relev_absence_hr, 0)), 2) AS gross_working_hrs,
 apd.item_qty
FROM ldl_p_lew_bil_ac.v_agg_work_time_store_day_2 AS ASIS
 FULL JOIN (SELECT SUM(A.sales_piece_qty + A.sales_weight_qty + A.return_qty) AS item_qty,
   A.client_id,
   A.dwh_cal_dt,
   A.cy_month,
   A.loc_sid_store
  FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day_2 AS A
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON A.dwh_cal_dt = CAL.cal_dt
   INNER JOIN ldl_p_lew_core_ac.v_cal_busyear_2 AS BYR ON CAL.busyear = BYR.busyear AND BYR.cy_by_seq IN (0, - 1)
   INNER JOIN (SELECT A0.client_id,
     CAST(A0.item_sid AS BIGNUMERIC) AS item_id,
      CASE
      WHEN CMP.active_fg = 0
      THEN WAWI.subitemgroup_id
      ELSE ROUND(CAST(E.src_matkl AS BIGNUMERIC), 0)
      END AS subitemgroup_id
    FROM ldl_p_lew_core_ac.v_item_2 AS A0
     INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS B ON A0.client_id = B.client_id AND A0.item_sid = B.item_sid AND
       CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
     INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS CMP ON A0.client_id = CMP.client_id
     LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS WAWI ON A0.client_id = WAWI.client_id AND A0.item_sid = WAWI.item_sid
       
     LEFT JOIN ldl_p_lew_core_ac.v_item_group_2 AS E ON B.client_id = E.client_id AND B.item_grp_sid = E.item_grp_sid) AS
   ith ON A.client_id = ith.client_id AND A.item_sid = ith.item_id
   INNER JOIN (SELECT subitemgroup_id,
     MAX(itemgroup_int_id) AS itemgroup_int_id
    FROM (SELECT subitemgroup_id,
       itemgroup_int_id
      FROM (SELECT DISTINCT ROUND(SAFE_CAST(S.src_subitemgrp_cd AS BIGNUMERIC), 0) AS subitemgroup_id,
         COALESCE(H.main_item_grp_cd, '-1') AS mainitemgroup_id,
         ROUND(SAFE_CAST(H.item_grp_int_cd AS BIGNUMERIC), 0) AS itemgroup_int_id,
         COUNT(*) OVER (PARTITION BY S.src_subitemgrp_cd, COALESCE(H.main_item_grp_cd, ''), H.item_grp_int_cd
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz_zuordnungen
        FROM ldl_p_lew_core_ac.v_subitemgroup_2 AS S
         INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist_2 AS H ON S.client_id = H.client_id AND S.sub_item_grp_sid = H.sub_item_grp_sid
             AND CURRENT_DATE BETWEEN H.dwh_valid_from AND H.dwh_valid_to) AS az
      QUALIFY anz_zuordnungen = (MAX(anz_zuordnungen) OVER (PARTITION BY CAST(subitemgroup_id AS STRING),
            mainitemgroup_id, CAST(itemgroup_int_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
          ))) AS max_az
    GROUP BY subitemgroup_id) AS sih ON ith.subitemgroup_id = sih.subitemgroup_id
  WHERE A.discount_sid = - 1
   AND sih.itemgroup_int_id IN (1, 2, 3, 4, 5, 6, 7, 9, 10, 20, 30, 32, 40, 50, 60, 70, 90)
  GROUP BY A.client_id,
   A.dwh_cal_dt,
   A.loc_sid_store,
   A.cy_month) AS apd ON ASIS.client_id = apd.client_id AND ASIS.dwh_cal_dt = apd.dwh_cal_dt AND ASIS.loc_sid_store =
   apd.loc_sid_store
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL0 ON COALESCE(ASIS.dwh_cal_dt, apd.dwh_cal_dt) = CAL0.cal_dt
 INNER JOIN ldl_p_lew_core_ac.v_cal_busyear_2 AS BYR0 ON CAL0.busyear = BYR0.busyear AND BYR0.cy_by_seq IN (0, - 1)
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CL ON COALESCE(ASIS.client_id, apd.client_id) = CL.client_id
 INNER JOIN ldl_p_lew_bil_ac.v_store_2 AS STR ON COALESCE(ASIS.client_id, apd.client_id) = STR.client_id AND COALESCE(ASIS
     .loc_sid_store, apd.loc_sid_store) = STR.loc_sid_store AND STR.dwh_actual_fg = 1
 LEFT JOIN ldl_p_lew_bil_ac.v_agg_store_day_turnover_ext_2 AS EXT ON EXT.client_id = COALESCE(ASIS.client_id, apd.client_id
     ) AND EXT.loc_sid_store = COALESCE(ASIS.loc_sid_store, apd.loc_sid_store) AND EXT.dat_formdate = COALESCE(ASIS.dwh_cal_dt
    , apd.dwh_cal_dt)
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON COALESCE(ASIS.client_id, apd.client_id) = CRY.client_id
       AND CRY.curr_cd_from = 'EUR' AND EXT.currency_iso_cd = CRY.curr_cd_to AND CURRENT_DATE BETWEEN CRY.active_from_dt
    AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS ERT ON ERT.client_id = COALESCE(ASIS.client_id, apd.client_id) AND
    CRY.x_rate_type_sid = ERT.x_rate_type_sid AND ERT.src_kurst = '@BEWE'
GROUP BY client_id,
 iso_cd,
 CAL0.cy_month,
 calender_day,
 orig_store_id,
 currency_iso_cd,
 apd.item_qty;