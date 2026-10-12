CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_monetary_segment_wk_1 (wk_mo_segment_sid
OPTIONS(description='Ids of new MONETARY segments from rfm model - used (WK_RF_SEGMENT_SID) to select p_lew_core.t_ref_segment.segment_sid'),
wk_mo_segment_name
OPTIONS(description='new MONETARY segments, rf_segment: New, Loyal, Occasional, Rare, Inactive, Lost, Special'),
wk_mo_segment_descr OPTIONS(description='Exact description of new MONETARY from rfm model'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `Lidlplus : new MONETARY segments - referenece table`) AS
SELECT wk_mo_segment_sid,
 wk_mo_segment_name,
 wk_mo_segment_descr,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ref_monetary_segment_wk_1;