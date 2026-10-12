CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_ref_frequency_segment_mth_2 (mth_fr_segment_sid
OPTIONS(description='ids of new FREQUENCY segments from rfm model'), mth_fr_segment_name
OPTIONS(description='new FREQUENCY segments, m_segment: high, medium, low'), mth_fr_segment_descr
OPTIONS(description='exact description of new FREQUENCY segments from rfm model'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `Lidlplus : new FREQUENCY segments - referenece table`) AS
SELECT mth_fr_segment_sid,
 mth_fr_segment_name,
 mth_fr_segment_descr,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.v_ref_frequency_segment_mth_2;