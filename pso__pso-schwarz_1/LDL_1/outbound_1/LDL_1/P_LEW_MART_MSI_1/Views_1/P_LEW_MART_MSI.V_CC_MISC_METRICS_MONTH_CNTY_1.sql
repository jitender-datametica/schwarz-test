/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI.V_CC_MISC_METRICS_MONTH_CNTY_1
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #----------------------------------------------------------------------------
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cc_misc_metrics_month_cnty_1 AS SELECT t7.client_id,
 t1.cy_month,
 t1.dat_calendar,
 t2.cal_dt,
 t2.area_name,
 t2.cust_complaint_metric_measure AS service_level_call,
 t3.cust_complaint_metric_measure AS service_availability_call,
 COALESCE(t10.cust_complaint_metric_measure, 0) AS self_service_sessions,
 t5.cust_complaint_metric_eur_val AS pers_cost_eur_val,
 t6.cust_complaint_metric_eur_val AS mat_cost_eur_val
FROM (SELECT cy_month,
   dat_calendar
  FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
  WHERE day_of_month = 1
  GROUP BY dat_calendar,
   cy_month) AS t1_1
 LEFT JOIN (SELECT cal_dt,
   area_name,
   cust_complaint_metric_measure
  FROM ldl_p_lew_core.t_customer_complaint_metric_1
  WHERE cust_complaint_metric_type_cd = 'CUSTSERVLVL'
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to) AS t2 ON t1.dat_calendar = t2.cal_dt
 LEFT JOIN (SELECT cal_dt,
   area_name,
   cust_complaint_metric_measure
  FROM ldl_p_lew_core.t_customer_complaint_metric_1
  WHERE cust_complaint_metric_type_cd = 'CUSTSERVAVL'
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to) AS t3 ON t1.dat_calendar = t3.cal_dt AND t2.area_name = t3
   .area_name
 LEFT JOIN (SELECT t2.cy_month,
   T1.area_name,
   SUM(T1.cust_complaint_metric_measure) AS cust_complaint_metric_measure
  FROM ldl_p_lew_core.t_customer_complaint_metric_1 AS T1_1
   INNER JOIN (SELECT cy_month,
     dat_calendar
    FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1) AS t2 ON T1.cal_dt = t2.dat_calendar
  WHERE T1.cust_complaint_metric_type_cd = 'SELFSERVCNT'
   AND CURRENT_DATE BETWEEN T1.dwh_valid_from AND T1.dwh_valid_to
  GROUP BY T1.area_name,
   t2.cy_month) AS t10 ON t1.cy_month = t10.cy_month AND t2.area_name = t10.area_name
 LEFT JOIN (SELECT cal_dt,
   area_name,
   curr_sid,
   cust_complaint_metric_local_val,
   cust_complaint_metric_eur_val
  FROM ldl_p_lew_core.t_customer_complaint_metric_1
  WHERE cust_complaint_metric_type_cd = 'PERSCOSTAMT'
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to) AS t5 ON t1.dat_calendar = t5.cal_dt AND t2.area_name = t5
   .area_name
 LEFT JOIN (SELECT cal_dt,
   area_name,
   curr_sid,
   cust_complaint_metric_local_val,
   cust_complaint_metric_eur_val
  FROM ldl_p_lew_core.t_customer_complaint_metric_1
  WHERE cust_complaint_metric_type_cd = 'MATCOSTAMT'
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to) AS t6 ON t1.dat_calendar = t6.cal_dt AND t2.area_name = t6
   .area_name
 LEFT JOIN (SELECT client_id,
    country_iso_cd
   FROM ldl_p_lew_mart_msi_ac.v_ref_client_lead_1
   WHERE client_id <> 7
   UNION ALL
   SELECT 7 AS client_id,
    'INTEGER ' AS country_iso_cd) AS t7 ON t2.area_name = t7.country_iso_cd
WHERE t2.cal_dt IS NOT NULL
ORDER BY t1.cy_month NULLS LAST;