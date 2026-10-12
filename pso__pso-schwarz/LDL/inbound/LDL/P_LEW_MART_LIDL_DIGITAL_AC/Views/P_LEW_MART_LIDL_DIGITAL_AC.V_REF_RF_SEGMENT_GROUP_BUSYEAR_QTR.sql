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

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_REF_RF_SEGMENT_GROUP_BUSYEAR_QTR
COMMENT = 'Lidlplus : recency-frequency segments group - reference table'
(
 busyear_qtr_rf_segment_group_sid            COMMENT 'ids of recency-frequency segments group'
,busyear_qtr_rf_segment_group_name           COMMENT 'recency-frequency segments group'
,busyear_qtr_rf_segment_sid                  COMMENT 'ids of recency-frequency segments from rfm model'
,load_id                                     COMMENT 'Load identifier'
,dwh_created                                 COMMENT 'Row create time'
,dwh_updated                                 COMMENT 'Row update time'
)
AS
SELECT
 busyear_qtr_rf_segment_group_sid
,busyear_qtr_rf_segment_group_name
,busyear_qtr_rf_segment_sid
,load_id
,dwh_created
,dwh_updated
FROM P_LEW_MART_LIDL_DIGITAL.V_REF_RF_SEGMENT_GROUP_BUSYEAR_QTR 
;