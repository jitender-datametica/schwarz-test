CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_cust_rfm_segment_mth_1 (geo_area_sid
OPTIONS(description='Identifier for a client'), cy_month OPTIONS(description='Month identifier'), model_sid
OPTIONS(description='ID of a rfm model'), mth_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), mth_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), mth_st_segment_sid
OPTIONS(description='ids of new strategic segments from rfm model'), mth_fr_segment_sid
OPTIONS(description='ids of new frequency segments from rfm model'), mth_re_segment_sid
OPTIONS(description='ids of new recency segments from rfm model'), mth_mo_segment_sid
OPTIONS(description='ids of new monetary segments from rfm model'), customer_sid
OPTIONS(description='Surrogate Key CUSTOMER'), load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time')) AS SELECT geo_area_sid,
 cy_month,
 model_sid,
 mth_m_segment_sid,
 mth_rf_segment_sid,
 mth_st_segment_sid,
 mth_fr_segment_sid,
 mth_re_segment_sid,
 mth_mo_segment_sid,
 customer_sid,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.v_cust_rfm_segment_mth_1;