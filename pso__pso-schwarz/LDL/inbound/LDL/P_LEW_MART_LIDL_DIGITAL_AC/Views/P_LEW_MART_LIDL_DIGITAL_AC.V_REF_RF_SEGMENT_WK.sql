/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: V_REF_SEGMENT_WK
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-03-30 Marcin Kikola    Initial version AP0092849_neue_kundencluster
#  1.1 2022-08-05 Pawel Wieczorek  AP0092849 changing names
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   View DDL
   ============================================================================== */


/* ==============================================================================
   View DDL
   ============================================================================== */

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_REF_RF_SEGMENT_WK
COMMENT = 'Lidlplus : Recency-frequency segments - referenece table'
(
 WK_RF_SEGMENT_SID     COMMENT 'Ids of recency-frequency segments from rfm model'
,WK_RF_SEGMENT_NAME    COMMENT 'Recency-frequency segments, rf_segment: New, Loyal, Occasional, Rare, Inactive, Lost, Special'
,WK_RF_SEGMENT_DESCR   COMMENT 'Exact description of recency-frequency from rfm model'
,LOAD_ID               COMMENT 'Load identifier'
,DWH_CREATED           COMMENT 'Row create time'
,DWH_UPDATED           COMMENT 'Row update time'
)
AS
SELECT
 WK_RF_SEGMENT_SID
,WK_RF_SEGMENT_NAME
,WK_RF_SEGMENT_DESCR
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_REF_RF_SEGMENT_WK 
;