SET sv_start_dt = (
  SELECT
    FORMAT_DATE(
      '%Y-%m-%d',
      DATE_SUB(DATE_TRUNC(CURRENT_DATE, WEEK), INTERVAL (CAST(CAST('8' AS NUMERIC) * CAST('7' AS NUMERIC) AS INT64)) DAY)
    )
  FROM dual
) /*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: zkp_reagg_delta_insert.sql
#----------------------------------------------------------------------------
# History:
#	1.0  	26.11.2024  	Mihail Ivanov  - Initial Implementation:
							When a threshold for a scenario (a.k.a parameter_value) is changed for a given country_2
								the receipts for the last 8 weeks for this country_2 need to be reeavaluated
								if they fit any of the Automatic ZKP scenarios
							
							This scripts checks the last date of parameter value changed, 
								and when the receipts were last evaluated
							If necessary, we insert "artificial" delta to force the ZKP scripts to evaluate the receipts 
								for the last 8 weeks for the given country_2(s)
								
#	1.1  	10.03.2025  	Mihail Ivanov  - Adding additional 10 days backward for each store.
								For some return scenarios we need to check if there is an older return with same original purchase
								If such return exist it needs to be reevaluated because the result depends on how many returns are made with same original purchase
								Statistical analysis showed that 10 days backward cover more than 99.7% of relevant cases and this is good enough for business, while keeping execution time small
								https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/66175/
*/
 /* !SET exit_on_error=True; */ 
 /* (Monday of current week - 8 weeks) */ 
  DECLARE SV_START_DT STRING; 
  DECLARE SV_END_DT STRING; 
  DECLARE SV_DATEDIFF BIGNUMERIC; 
  DECLARE SV_DAY_BACK_CNT BIGNUMERIC; ;

SET sv_end_dt = FORMAT_DATE('%Y-%m-%d', CURRENT_DATE);

SET sv_datediff = (
  SELECT
    DATE_DIFF(CAST(dual.$sv_end_dt AS DATE), CAST(dual.$sv_start_dt AS DATE), DAY) + CAST('1' AS NUMERIC)
  FROM dual
);

SET sv_day_back_cnt = CAST('10' /* by how many days back we extend the delta interval, so we can look for other returns with same original receipt */ AS NUMERIC);

INSERT INTO ldl_data_production.etl_process.t_prcs_log_2 (
  aggregate,
  dwh_node_cd,
  country_cd,
  dwh_cal_dt,
  loc_sid,
  recalc_fg,
  status_2,
  dwh_load_id,
  create_tmsp,
  update_tmsp,
  start_tmsp,
  end_tmsp
)
(
  WITH curr_delta AS (
    SELECT DISTINCT
      prcs_log.country_cd,
      prcs_log.dwh_cal_dt,
      prcs_log.loc_sid
    FROM ldl_data_production.etl_process.t_prcs_log_2 AS prcs_log
    WHERE
      prcs_log.dwh_load_id = prcs_log.${load_id}
  )
  SELECT
    MIN(curr_delta.dwh_cal_dt) - CAST($sv_day_back_cnt AS BIGNUMERIC)
  FROM curr_delta
) 
BEGIN 
 DECLARE cw_const BIGNUMERIC DEFAULT 

WITH curr_delta AS (
  SELECT DISTINCT
    prcs_log.country_cd,
    prcs_log.dwh_cal_dt,
    prcs_log.loc_sid
  FROM ldl_data_production.etl_process.t_prcs_log_2 AS prcs_log
  WHERE
    prcs_log.dwh_load_id = prcs_log.${load_id}
), other_ret_dates AS (
  SELECT DISTINCT
    prl2.store_sid,
    prl2.country_org_cd,
    prl2.bus_dt
  FROM curr_delta AS cd
  INNER JOIN ldl_data_production.core_rel.t_product_retail_line_2 AS prl
    ON prl.store_sid = cd.loc_sid
    AND prl.country_org_cd = cd.country_cd
    AND prl.bus_dt = cd.dwh_cal_dt
    AND prl.retail_event_line_scenario_id BETWEEN CAST('140' AS NUMERIC) AND CAST('149' /* Return receipt lines */ AS NUMERIC)
  INNER JOIN ldl_data_production.core_rel.t_product_retail_line_2 AS prl2
    ON prl2.country_org_cd = prl.country_org_cd
    AND prl2.retail_event_line_scenario_id BETWEEN CAST('140' AS NUMERIC) AND CAST('149' /* Return receipt lines */ AS NUMERIC)
    AND prl2.orig_sales_event_sid = prl.orig_sales_event_sid /* same purchase */
    AND prl2.retail_event_sid <> prl.retail_event_sid /* different return event */
    AND prl2.bus_dt >= cw_const
)
SELECT
  't_fact_fraud_detection_by_cash_register_event_2',
  'CORE_DIM',
  ord.country_org_cd,
  ord.bus_dt,
  ord.store_sid,
  CAST('0' AS NUMERIC),
  CAST('0' AS NUMERIC),
  ${load_id},
  CURRENT_DATE,
  CURRENT_DATE,
  CURRENT_DATE,
  CURRENT_DATE
FROM other_ret_dates AS ord
LEFT OUTER JOIN curr_delta AS cd
  ON ord.store_sid = cd.loc_sid
  AND ord.country_org_cd = cd.country_cd
  AND ord.bus_dt = cd.dwh_cal_dt
WHERE
  cd.loc_sid IS NULL;

END; 
/* only new Store/Day combos, that do no exist in current delta */
INSERT INTO ldl_data_production.etl_process.t_prcs_log_2 (
  aggregate,
  dwh_node_cd,
  country_cd,
  dwh_cal_dt,
  loc_sid,
  recalc_fg,
  status_2,
  dwh_load_id,
  create_tmsp,
  update_tmsp,
  start_tmsp,
  end_tmsp
)
WITH country_param_update AS (
  SELECT
    v_fraud_detection_parameter_current_value.country_org_cd,
    MAX(v_fraud_detection_parameter_current_value.param_last_update_tmsp) AS country_param_max_tmsp
  FROM ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value_2
  WHERE
    v_fraud_detection_parameter_current_value.scenario_type_cd = 'AUTO'
  GROUP BY
    1
), country_data_load AS (
  SELECT
    io.country_org_cd,
    MIN(fe.dwh_updated_tmsp) AS country_load_min_tmsp
  FROM ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event_2 AS fe
  INNER JOIN ldl_data_production.core_dim.t_dim_internal_organization_2 AS io
    ON io.int_org_sid = fe.store_sid AND io.dwh_valid_fg = TRUE
  WHERE
    bus_dt >= $sv_start_dt
  GROUP BY
    1
), stores_for_reload AS (
  SELECT
    cdl.country_org_cd,
    io_st.int_org_sid AS store_sid
  FROM country_param_update AS cpu
  INNER JOIN country_data_load AS cdl
    ON cdl.country_org_cd = cpu.country_org_cd
     /* if there is data loaded BEFORE last param change, we must reload it */ /* all receipts from past 8 weeks must be evaluated AFTER last param val change */ 
     AND cdl.country_load_min_tmsp < cpu.country_param_max_tmsp
  INNER JOIN ldl_data_production.core_dim.t_dim_internal_organization_2 AS io_st
    ON io_st.country_org_cd = cdl.country_org_cd
    /* take all stores for the countries that need to be reloaded */ AND  io_st.dwh_valid_fg = TRUE
    AND io_st.int_org_type_cd = 'STORE'
), days_last8_weeks AS (
  SELECT
    DATE_SUB(DATE_ADD(CAST(g.$sv_start_dt AS DATE), INTERVAL (CAST(row_number() OVER (ORDER BY IF(CAST('1' AS NUMERIC) IS NULL, 0, 1) DESC, CAST('1' AS NUMERIC)) AS INT64)) DAY), INTERVAL '1' DAY) AS dt_val
  FROM UNNEST(GENERATE_ARRAY(CAST('0' AS NUMERIC), $sv_datediff - CAST('1' AS NUMERIC))) AS n
)
SELECT
  't_fact_fraud_detection_by_cash_register_event_2',
  'CORE_DIM',
  sfr.country_org_cd,
  d.dt_val,
  sfr.store_sid,
  CAST('0' AS NUMERIC),
  CAST('0' AS NUMERIC),
  ${load_id},
  CURRENT_DATE,
  CURRENT_DATE,
  CURRENT_DATE,
  CURRENT_DATE
FROM stores_for_reload AS sfr
CROSS JOIN days_last8_weeks AS d;