/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface:    DDL for t_cust_reg_dereg_ldpl_hist_2
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



CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_CUST_REG_DEREG_LDPL_HIST_2 
COMMENT = 'Lidlplus view : Table that provides basic data for  registration and deregistration of customers'
(
 CLIENT_ID COMMENT 'Client identifier'
,GEO_AREA_SID COMMENT 'Client identifier for core tables'
,CUSTOMER_SID COMMENT 'Surrogate Key CUSTOMER'
,REGISTRATION_TMSP COMMENT 'Timestamp of registration'
,DEREGISTRATION_TMSP COMMENT 'Timestamp of deregistration'
,LOAD_ID COMMENT 'Load identifier.'
,DWH_CREATED COMMENT 'DWH record created timestamp.'
,DWH_UPDATED COMMENT 'DWH record updated timestamp.'
)
AS
SELECT
 CLIENT_ID
,GEO_AREA_SID
,CUSTOMER_SID
,REGISTRATION_TMSP
,DEREGISTRATION_TMSP
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_CUST_REG_DEREG_LDPL_HIST_2
;