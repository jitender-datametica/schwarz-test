-- Remove old rows (truncate is faster than delete without filter)
TRUNCATE TABLE `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_METRIC_BY_CASHIER_HOUR_1`;

-- Insert new data
INSERT INTO `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_METRIC_BY_CASHIER_HOUR_1`
(
  store_sid,
  cashier_nr,
  bus_dt,
  hr,
  metric_id,
  country_org_cd,
  curr_cd,
  metric_val_1,
  metric_val_2,
  metric_val_3,
  metric_val_4
)
SELECT
  store_sid,
  cashier_nr,
  bus_dt,
  hr,
  metric_id,
  country_org_cd,
  curr_cd,
  metric_val_1,
  metric_val_2,
  metric_val_3,
  metric_val_4
FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_MAT_FRAUD_DETECTION_METRIC_BY_CASHIER_HOUR_1`
ORDER BY country_org_cd;
