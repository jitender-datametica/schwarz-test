/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI.V_STORES_COUNT_MONTH_CNTY_1
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #  1.1  22.12.2022    Wandtke,Andrzej          Add condition aspect_id=1
 #----------------------------------------------------------------------------
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_stores_count_month_cnty_1 AS SELECT t1.cy_month,
 t2.client_id,
 COUNT(*) AS num_stores
FROM (SELECT DISTINCT cy_month
  FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1) AS t1_1
 LEFT JOIN (SELECT client_id,
   DATE_TRUNC(dat_opening, MONTH) AS dat_open,
   DATE_TRUNC(COALESCE(dat_closing, PARSE_DATE('%Y-%m', '2099-12')), MONTH) AS dat_close
  FROM ldl_p_lew_core_ac.v_wawi_org_store_merge_act_1
  WHERE aspect_id = 1) AS t2 ON PARSE_DATE('%Y%m', CAST(t1.cy_month AS STRING)) BETWEEN t2.dat_open AND t2.dat_close
GROUP BY t1.cy_month,
 t2.client_id;