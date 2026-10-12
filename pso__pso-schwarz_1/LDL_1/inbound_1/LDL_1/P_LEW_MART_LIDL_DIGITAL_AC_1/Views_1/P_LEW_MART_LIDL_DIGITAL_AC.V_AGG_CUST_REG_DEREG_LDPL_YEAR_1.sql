/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: V_AGG_CUST_REG_DEREG_LDPL_YEAR_1
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2023-09-05 Rafal Rudnik           Initial version for reporting of registered users on kalendar year                                      
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   VIEW DDL
   ============================================================================== */

CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.V_AGG_CUST_REG_DEREG_LDPL_YEAR_1
COMMENT = ' Lidlplus view : Table to provide registration and deregistration of customers count at year level'
(
 client_id COMMENT 'Client identifier'
,cy COMMENT'Identifier of the year of the  kalendar year'
,cy_total_new_reg_cnt COMMENT 'Number of total new registrations since reporting_start_dt to current kalendar year'
,py_total_new_reg_cnt COMMENT 'Number of total new registrations since reporting_start_dt to previous kalendar year'
,distinct_reg_user_fg COMMENT 'Distinct registered user flag. Y - registered users for INT'
)
AS 
SELECT
 client_id
,cy
,cy_total_new_reg_cnt
,py_total_new_reg_cnt
,distinct_reg_user_fg
FROM p_lew_mart_lidl_digital.V_AGG_CUST_REG_DEREG_LDPL_YEAR_1
;