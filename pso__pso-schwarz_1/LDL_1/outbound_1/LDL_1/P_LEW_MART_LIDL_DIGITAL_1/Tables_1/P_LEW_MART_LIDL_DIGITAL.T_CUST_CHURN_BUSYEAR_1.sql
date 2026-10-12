/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2024-11-13 Pawel Wieczorek          AP0228067 Lidl Plus Churn Metrics
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_cust_churn_busyear_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ceographical identifier for client'),
busyear BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Business year identifier'),
busyear_prev_1y BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Business year one year ago'),
mth_rf_segment_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='ids of recency-frequency segments from rfm model'),
mth_m_segment_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
gender_cd STRING(5) NOT NULL OPTIONS(description='The code for the gender'),
age_range_cd STRING(10) NOT NULL OPTIONS(description='The code for the age range.'),
household_type_id BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='ID of the household type in which the customer lives.'),
child_age_range_group_id BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Customer identifier'),
app_churn_busyear_30_days NUMERIC(18,5)
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
store_churn_busyear_30_days NUMERIC(18,5)
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
app_churn_busyear_90_days NUMERIC(18,5)
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
store_churn_busyear_90_days NUMERIC(18,5)
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, geo_area_sid, busyear, customer_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus table :  KPIs show the Lidl Plus store or app churn per business year');