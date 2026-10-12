/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface:    DDL for t_cust_reg_dereg_ldpl_hist
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


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_cust_reg_dereg_ldpl_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client identifier'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client identifier for core tables'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CUSTOMER'),
registration_tmsp DATETIME NOT NULL OPTIONS(description='Timestamp of registration'),
deregistration_tmsp DATETIME NOT NULL
OPTIONS(description='Timestamp of deregistration. 9999-12-31 means that deregistration did not happen'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier.'),
dwh_created DATETIME NOT NULL OPTIONS(description='DWH record created timestamp.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='DWH record updated timestamp.'),
PRIMARY KEY (client_id, geo_area_sid, customer_sid) NOT ENFORCED
)
OPTIONS(description='Lidlplus table : Table that provides basic data for  registration and deregistration of customers');