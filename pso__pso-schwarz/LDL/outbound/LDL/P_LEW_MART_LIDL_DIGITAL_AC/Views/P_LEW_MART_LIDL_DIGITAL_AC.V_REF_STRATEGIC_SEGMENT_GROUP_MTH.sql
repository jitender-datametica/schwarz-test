CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_ref_strategic_segment_group_mth (mth_st_segment_group_sid
OPTIONS(description='ids of STRATEGIC segments group'), mth_st_segment_group_name
OPTIONS(description='STRATEGIC segments group'), mth_st_segment_group_active_fg
OPTIONS(description='Description for segment activation, 0 - inactive, 1 - active'), mth_st_segment_group_active_fg_name
OPTIONS(description='Description for Segment Activation'), mth_st_segment_sid
OPTIONS(description='ids of STRATEGIC segments from rfm model'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `Lidlplus : STRATEGIC segments group - reference table`) AS SELECT mth_st_segment_group_sid,
 mth_st_segment_group_name,
 mth_st_segment_group_active_fg,
 mth_st_segment_group_active_fg_name,
 mth_st_segment_sid,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.v_ref_strategic_segment_group_mth;