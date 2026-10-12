CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_cust_clv_mth (
client_id INTEGER NOT NULL OPTIONS(description='Identifier for client'),
geo_area_sid INTEGER NOT NULL OPTIONS(description='Ceographical identifier for client'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
curr_tot_id INTEGER NOT NULL OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
cy_month INTEGER NOT NULL OPTIONS(description='Calendar Year+Month in form YYYYMM'),
cy_month_prev_1m INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='The calendar month 1 month ago as a number in the form YYYYMM. Eg. 201901. [Month Identifier]'),
cy_month_prev_1y INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='The calendar month 1 year ago as a number in the form YYYYMM. Eg. 201802. [Month Identifier]'),
mth_rf_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of recency-frequency segments from rfm model'),
mth_m_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
gender_cd STRING(5) NOT NULL OPTIONS(description='The code for the gender'),
age_range_cd STRING(10) NOT NULL OPTIONS(description='The code for the age range.'),
household_type_id INTEGER DEFAULT 0 OPTIONS(description='ID of the household type in which the customer lives.'),
child_age_range_group_id INTEGER DEFAULT 0
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
customer_sid INTEGER NOT NULL OPTIONS(description='Customer identifier'),
clv_365_days NUMERIC(29,5)
OPTIONS(description='result of the calculation of a score type for an individual customer in a certain model run.'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, geo_area_sid, cy_month, customer_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus table :  KPIs show the Lidl Plus clv 365 per month');