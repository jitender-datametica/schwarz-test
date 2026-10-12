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
*/

!SET exit_on_error=True;

-- Period (in days) meaning how long materialised data has to be kept
SET SV_DAYS_CNT = 14; 


-- Set status_2 as MT (materialised) for just processed stores
UPDATE core_app_fraud_detection.t_fraud_detection_order_2
SET    order_parameter_status_cd = 'MT'
,      dwh_updated_tmsp          = current_timestamp()
WHERE  order_parameter_status_cd ilike 'LO';



-- Set status_2 as RM (removed) for stores that have been materialised but never revised
UPDATE core_app_fraud_detection.t_fraud_detection_order_2
SET    order_parameter_status_cd = 'RM'
,      dwh_updated_tmsp          = current_timestamp()
WHERE  order_parameter_status_cd ilike 'MT'
AND    datediff(day, dwh_updated_tmsp, current_date()) >= $SV_DAYS_CNT;

-- Set status_2 as END (ended) for stores that have been materialised and revised
UPDATE core_app_fraud_detection.t_fraud_detection_order_2
SET    order_parameter_status_cd = 'END'
,      dwh_updated_tmsp          = current_timestamp()
WHERE  order_parameter_status_cd ilike 'RV'
AND    datediff(day, dwh_updated_tmsp, current_date()) >= $SV_DAYS_CNT;


-- Delete data older than required period:
DELETE FROM core_app_fraud_detection.t_cash_register_event_classification_2
WHERE datediff(day, dwh_updated_tmsp, current_date()) >= $SV_DAYS_CNT;

DELETE FROM core_app_fraud_detection.t_statistics_by_store_hour_cashier_2
WHERE datediff(day, dwh_updated_tmsp, current_date()) >= $SV_DAYS_CNT;

DELETE FROM core_app_fraud_detection.t_cash_register_print_2
WHERE datediff(day, dwh_updated_tmsp, current_date()) >= $SV_DAYS_CNT;

DELETE FROM core_app_fraud_detection.t_cash_register_event_relationship_2
WHERE datediff(day, dwh_updated_tmsp, current_date()) >= $SV_DAYS_CNT;

