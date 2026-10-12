/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-10-04 Pawel Wieczorek  Initial version AP0147492
#  1.1 2022-10-28 Pawel Wieczorek  Removed column RF_SEGMENT_GROUP_STATE
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_ref_rf_segment_group_wk_2 (
wk_rf_segment_group_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ids of recency-frequency segments group'),
wk_rf_segment_group_name STRING(100) NOT NULL OPTIONS(description='recency-frequency segments group'),
wk_rf_segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ids of recency-frequency segments from rfm model'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (wk_rf_segment_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : recency-frequency segments group - reference table');