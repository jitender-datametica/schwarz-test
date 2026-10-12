/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: V_REF_MONETARY_MTH
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

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_REF_M_SEGMENT_MTH_2
COMMENT = 'Lidlplus : monetary segments - referenece table'
(
 MTH_M_SEGMENT_SID     COMMENT 'ids of monetary segments from rfm model'
,MTH_M_SEGMENT_NAME    COMMENT 'monetary segments, m_segment: high, medium, low'
,MTH_M_SEGMENT_DESCR   COMMENT 'exact description of monetary segments from rfm model'
,LOAD_ID               COMMENT 'Load identifier'
,DWH_CREATED           COMMENT 'Row create time'
,DWH_UPDATED           COMMENT 'Row update time'
)
AS
SELECT
 MTH_M_SEGMENT_SID
,MTH_M_SEGMENT_NAME
,MTH_M_SEGMENT_DESCR
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_REF_M_SEGMENT_MTH_2 
;