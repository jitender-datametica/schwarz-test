/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2024-11-06 Pawel Wieczorek          AP0228067 Lidl Plus Churn Metrics Initial version
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_cust_churn_wk (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ceographical identifier for client'),
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Week number'),
cy_week_prev_1w BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='The calendar week 1 week ago as a number in the form YYYYWW.'),
cy_week_prev_1y BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='The calendar week 1 year ago as a number in the form YYYYWW.'),
wk_rf_segment_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='ids of recency-frequency segments from rfm model'),
wk_m_segment_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
gender_cd STRING(5) NOT NULL OPTIONS(description='The code for the gender'),
age_range_cd STRING(10) NOT NULL OPTIONS(description='The code for the age range.'),
household_type_id BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='ID of the household type in which the customer lives.'),
child_age_range_group_id BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Customer identifier'),
app_churn_wk_30_days NUMERIC(18,5)
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
store_churn_wk_30_days NUMERIC(18,5)
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
app_churn_wk_90_days NUMERIC(18,5)
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
store_churn_wk_90_days NUMERIC(18,5)
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, geo_area_sid, cy_week, customer_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus table : KPIs show the Lidl Plus store or app churn per week');