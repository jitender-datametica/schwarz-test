/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: V_AGG_CUST_REG_DEREG_LDPL_BUSYEAR_1
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2023-09-05 Rafal Rudnik           Initial version for reporting of registered users on years  
#  1.1 2024-07-09 Pawel Wieczorek        Copy from AP0220468_644592_Fiscal_Year  
#  1.0 2024-07-23 Rafal Rudnik           Added column distinct_reg_user_fg                                       
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   VIEW DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_cust_reg_dereg_ldpl_busyear_1 (client_id
OPTIONS(description='Client identifier'), busyear OPTIONS(description='Identifier of the year of the busines year'),
cy_total_new_reg_cnt OPTIONS(description='Number of total new registrations since reporting_start_dt to current year'),
py_total_new_reg_cnt OPTIONS(description='Number of total new registrations since reporting_start_dt to previous year'),
distinct_reg_user_fg OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '))
OPTIONS(DESCRIPTION = ` Lidlplus view : Table to provide registration and deregistration of customers count at year level`)
AS SELECT client_id,
 busyear,
 cy_total_new_reg_cnt,
 py_total_new_reg_cnt,
 distinct_reg_user_fg
FROM ldl_p_lew_mart_lidl_digital.v_agg_cust_reg_dereg_ldpl_busyear_1;