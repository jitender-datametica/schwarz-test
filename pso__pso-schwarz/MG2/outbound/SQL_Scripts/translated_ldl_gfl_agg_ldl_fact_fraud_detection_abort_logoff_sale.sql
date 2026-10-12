INSERT INTO ldl_data_production.${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final (
  cash_register_event_sid,
  cash_register_event_nr,
  event_start_tmsp,
  bus_dt,
  cash_register_sid,
  cash_register_nr,
  store_sid,
  cashier_hash,
  txn_net_val,
  txn_gross_val,
  curr_cd,
  abort_and_sale_fg,
  abort_and_logoff_fg
)
WITH mat_params AS (
  SELECT
    *
  FROM ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE
    scenario_id = 17
), small_sales AS (
  SELECT
    tprl.retail_event_sid
  FROM ldl_data_production.${fwrk_work_db}.vt1 AS vt1
  JOIN ldl_data_production.core_rel.t_product_retail_line AS tprl
    ON vt1.country_cd = tprl.country_org_cd
    AND vt1.dwh_cal_dt = tprl.bus_dt
    AND vt1.loc_sid = tprl.store_sid
  JOIN mat_params AS p_smv
    ON p_smv.country_org_cd = tprl.country_org_cd
    AND p_smv.param_id = 52
    AND p_smv.is_scenario_enabled_in_country_fg = TRUE
  WHERE
    tprl.turnover_relevant_fg = TRUE
    AND tprl.bus_dt BETWEEN @MIN_DWH_CAL_DT AND @MAX_DWH_CAL_DT
  GROUP BY
    tprl.retail_event_sid
  HAVING
    SUM(
      CASE
        WHEN tprl.retail_event_line_scenario_id IN (101, 102, 120, 122, 201, 202, 220, 222)
        THEN 1
        ELSE 0
      END
    ) = 1
    AND SUM(
      CASE
        WHEN tprl.cancel_line_seq IS NULL
        AND tprl.retail_line_gross_val < p_smv.param_val_qty
        AND tprl.retail_event_line_scenario_id IN (101, 102, 120, 122, 201, 202, 220, 222)
        THEN 1
        ELSE 0
      END
    ) = 1
), aborted_receipts AS (
  SELECT
    o_re.retail_event_sid,
    o_re.bus_dt,
    o_re.event_start_tmsp,
    o_re.cash_register_sid,
    o_re.cash_register_event_nr,
    o_re.store_sid,
    o_re.cashier_hash,
    o_re.txn_net_val,
    o_re.txn_gross_val,
    o_re.curr_cd
  FROM ldl_data_production.${fwrk_work_db}.vt1 AS vt1
  JOIN ldl_data_production.core_rel.t_retail_event AS o_re
    ON o_re.bus_dt = vt1.dwh_cal_dt
    AND o_re.country_org_cd = vt1.country_cd
    AND o_re.store_sid = vt1.loc_sid
  JOIN mat_params AS p_amv
    ON p_amv.country_org_cd = o_re.country_org_cd
    AND p_amv.param_id = 51
    AND p_amv.is_scenario_enabled_in_country_fg = TRUE
  WHERE
    o_re.bus_dt BETWEEN @MIN_DWH_CAL_DT AND @MAX_DWH_CAL_DT
    AND o_re.retail_event_type_cd = 'S'
    AND o_re.cancel_fg = TRUE
    AND o_re.txn_gross_val >= p_amv.param_val_qty
), all_cash_reg_events AS (
  SELECT
    cash_register_event_nr,
    event_tmsp,
    bus_dt,
    cash_register_sid,
    'TECH_EVENT' AS event_category,
    tech_cash_register_event_type_cd AS event_subcategory,
    cancel_fg,
    suspend_fg,
    FALSE AS small_sale_fg
  FROM ldl_data_production.${fwrk_work_db}.vt1 AS vt1
  JOIN ldl_data_production.core_rel.t_technical_cash_register_event AS tcre
    ON tcre.bus_dt = vt1.dwh_cal_dt
    AND tcre.country_org_cd = vt1.country_cd
    AND tcre.store_sid = vt1.loc_sid
  WHERE
    bus_dt BETWEEN @MIN_DWH_CAL_DT AND @MAX_DWH_CAL_DT
    AND NOT tech_cash_register_event_type_cd IN (400, 405, 420, 425, 430)
  UNION ALL
  SELECT
    cash_register_event_nr,
    event_start_tmsp,
    bus_dt,
    cash_register_sid,
    'RETAIL_EVENT' AS event_category,
    retail_event_type_cd AS event_subcategory,
    cancel_fg,
    suspend_fg,
    CASE WHEN NOT sm_sl.retail_event_sid IS NULL THEN TRUE ELSE FALSE END AS small_sale_fg
  FROM ldl_data_production.${fwrk_work_db}.vt1 AS vt1
  JOIN ldl_data_production.core_rel.t_retail_event AS re
    ON re.bus_dt = vt1.dwh_cal_dt
    AND re.country_org_cd = vt1.country_cd
    AND re.store_sid = vt1.loc_sid
  LEFT JOIN small_sales AS sm_sl
    ON sm_sl.retail_event_sid = re.retail_event_sid
  WHERE
    bus_dt BETWEEN @MIN_DWH_CAL_DT AND @MAX_DWH_CAL_DT
)
SELECT
  ar.retail_event_sid AS cash_register_event_sid,
  ar.cash_register_event_nr AS cash_register_event_nr,
  ar.event_start_tmsp,
  ar.bus_dt,
  ar.cash_register_sid,
  cr.cash_register_nr,
  ar.store_sid,
  ar.cashier_hash,
  ar.txn_net_val,
  ar.txn_gross_val,
  ar.curr_cd,
  CASE WHEN acre.event_category = 'RETAIL_EVENT' THEN 1 ELSE 0 END AS abort_and_sale_fg,
  CASE WHEN acre.event_category = 'TECH_EVENT' THEN 1 ELSE 0 END AS abort_and_logoff_fg
FROM aborted_receipts AS ar
JOIN all_cash_reg_events AS acre
  ON ar.cash_register_sid = acre.cash_register_sid
  AND ar.bus_dt = acre.bus_dt
  AND ar.cash_register_event_nr < acre.cash_register_event_nr
JOIN ldl_data_production.core_rel.t_cash_register AS cr
  ON ar.cash_register_sid = cr.cash_register_sid AND cr.dwh_valid_fg = TRUE
QUALIFY
  ROW_NUMBER() OVER (PARTITION BY ar.retail_event_sid ORDER BY acre.cash_register_event_nr) = 1
  AND acre.cancel_fg = FALSE
  AND acre.suspend_fg = FALSE
  AND (
    (
      acre.event_category = 'TECH_EVENT' AND acre.event_subcategory = '410'
    )
    OR (
      acre.event_category = 'RETAIL_EVENT'
      AND acre.event_subcategory = 'S'
      AND acre.small_sale_fg
    )
  );