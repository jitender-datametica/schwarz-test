/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface:    DDL for t_cust_reg_dereg_ldpl_hist_1
#-----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- ------------------------------------
#  1.0 2022-08-31 Marcin Kikola           Initial version
#                                         Table is the source for all registration tables
#                       
#-----------------------------------------------------------------------------
*/




/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_cust_reg_dereg_ldpl_hist_1 (client_id
OPTIONS(description='Client identifier'), geo_area_sid OPTIONS(description='Client identifier for core tables'),
customer_sid OPTIONS(description='Surrogate Key CUSTOMER'), registration_tmsp
OPTIONS(description='Timestamp of registration'), deregistration_tmsp OPTIONS(description='Timestamp of deregistration'),
load_id OPTIONS(description='Load identifier.'), dwh_created OPTIONS(description='DWH record created timestamp.'),
dwh_updated OPTIONS(description='DWH record updated timestamp.'))
OPTIONS(DESCRIPTION = `LIDLPLUS VIEW : TABLE THAT PROVIDES BASIC DATA FOR  REGISTRATION AND DEREGISTRATION OF CUSTOMERS`)
AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_cust_reg_dereg_ldpl_hist_1;