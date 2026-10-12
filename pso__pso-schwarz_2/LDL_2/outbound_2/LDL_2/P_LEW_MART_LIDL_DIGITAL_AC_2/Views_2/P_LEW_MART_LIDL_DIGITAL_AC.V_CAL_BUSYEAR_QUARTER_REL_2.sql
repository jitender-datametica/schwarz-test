/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: DDL for V_CAL_BUSYEAR_QUARTER_REL_2
#            
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2023-09-05 Marcin Kikola           AP0092849 Creation of view on the basis of core 
#										            tables that reflects structure of time hierarchy_2 in MIS Lead
#----------------------------------------------------------------------------
*/


/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_cal_busyear_quarter_rel_2 (busyear_qtr
OPTIONS(description='Identifier of the quarter of the busines year'), cy_month OPTIONS(description='Month number'),
busyear OPTIONS(description='Business year'), dwh_load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `RELATIONSHIP TABLE FOR BUSINESS YEAR QUARTAL`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_cal_busyear_quarter_rel_2;