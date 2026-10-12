/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: V_AGG_CUST_REG_DEREG_LDPL_QTR_1
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2023-09-05 Marcin Kikola           Initial version for reporting of registered users on quarters                                       
#  1.1 2024-02-14 Pawel Wieczorek         AP0197960 Added column distinct_reg_user_fg
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   VIEW DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_cust_reg_dereg_ldpl_qtr_1 (client_id
OPTIONS(description='Client identifier'), busyear_qtr
OPTIONS(description='Identifier of the quarter of the busines year'), distinct_reg_user_fg
OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '), cq_total_new_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to current quarter'),
pq_total_new_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to previous quarter'),
pyq_total_new_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to previous year quarter'))
OPTIONS(DESCRIPTION = ` Lidlplus view : Table to provide registration and deregistration of customers count at month level`)
AS SELECT client_id,
 busyear_qtr,
 distinct_reg_user_fg,
 cq_total_new_reg_cnt,
 pq_total_new_reg_cnt,
 pyq_total_new_reg_cnt
FROM ldl_p_lew_mart_lidl_digital.v_agg_cust_reg_dereg_ldpl_qtr_1;