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

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.v_cust_prog_hist_2
COMMENT = 'Loyalty program customer history'
(
  client_id
, customer_sid
, prog_sid
, registration_tmsp
, deregistration_tmsp
, load_id
, dwh_inserted
, dwh_updated
)
AS 
SELECT
  client_id
, customer_sid
, prog_sid
, registration_tmsp
, deregistration_tmsp
, load_id
, dwh_inserted
, dwh_updated
FROM P_LEW_MART_LIDL_DIGITAL.t_cust_prog_hist_2
;
