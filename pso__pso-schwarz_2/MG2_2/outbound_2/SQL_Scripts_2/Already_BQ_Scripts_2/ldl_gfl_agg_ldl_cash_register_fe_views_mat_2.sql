/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_cash_register_fe_views_mat.sql
#----------------------------------------------------------------------------
# History:
# 1.0  20.02.2025  Andrzej Wandtke  - ZKP - ldl_cash_register_fe_views_mat  - intial version. Story 65098 - materialise FE views(s)
                                      It does full delete at the beginning and full reload									
*/

!SET exit_on_error=True;


DELETE FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_METRIC_BY_CASHIER_HOUR_2;


INSERT INTO CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_METRIC_BY_CASHIER_HOUR_2
(store_sid
,cashier_nr
,bus_dt
,hr
,metric_id
,country_org_cd
,curr_cd
,metric_val_1
,metric_val_2
,metric_val_3
,metric_val_4
)
SELECT 
 store_sid
,cashier_nr
,bus_dt
,hr
,metric_id
,country_org_cd
,curr_cd
,metric_val_1
,metric_val_2
,metric_val_3
,metric_val_4
FROM CORE_APP_FRAUD_DETECTION.V_MAT_FRAUD_DETECTION_METRIC_BY_CASHIER_HOUR_2
ORDER BY country_org_cd;
