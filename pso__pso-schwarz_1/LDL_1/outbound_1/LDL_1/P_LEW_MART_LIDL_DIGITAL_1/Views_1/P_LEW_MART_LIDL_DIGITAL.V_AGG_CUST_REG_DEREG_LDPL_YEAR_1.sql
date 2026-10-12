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
#  1.0 2024-09-10 Rafal Rudnik             Initial version for reporting of registered users on kalendar year

#----------------------------------------------------------------------------
*/



/* ==============================================================================
   VIEW DDL
   ============================================================================== */


-- 
 CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_cust_reg_dereg_ldpl_year_1 (client_id
OPTIONS(description='Client identifier'), cy OPTIONS(description='Identifier of the kalendar year'),
cy_total_new_reg_cnt OPTIONS(description='Number of total new registrations '), py_total_new_reg_cnt
OPTIONS(description='Number of total new registrations '), distinct_reg_user_fg
OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '))
OPTIONS(DESCRIPTION = ` Lidlplus view : Table to provide registration and deregistration of customers count at kalendar year level`)
AS WITH CTE_RANGE AS (SELECT Y.cy,
   MAX(M.cy_month) AS cy_month
  FROM ldl_p_lew_core_ac.v_cal_month_1 AS M
   INNER JOIN ldl_p_lew_core.t_cal_month_1 AS Y ON M.cy_month = Y.cy_month AND Y.cy_month_seq <= 0
  WHERE M.cy_month_seq <= 0
  GROUP BY Y.cy) (SELECT R.client_id,
   y.cy,
   SUM(R.cm_total_new_reg_cnt) AS cy_total_new_reg_cnt_cal,
   SUM(R.pym_total_new_reg_cnt) AS py_total_new_reg_cnt_cal,
   R.distinct_reg_user_fg
  FROM ldl_p_lew_mart_lidl_digital.t_agg_cust_reg_dereg_ldpl_mth_1 AS R
   INNER JOIN CTE_RANGE AS y ON R.cy_month = y.cy_month
  GROUP BY R.client_id,
   y.cy,
   R.distinct_reg_user_fg);