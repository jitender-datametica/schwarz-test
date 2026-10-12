CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_ref_strategic_segment_wk_1 (wk_st_segment_sid
OPTIONS(description='ids of new STRATEGIC segments from rfm model'), wk_st_segment_name
OPTIONS(description='new STRATEGIC segments, m_segment: high, medium, low'), wk_st_segment_descr
OPTIONS(description='exact description of new STRATEGIC segments from rfm model'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `Lidlplus : new STRATEGIC segments - referenece table`) AS
SELECT wk_st_segment_sid,
 wk_st_segment_name,
 wk_st_segment_descr,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.v_ref_strategic_segment_wk_1;