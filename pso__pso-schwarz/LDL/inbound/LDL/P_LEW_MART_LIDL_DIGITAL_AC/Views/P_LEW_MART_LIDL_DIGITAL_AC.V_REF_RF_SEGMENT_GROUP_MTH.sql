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


CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_REF_RF_SEGMENT_GROUP_MTH
COMMENT = 'Lidlplus : recency-frequency segments group - reference table'
(
 mth_rf_segment_group_sid            COMMENT 'ids of recency-frequency segments group'
,mth_rf_segment_group_name           COMMENT 'recency-frequency segments group'
,mth_rf_segment_group_active_fg      COMMENT 'Description for segment activation, 0 - inactive, 1 - active'
,mth_rf_segment_group_active_fg_name COMMENT 'Description for Segment Activation'
,mth_rf_segment_sid                  COMMENT 'ids of recency-frequency segments from rfm model'
,load_id                             COMMENT 'Load identifier'
,dwh_created                         COMMENT 'Row create time'
,dwh_updated                         COMMENT 'Row update time'
)
AS
SELECT
 mth_rf_segment_group_sid
,mth_rf_segment_group_name
,mth_rf_segment_group_active_fg
,mth_rf_segment_group_active_fg_name
,mth_rf_segment_sid
,load_id
,dwh_created
,dwh_updated
FROM P_LEW_MART_LIDL_DIGITAL.V_REF_RF_SEGMENT_GROUP_MTH 
;
