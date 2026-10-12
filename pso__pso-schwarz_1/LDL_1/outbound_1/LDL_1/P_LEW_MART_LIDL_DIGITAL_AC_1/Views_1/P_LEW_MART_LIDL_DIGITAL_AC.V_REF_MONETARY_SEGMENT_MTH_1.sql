CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_ref_monetary_segment_mth_1 (mth_mo_segment_sid
OPTIONS(description='ids of new monetary segments from rfm model'), mth_mo_segment_name
OPTIONS(description='new monetary segments, m_segment: high, medium, low'), mth_mo_segment_descr
OPTIONS(description='exact description of new monetary segments from rfm model'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `Lidlplus : new monetary segments - referenece table`) AS
SELECT mth_mo_segment_sid,
 mth_mo_segment_name,
 mth_mo_segment_descr,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.v_ref_monetary_segment_mth_1;