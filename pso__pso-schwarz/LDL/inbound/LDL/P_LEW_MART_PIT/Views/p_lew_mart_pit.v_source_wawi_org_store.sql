/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_WAWI_ORG_STORE
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_WAWI_ORG_STORE
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-07-12 Nikolai Toknov	   Initial version
#  2.0	2022-07-16 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_WAWI_ORG_STORE
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_WAWI_ORG_STORE
COMMENT = 'Source View for wawi_org_store'
 AS
   SELECT
     st_loc_sid 													AS STORE_SID
   , client_id
   , COALESCE(dat_rec_start,TO_DATE('1900-01-01','YYYY-MM-DD')) 	AS VALID_FROM_DT
   , COALESCE(dat_rec_end,TO_DATE('9999-12-31','YYYY-MM-DD')) 		AS VALID_TO_DT
 /*, dat_opening
   , dat_real_opening
   , dat_closing*/
   , dat_valid_from
   , closed_fg
   , COALESCE(dat_opening_ovis,TO_DATE('8888-12-31','YYYY-MM-DD')) 	AS OPENING_DT
   , COALESCE(dat_closing_ovis,TO_DATE('8888-12-31','YYYY-MM-DD'))	AS CLOSING_DT
   FROM p_lew_core.t_wawi_org_store;
   
   
