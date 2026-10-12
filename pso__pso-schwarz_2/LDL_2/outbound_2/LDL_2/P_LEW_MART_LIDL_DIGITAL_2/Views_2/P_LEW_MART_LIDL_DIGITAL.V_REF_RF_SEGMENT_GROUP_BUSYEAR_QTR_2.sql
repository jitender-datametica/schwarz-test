/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-10-20 Pawel Wieczorek  Initial version AP0147492
#  1.1 2022-10-24 Pawel Wieczorek  Repair comment AP0147492
#  1.1 2022-10-28 Pawel Wieczorek  Removed column RF_SEGMENT_GROUP_STATE
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_rf_segment_group_busyear_qtr_2 (busyear_qtr_rf_segment_group_sid
OPTIONS(description='ids of recency-frequency segments group'), busyear_qtr_rf_segment_group_name
OPTIONS(description='recency-frequency segments group'), busyear_qtr_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS : RECENCY-FREQUENCY SEGMENTS GROUP - REFERENCE TABLE`) AS SELECT
 busyear_qtr_rf_segment_group_sid,
 busyear_qtr_rf_segment_group_name,
 busyear_qtr_rf_segment_sid,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ref_rf_segment_group_busyear_qtr_2;