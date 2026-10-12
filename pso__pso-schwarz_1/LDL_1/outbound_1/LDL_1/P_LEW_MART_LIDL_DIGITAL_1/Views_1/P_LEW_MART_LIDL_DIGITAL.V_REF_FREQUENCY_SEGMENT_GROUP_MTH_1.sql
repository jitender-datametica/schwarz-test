CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_frequency_segment_group_mth_1 (mth_fr_segment_group_sid
OPTIONS(description='ids of frequency segments group'), mth_fr_segment_group_name
OPTIONS(description='frequency segments group'), mth_fr_segment_group_active_fg
OPTIONS(description='Description for segment activation, 0 - inactive, 1 - active'), mth_fr_segment_group_active_fg_name
OPTIONS(description='Description for Segment Activation'), mth_fr_segment_sid
OPTIONS(description='ids of frequency segments from rfm model'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `Lidlplus : frequency segments group - reference`) AS SELECT mth_fr_segment_group_sid,
 mth_fr_segment_group_name,
 mth_fr_segment_group_active_fg,
 mth_fr_segment_group_active_fg_name,
 mth_fr_segment_sid,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ref_frequency_segment_group_mth_1;