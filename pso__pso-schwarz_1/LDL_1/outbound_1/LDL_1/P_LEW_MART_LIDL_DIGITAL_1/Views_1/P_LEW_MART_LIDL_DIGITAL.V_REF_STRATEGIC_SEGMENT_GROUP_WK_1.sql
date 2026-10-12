CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_strategic_segment_group_wk_1 (wk_st_segment_group_sid
OPTIONS(description='ids of STRATEGIC segments group'), wk_st_segment_group_name
OPTIONS(description='STRATEGIC segments group'), wk_st_segment_group_active_fg
OPTIONS(description='Description for segment activation, 0 - inactive, 1 - active'), wk_st_segment_group_active_fg_name
OPTIONS(description='Description for Segment Activation'), wk_st_segment_sid
OPTIONS(description='ids of STRATEGIC segments from rfm model'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `Lidlplus : STRATEGIC segments group - reference table`) AS SELECT wk_st_segment_group_sid,
 wk_st_segment_group_name,
 wk_st_segment_group_active_fg,
 wk_st_segment_group_active_fg_name,
 wk_st_segment_sid,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ref_strategic_segment_group_wk_1;