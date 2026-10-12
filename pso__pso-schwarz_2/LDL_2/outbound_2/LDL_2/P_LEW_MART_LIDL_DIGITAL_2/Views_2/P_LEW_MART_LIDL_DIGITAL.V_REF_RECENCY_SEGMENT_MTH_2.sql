CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_recency_segment_mth_2 (mth_re_segment_sid
OPTIONS(description='Ids of new RECENCY segments from rfm model - used (MTH_RF_SEGMENT_SID) to select p_lew_core.t_ref_segment.segment_sid'),
mth_re_segment_name
OPTIONS(description='new RECENCY segments, rf_segment: New, Loyal, Occasional, Rare, Inactive, Lost, Special'),
mth_re_segment_descr OPTIONS(description='Exact description of new RECENCY from rfm model'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `Lidlplus : new RECENCY segments - referenece table`) AS
SELECT mth_re_segment_sid,
 mth_re_segment_name,
 mth_re_segment_descr,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ref_recency_segment_mth_2;