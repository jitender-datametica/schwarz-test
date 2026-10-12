/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: V_MODEL_RUN_2
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2022-04-04 Marcin Kikola    Initial version AP0092849_neue_kundencluster
#  1.1 2022-07-25 Pawel Wieczorek  Adding column BUSYEAR_QTR
#  1.2 2022-07-26 Pawel Wieczorek  Removing column BUSYEAR_QTR, renaming from LAST_RUN_TMSP to RUN_TMSP
#
#------------------------------------------------------------------------------
*/

/* ==============================================================================
   Table DDL
   ============================================================================== */

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_LDPL_MODEL_RUN_2 
COMMENT = 'Latest lidlplus segment model loaded from the core layer'
(
 MODEL_SID  COMMENT 'ID of a rfm model'
,MODEL_NAME COMMENT 'Name of a frm model' 
,GEO_AREA_SID COMMENT 'Identifier for a client'
,GEO_AREA_CD  COMMENT 'Iso cd identifier for a client'
,RUN_TMSP  COMMENT 'Run timestamp for a model'
,ACTIVE_FROM_DT COMMENT 'Time since the model was active'
,ACTIVE_TO_DT COMMENT 'Time till the model was active'
,CY_WEEK COMMENT 'Week identifier'
,CY_MONTH COMMENT 'Month identifier'
,DELETE_FG COMMENT 'Indicates if the given model is out of date'
,LOAD_ID COMMENT 'Load identifier'
,DWH_CREATED  COMMENT 'Row create time'
,DWH_UPDATED  COMMENT 'Row update time'
)
AS
SELECT 
 MODEL_SID 
,MODEL_NAME 
,GEO_AREA_SID
,GEO_AREA_CD 
,RUN_TMSP 
,ACTIVE_FROM_DT
,ACTIVE_TO_DT
,CY_WEEK
,CY_MONTH
,DELETE_FG 
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_LDPL_MODEL_RUN_2
;