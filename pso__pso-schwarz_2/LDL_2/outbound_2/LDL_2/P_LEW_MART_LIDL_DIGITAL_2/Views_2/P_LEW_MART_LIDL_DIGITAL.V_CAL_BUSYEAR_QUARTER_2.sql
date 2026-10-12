/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: DDL for V_CAL_BUSYEAR_QUARTER_2
#            
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2023-08-09 Marcin Kikola           AP0092849 Creation of view on the basis of core 
#										            tables that reflects structure of time hierarchy_2 in MIS Lead
#  1.1 2023-09-05 Marcin Kikola           Change in the list of columns
#----------------------------------------------------------------------------
*/


/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_cal_busyear_quarter_2 (busyear_qtr
OPTIONS(description='Identifier of the quarter of the busines year'), busyear OPTIONS(description='Business year'),
qtr_of_busyear_id OPTIONS(description='Quarter of the business year, i.g. 2 if the busyear_qtr is 20212'),
busyear_qtr_name
OPTIONS(description='Name of the quarter of the business year, e.g. q1/2021 if the busyear_qtr is 20211'),
busyear_qtr_begin_month OPTIONS(description='Starting month of bussiness quartal'), busyear_qtr_end_month
OPTIONS(description='Ending month of bussiness quartal'), by_qtr_seq
OPTIONS(description='The difference to the most recent quartal (daily updated)'), by_qtr_prev_1q
OPTIONS(description='Previous quarter of business years. if the current qurater is 20211 then the previous one is 20204'),
by_qtr_prev_1y OPTIONS(description='Quarter of the business year one year ago'), by_qtr_prev_2y
OPTIONS(description='Quarter of the business year 2 years ago'), dwh_load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `TABLE FOR BUSINESS YEAR QUARTAL`) AS SELECT busyear_qtr,
 busyear,
 qtr_of_busyear_id,
 busyear_qtr_name,
 busyear_qtr_begin_month,
 busyear_qtr_end_month,
 by_qtr_seq,
 by_qtr_prev_1q,
 by_qtr_prev_1y,
 by_qtr_prev_2y,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_cal_busyear_quarter_2;