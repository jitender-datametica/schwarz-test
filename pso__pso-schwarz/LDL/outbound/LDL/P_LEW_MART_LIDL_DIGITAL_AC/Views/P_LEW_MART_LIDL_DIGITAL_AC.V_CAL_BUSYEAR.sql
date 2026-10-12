/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: DDL for V_CAL_BUSYEAR
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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_cal_busyear (busyear OPTIONS(description='Business year'),
busyear_begin_month OPTIONS(description='Starting month of bussiness year'), busyear_end_month
OPTIONS(description='Ending month of bussiness year'), busyear_cy_diff OPTIONS(description='busyear_cy_diff'), cy_by_seq
OPTIONS(description='The difference to the most recent year'), dwh_load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `TABLE FOR BUSINESS YEAR`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_cal_busyear;