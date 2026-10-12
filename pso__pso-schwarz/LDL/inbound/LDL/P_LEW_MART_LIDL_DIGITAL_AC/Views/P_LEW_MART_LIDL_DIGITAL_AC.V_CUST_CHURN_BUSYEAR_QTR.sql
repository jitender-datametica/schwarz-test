/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2024-04-24 Rafal Rudnik             T_CUST_CHURN_MTH
#                                          Initial version SD-639
#  1.1 2024-11-06 Pawel Wieczorek          AP0228067 Lidl Plus Churn Metrics
#  1.2 2024-11-13 Pawel Wieczorek          AP0228067 Added column busyear_qtr_prev_1q
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.v_cust_churn_busyear_qtr
COMMENT = 'Lidlplus table :  KPIs show the Lidl Plus store or app churn per business year quarter'
(
 client_id                      COMMENT 'Identifier for client'
,geo_area_sid                   COMMENT 'Ceographical identifier for client'
,busyear_qtr                    COMMENT 'Business year quarter identifier'
,busyear_qtr_prev_1q            COMMENT 'Quarter of the business one quarter ago'
,busyear_qtr_prev_1y            COMMENT 'Business year quarter identifier 1 year ago'
,busyear_qtr_m_segment_sid      COMMENT 'ids of monetary segments from rfm model'
,busyear_qtr_rf_segment_sid     COMMENT 'ids of recency-frequency segments from rfm model'
,gender_cd                      COMMENT 'The code for the gender'
,age_range_cd                   COMMENT 'The code for the age range.'
,household_type_id              COMMENT 'ID of the household type in which the customer lives.'
,child_age_range_group_id       COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.'
,customer_sid                   COMMENT 'Customer identifier'
,app_churn_busyear_qtr_30_days  COMMENT 'result of the calculation of a score type for an individual customer in a certain model run.'
,store_churn_busyear_qtr_30_day COMMENT 'result of the calculation of a score type for an individual customer in a certain model run.'
,app_churn_busyear_qtr_90_days  COMMENT 'result of the calculation of a score type for an individual customer in a certain model run.'
,store_churn_busyear_qtr_90_day COMMENT 'result of the calculation of a score type for an individual customer in a certain model run.'
,load_id                        COMMENT 'Load identifier'
,dwh_created                    COMMENT 'Row create time'
,dwh_updated                    COMMENT 'Row update time'
)
AS
SELECT
 t.client_id
,t.geo_area_sid
,t.busyear_qtr
,t.busyear_qtr_prev_1q
,t.busyear_qtr_prev_1y
,t.busyear_qtr_m_segment_sid
,t.busyear_qtr_rf_segment_sid
,t.gender_cd
,t.age_range_cd
,t.household_type_id
,t.child_age_range_group_id
,t.customer_sid
,t.app_churn_busyear_qtr_30_days
,t.store_churn_busyear_qtr_30_day
,t.app_churn_busyear_qtr_90_days
,t.store_churn_busyear_qtr_90_day
,t.load_id
,t.dwh_created
,t.dwh_updated
FROM p_lew_mart_lidl_digital.v_cust_churn_busyear_qtr AS t
;