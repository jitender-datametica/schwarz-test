/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: DDL for V_CAL_BUSYEAR_QUARTER_REL
#            
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2023-09-05 Marcin Kikola           AP0092849 Creation of view on the basis of core 
#										            tables that reflects structure of time hierarchy in MIS Lead
#----------------------------------------------------------------------------
*/


/* ==============================================================================
   Table DDL
   ============================================================================== */



CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.v_cal_busyear_quarter_rel
COMMENT ='Relationship table for business year quartal'
(
 busyear_qtr COMMENT'Identifier of the quarter of the busines year'
,cy_month COMMENT 'Month number'
,busyear COMMENT 'Business year'
,dwh_load_id COMMENT 'Load identifier'
,dwh_created COMMENT 'Row create time'
,dwh_updated COMMENT 'Row update time'
)
AS
SELECT 
 busyear_qtr
,cy_month
,busyear
,dwh_load_id 
,dwh_created 
,dwh_updated 
FROM p_lew_mart_lidl_digital.v_cal_busyear_quarter_rel
;