/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_cash_register_data_control.sql
#----------------------------------------------------------------------------
# History:
# 1.0  21.10.2024  Andrzej Wandtke  - ZKP - intial version
# 1.1  07.11.2024  Andrzej Wandtke  - ZKP - change in UPDATE of order_parameter_status_cd section (use code 'LO')
# 1.2  29.11.2024  Andrzej Wandtke  - ZKP - delete data from t_cash_register_event_relationship
# 1.3  28.01.2025  Andrzej Wandtke  - ZKP - rename table t_statistics_by_store_day_cashier to t_statistics_by_store_hour_cashier
*/

-- Period (in days) meaning how long materialised data has to be kept
DECLARE SV_DAYS_CNT INT64 DEFAULT 14;

-- Set status as MT (materialised) for just processed stores
UPDATE `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER`
SET    order_parameter_status_cd = 'MT',
       dwh_updated_tmsp          = CURRENT_TIMESTAMP()
WHERE  LOWER(order_parameter_status_cd) = 'lo';

-- Set status as RM (removed) for stores that have been materialised but never revised
UPDATE `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER`
SET    order_parameter_status_cd = 'RM',
       dwh_updated_tmsp          = CURRENT_TIMESTAMP()
WHERE  LOWER(order_parameter_status_cd) = 'mt'
AND    DATE_DIFF(CURRENT_DATE(), DATE(dwh_updated_tmsp), DAY) >= SV_DAYS_CNT;

-- Set status as END (ended) for stores that have been materialised and revised
UPDATE `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER`
SET    order_parameter_status_cd = 'END',
       dwh_updated_tmsp          = CURRENT_TIMESTAMP()
WHERE  LOWER(order_parameter_status_cd) = 'rv'
AND    DATE_DIFF(CURRENT_DATE(), DATE(dwh_updated_tmsp), DAY) >= SV_DAYS_CNT;

-- Delete data older than required period:
DELETE FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION`
WHERE DATE_DIFF(CURRENT_DATE(), DATE(dwh_updated_tmsp), DAY) >= SV_DAYS_CNT;

DELETE FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_STATISTICS_BY_STORE_HOUR_CASHIER`
WHERE DATE_DIFF(CURRENT_DATE(), DATE(dwh_updated_tmsp), DAY) >= SV_DAYS_CNT;

DELETE FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_PRINT`
WHERE DATE_DIFF(CURRENT_DATE(), DATE(dwh_updated_tmsp), DAY) >= SV_DAYS_CNT;

DELETE FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_RELATIONSHIP`
WHERE DATE_DIFF(CURRENT_DATE(), DATE(dwh_updated_tmsp), DAY) >= SV_DAYS_CNT;
