/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20190515_2084_reg_and_promo_KPI
#            DDL for v_cust_prog_hist_2
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2019-05-22 Reporting team 2        Initial version
#                                         20190515_2084_reg_and_promo_KPI
#
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_cust_prog_hist_2 (client_id, customer_sid, prog_sid,
registration_tmsp, deregistration_tmsp, load_id, dwh_inserted, dwh_updated)
OPTIONS(DESCRIPTION = `LOYALTY PROGRAM CUSTOMER HISTORY`) AS SELECT client_id,
 customer_sid,
 prog_sid,
 registration_tmsp,
 deregistration_tmsp,
 load_id,
 dwh_inserted,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_cust_prog_hist_2;