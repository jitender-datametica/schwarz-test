/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI.V_CC_MISC_METRICS_MONTH_CNTY
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #----------------------------------------------------------------------------
 */

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CC_MISC_METRICS_MONTH_CNTY AS
SELECT
  t7.client_id
  ,t1.cy_month
  ,t1.dat_calendar
  ,t2.cal_dt
  ,t2.area_name
  ,t2.cust_complaint_metric_measure AS service_level_call
  ,t3.cust_complaint_metric_measure AS service_availability_call
  ,COALESCE(t4.cust_complaint_metric_measure, 0) AS self_service_sessions
  ,t5.cust_complaint_metric_eur_val AS pers_cost_eur_val
  ,t6.cust_complaint_metric_eur_val AS mat_cost_eur_val
FROM
  (
    SELECT
      cy_month
      ,dat_calendar
    FROM
      P_LEW_MART_MSI_AC.V_CAL_CALENDARDAY
    WHERE
      day_of_month = 1
    GROUP BY
      cy_month
      ,dat_calendar
  ) t1
  LEFT JOIN (
    SELECT
      cal_dt
      ,area_name
      ,cust_complaint_metric_measure
    FROM
      P_LEW_CORE.T_CUSTOMER_COMPLAINT_METRIC
    WHERE
      cust_complaint_metric_type_cd = 'CUSTSERVLVL'
      AND CURRENT_DATE() BETWEEN dwh_valid_from
      AND dwh_valid_to
  ) t2 ON t1.dat_calendar = t2.cal_dt
  LEFT JOIN (
    SELECT
      cal_dt
      ,area_name
      ,cust_complaint_metric_measure
    FROM
      P_LEW_CORE.T_CUSTOMER_COMPLAINT_METRIC
    WHERE
      cust_complaint_metric_type_cd = 'CUSTSERVAVL'
      AND CURRENT_DATE() BETWEEN dwh_valid_from
      AND dwh_valid_to
  ) t3 ON t1.dat_calendar = t3.cal_dt
  AND t2.area_name = t3.area_name
  LEFT JOIN (
    SELECT
      t2.cy_month
      ,t1.area_name
      ,SUM(t1.cust_complaint_metric_measure) AS cust_complaint_metric_measure
    FROM
      P_LEW_CORE.T_CUSTOMER_COMPLAINT_METRIC t1
      INNER JOIN (
        SELECT
          cy_month
          ,dat_calendar
        FROM
          P_LEW_MART_MSI_AC.V_CAL_CALENDARDAY
      ) t2 ON t1.cal_dt = t2.dat_calendar
    WHERE
      cust_complaint_metric_type_cd = 'SELFSERVCNT'
      AND CURRENT_DATE() BETWEEN dwh_valid_from
      AND dwh_valid_to
    GROUP BY
      t2.cy_month
      ,t1.area_name
  ) t4 ON t1.cy_month = t4.cy_month
  AND t2.area_name = t4.area_name
  LEFT JOIN (
    SELECT
      cal_dt
      ,area_name
      ,curr_sid
      ,cust_complaint_metric_local_val
      ,cust_complaint_metric_eur_val
    FROM
      P_LEW_CORE.T_CUSTOMER_COMPLAINT_METRIC
    WHERE
      cust_complaint_metric_type_cd = 'PERSCOSTAMT'
      AND CURRENT_DATE() BETWEEN dwh_valid_from
      AND dwh_valid_to
  ) t5 ON t1.dat_calendar = t5.cal_dt
  AND t2.area_name = t5.area_name
  LEFT JOIN (
    SELECT
      cal_dt
      ,area_name
      ,curr_sid
      ,cust_complaint_metric_local_val
      ,cust_complaint_metric_eur_val
    FROM
      P_LEW_CORE.T_CUSTOMER_COMPLAINT_METRIC
    WHERE
      cust_complaint_metric_type_cd = 'MATCOSTAMT'
      AND CURRENT_DATE() BETWEEN dwh_valid_from
      AND dwh_valid_to
  ) t6 ON t1.dat_calendar = t6.cal_dt
  AND t2.area_name = t6.area_name
  LEFT JOIN (
    SELECT
      client_id
      ,country_iso_cd
    FROM
      P_LEW_MART_MSI_AC.V_REF_CLIENT_LEAD
    WHERE
      client_id != 7
    UNION
    ALL
    SELECT
      7 AS client_id
      ,'INT' AS country_iso_cd
  ) t7 ON t2.area_name = t7.country_iso_cd
WHERE
  t2.cal_dt IS NOT NULL
ORDER BY
  t1.cy_month;