CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_strategic_segment_mth_1 (mth_st_segment_sid
OPTIONS(description='Ids of STRATEGIC segments from rfm model - used (MTH_RF_SEGMENT_SID) to select p_lew_core.t_ref_segment.segment_sid'),
mth_st_segment_name
OPTIONS(description='STRATEGIC segments, rf_segment: New, Loyal, Occasional, Rare, Inactive, Lost, Special'),
mth_st_segment_descr OPTIONS(description='Exact description of STRATEGIC from rfm model'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `Lidlplus : STRATEGIC segments - referenece table`) AS
SELECT mth_st_segment_sid,
 mth_st_segment_name,
 mth_st_segment_descr,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ref_strategic_segment_mth_1;