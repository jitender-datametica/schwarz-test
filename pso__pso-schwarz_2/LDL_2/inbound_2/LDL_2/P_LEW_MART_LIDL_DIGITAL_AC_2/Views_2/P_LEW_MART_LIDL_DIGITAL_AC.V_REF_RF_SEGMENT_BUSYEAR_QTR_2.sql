/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: V_REF_SEGMENT_BIS_QTR
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-06-01 Marcin Kikola    Initial version AP0092849_neue_kundencluster
#  1.1 2022-08-05 Pawel Wieczorek  AP0092849 changing names
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   View DDL
   ============================================================================== */

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_REF_RF_SEGMENT_BUSYEAR_QTR_2
COMMENT = 'Lidlplus : Recency-frequency segments - referenece table'
(
 BUSYEAR_QTR_RF_SEGMENT_SID     COMMENT 'Ids of recency-frequency segments from rfm model - used (BUSYEAR_QTR_RF_SEGMENT_SID) to select p_lew_core.t_ref_segment.segment_sid'
,BUSYEAR_QTR_RF_SEGMENT_NAME    COMMENT 'monetary segments, m_segment: high, medium, low'
,BUSYEAR_QTR_RF_SEGMENT_DESCR   COMMENT 'exact description of monetary segments from rfm model'
,LOAD_ID                        COMMENT 'Load identifier'
,DWH_CREATED                    COMMENT 'Row create time'
,DWH_UPDATED                    COMMENT 'Row update time'
)
AS
SELECT
 BUSYEAR_QTR_RF_SEGMENT_SID
,BUSYEAR_QTR_RF_SEGMENT_NAME
,BUSYEAR_QTR_RF_SEGMENT_DESCR
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_REF_RF_SEGMENT_BUSYEAR_QTR_2 
;