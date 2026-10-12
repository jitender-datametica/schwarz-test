/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-10-19 Pawel Wieczorek  Initial version AP0147492
#  1.1 2022-10-24 Pawel Wieczorek  Repair comment AP0147492
#  1.1 2022-10-28 Pawel Wieczorek  Replaced column RF_SEGMENT_GROUP_STATE with columns RF_SEGMENT_GROUP_ACTIVE_FG and RF_SEGMENT_GROUP_ACTIVE_FG_NAME
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_ref_rf_segment_group_mth (
mth_rf_segment_group_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ids of recency-frequency segments group'),
mth_rf_segment_group_name STRING(100) NOT NULL OPTIONS(description='recency-frequency segments group'),
mth_rf_segment_group_active_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Description for segment activation, 0 - inactive, 1 - active'),
mth_rf_segment_group_active_fg_name STRING(20) NOT NULL OPTIONS(description='Description for Segment Activation'),
mth_rf_segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ids of recency-frequency segments from rfm model'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (mth_rf_segment_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : recency-frequency segments group - reference table');