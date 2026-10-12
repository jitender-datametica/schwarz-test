/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: DDL for V_CAL_BUSYEAR_1
#            
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.1 2024-07-09 Pawel Wieczorek        Copy from AP0220468_644592_Fiscal_Year  
#----------------------------------------------------------------------------
*/


/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.v_cal_busyear_1
COMMENT='Table for business year'
 (
  busyear COMMENT 'Business year'
 ,busyear_begin_month COMMENT 'Starting month of bussiness year'
 ,busyear_end_month COMMENT 'Ending month of bussiness year'
 ,busyear_cy_diff COMMENT 'busyear_cy_diff'
 ,cy_by_seq COMMENT 'The difference to the most recent year'
 ,dwh_load_id COMMENT 'Load identifier'
 ,dwh_created COMMENT 'Row create time'
 ,dwh_updated COMMENT 'Row update time'
  )
AS
SELECT
busyear,
busyear_begin_month,
busyear_end_month,
busyear_cy_diff,
cy_by_seq,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_mart_lidl_digital.v_cal_busyear_1;
