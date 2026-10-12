/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-10-20 Pawel Wieczorek  Initial version AP0147492
#  1.1 2022-10-24 Pawel Wieczorek  Repair comment AP0147492
#  1.1 2022-10-28 Pawel Wieczorek  Replaced column RF_SEGMENT_GROUP_STATE with columns RF_SEGMENT_GROUP_ACTIVE_FG and RF_SEGMENT_GROUP_ACTIVE_FG_NAME
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_ref_rf_segment_group_mth (mth_rf_segment_group_sid
OPTIONS(description='ids of recency-frequency segments group'), mth_rf_segment_group_name
OPTIONS(description='recency-frequency segments group'), mth_rf_segment_group_active_fg
OPTIONS(description='Description for segment activation, 0 - inactive, 1 - active'), mth_rf_segment_group_active_fg_name
OPTIONS(description='Description for Segment Activation'), mth_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS : RECENCY-FREQUENCY SEGMENTS GROUP - REFERENCE TABLE`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_ref_rf_segment_group_mth;