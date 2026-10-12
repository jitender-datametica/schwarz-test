CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_recency_segment_group_mth (mth_re_segment_group_sid
OPTIONS(description='ids of recency segments group'), mth_re_segment_group_name
OPTIONS(description='recency segments group'), mth_re_segment_group_active_fg
OPTIONS(description='Description for segment activation, 0 - inactive, 1 - active'), mth_re_segment_group_active_fg_name
OPTIONS(description='Description for Segment Activation'), mth_re_segment_sid
OPTIONS(description='ids of recency segments from rfm model'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `Lidlplus : recency segments group - reference`) AS SELECT mth_re_segment_group_sid,
 mth_re_segment_group_name,
 mth_re_segment_group_active_fg,
 mth_re_segment_group_active_fg_name,
 mth_re_segment_sid,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ref_recency_segment_group_mth;