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

CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.V_AGG_CUST_REG_DEREG_LDPL_BUSYEAR_1
COMMENT = ' Lidlplus view : Table to provide registration and deregistration of customers count at year level'
(
 client_id COMMENT 'Client identifier'
,busyear COMMENT'Identifier of the year of the busines year'
,cy_total_new_reg_cnt COMMENT 'Number of total new registrations since reporting_start_dt to current year'
,py_total_new_reg_cnt COMMENT 'Number of total new registrations since reporting_start_dt to previous year'
,distinct_reg_user_fg COMMENT 'Distinct registered user flag. Y - registered users for INT'
)
AS 
SELECT
 client_id
,busyear
,cy_total_new_reg_cnt
,py_total_new_reg_cnt
,distinct_reg_user_fg
FROM p_lew_mart_lidl_digital.V_AGG_CUST_REG_DEREG_LDPL_BUSYEAR_1
;