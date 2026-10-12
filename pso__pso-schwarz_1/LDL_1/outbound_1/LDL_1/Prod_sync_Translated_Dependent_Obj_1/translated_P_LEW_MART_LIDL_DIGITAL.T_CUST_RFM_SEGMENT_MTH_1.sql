CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_cust_rfm_segment_mth_1 (
geo_area_sid INTEGER NOT NULL OPTIONS(description='Identifier for a client'),
cy_month INTEGER NOT NULL OPTIONS(description='Month identifier'),
model_sid INTEGER NOT NULL OPTIONS(description='ID of a rfm model'),
mth_m_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
mth_rf_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of recency-frequency segments from rfm model'),
mth_st_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of strategic segments from rfm model'),
mth_fr_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of frequency segments from rfm model'),
mth_mo_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of new monetary segments from rfm model'),
mth_re_segment_sid INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ids of recency segments from rfm model'),
customer_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key CUSTOMER'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (model_sid, cy_month, geo_area_sid, customer_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : month level of recency-frequency and monetary segments per customer');