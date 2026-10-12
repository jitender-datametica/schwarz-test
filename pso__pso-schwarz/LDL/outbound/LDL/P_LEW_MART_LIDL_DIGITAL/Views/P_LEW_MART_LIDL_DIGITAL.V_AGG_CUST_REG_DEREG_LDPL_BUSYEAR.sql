/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: V_AGG_CUST_REG_DEREG_LDPL_BUSYEAR
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2024-07-02 Rafal Rudnik             Initial version for reporting of registered users on Year                                       
#  1.1 2024-07-09 Pawel Wieczorek          Copy from AP0220468_644592_Fiscal_Year                                      
#  1.0 2024-07-23 Rafal Rudnik             Added column distinct_reg_user_fg  

#----------------------------------------------------------------------------
*/



/* ==============================================================================
   VIEW DDL
   ============================================================================== */


-- 
 CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_cust_reg_dereg_ldpl_busyear (client_id
OPTIONS(description='Client identifier'), busyear OPTIONS(description='Identifier of the year of the busines year'),
cy_total_new_reg_cnt OPTIONS(description='Number of total new registrations since reporting_start_dt to current year'),
py_total_new_reg_cnt OPTIONS(description='Number of total new registrations since reporting_start_dt to previous year'),
distinct_reg_user_fg OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '))
OPTIONS(DESCRIPTION = ` Lidlplus view : Table to provide registration and deregistration of customers count at business year level`)
AS WITH CTE_RANGE AS (SELECT Y.busyear,
   MAX(M.cy_month) AS cy_month
  FROM ldl_p_lew_core_ac.v_cal_month AS M
   INNER JOIN ldl_p_lew_mart_lidl_digital.v_cal_busyear AS Y ON M.cy_month BETWEEN Y.busyear_begin_month AND Y.busyear_end_month
      AND Y.cy_by_seq <= 0
  WHERE M.cy_month_seq <= 0
  GROUP BY Y.busyear) (SELECT R.client_id,
   y.busyear,
   SUM(R.cm_total_new_reg_cnt) AS cy_total_new_reg_cnt_cal,
   SUM(R.pym_total_new_reg_cnt) AS py_total_new_reg_cnt_cal,
   R.distinct_reg_user_fg
  FROM ldl_p_lew_mart_lidl_digital.t_agg_cust_reg_dereg_ldpl_mth AS R
   INNER JOIN CTE_RANGE AS y ON R.cy_month = y.cy_month
  GROUP BY R.client_id,
   y.busyear,
   R.distinct_reg_user_fg);