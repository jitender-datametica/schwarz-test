/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_cash_register_data_control.sql
#----------------------------------------------------------------------------
# History:
# 1.0  21.10.2024  Andrzej Wandtke  - ZKP - intial version
# 1.1  07.11.2024  Andrzej Wandtke  - ZKP - change in UPDATE of order_parameter_status_cd section (use code 'LO')
# 1.2  29.11.2024  Andrzej Wandtke  - ZKP - delete data from t_cash_register_event_relationship_2
# 1.3  28.01.2025  Andrzej Wandtke  - ZKP - rename table t_statistics_by_store_day_cashier to t_statistics_by_store_hour_cashier_2
*/ /* !SET exit_on_error=True; */ /* Period (in days) meaning how long materialised data has to be kept */
DECLARE SV_DAYS_CNT BIGNUMERIC;

SET sv_days_cnt = CAST('14' AS NUMERIC);

/* Set status_2 as MT (materialised) for just processed stores */
UPDATE ldl_data_production.core_app_fraud_detection.t_fraud_detection_order_2 SET order_parameter_status_cd = 'MT', dwh_updated_tmsp = current_timestamp()
WHERE
  upper(t_fraud_detection_order.order_parameter_status_cd) LIKE 'LO';

/* Set status_2 as RM (removed) for stores that have been materialised but never revised */
UPDATE ldl_data_production.core_app_fraud_detection.t_fraud_detection_order_2 SET order_parameter_status_cd = 'RM', dwh_updated_tmsp = current_timestamp()
WHERE
  upper(t_fraud_detection_order.order_parameter_status_cd) LIKE 'MT'
  AND datetime_diff(CAST(CURRENT_DATE AS DATETIME), t_fraud_detection_order.dwh_updated_tmsp, DAY) >= sv_days_cnt;

/* Set status_2 as END (ended) for stores that have been materialised and revised */
UPDATE ldl_data_production.core_app_fraud_detection.t_fraud_detection_order_2 SET order_parameter_status_cd = 'END', dwh_updated_tmsp = current_timestamp()
WHERE
  upper(t_fraud_detection_order.order_parameter_status_cd) LIKE 'RV'
  AND datetime_diff(CAST(CURRENT_DATE AS DATETIME), t_fraud_detection_order.dwh_updated_tmsp, DAY) >= sv_days_cnt;

/* Delete data older than required period: */
DELETE FROM ldl_data_production.core_app_fraud_detection.t_cash_register_event_classification_2
WHERE
  datetime_diff(
    CAST(CURRENT_DATE AS DATETIME),
    t_cash_register_event_classification.dwh_updated_tmsp,
    DAY
  ) >= sv_days_cnt;

DELETE FROM ldl_data_production.core_app_fraud_detection.t_statistics_by_store_hour_cashier_2
WHERE
  datetime_diff(
    CAST(CURRENT_DATE AS DATETIME),
    t_statistics_by_store_hour_cashier.dwh_updated_tmsp,
    DAY
  ) >= sv_days_cnt;

DELETE FROM ldl_data_production.core_app_fraud_detection.t_cash_register_print_2
WHERE
  datetime_diff(CAST(CURRENT_DATE AS DATETIME), t_cash_register_print.dwh_updated_tmsp, DAY) >= sv_days_cnt;

DELETE FROM ldl_data_production.core_app_fraud_detection.t_cash_register_event_relationship_2
WHERE
  datetime_diff(
    CAST(CURRENT_DATE AS DATETIME),
    t_cash_register_event_relationship.dwh_updated_tmsp,
    DAY
  ) >= sv_days_cnt;