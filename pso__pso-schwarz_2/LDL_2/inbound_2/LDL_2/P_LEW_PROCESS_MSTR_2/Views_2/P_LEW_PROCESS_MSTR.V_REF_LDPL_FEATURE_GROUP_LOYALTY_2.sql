/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.1 2024-05-21 Marcin Kikoła            AP0206303 Introduction of Loyalty_attribute
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_REF_LDPL_FEATURE_GROUP_LOYALTY_2 
COMMENT = 'Lidl Plus Loyalty' 
(
  LOYALTY_ID  COMMENT 'Loyalty attribute identifier'
 ,LOYALTY_DESC COMMENT 'Loyalty attribute description'
 ,DWH_LOAD_ID COMMENT 'Load identifier'
 ,DWH_CREATED COMMENT 'Row insert time' 
 ,DWH_UPDATED  COMMENT 'Row update time'
 )
 AS
 SELECT
 LOYALTY_ID  
,LOYALTY_DESC
,DWH_LOAD_ID 
,DWH_CREATED 
,DWH_UPDATED 
FROM P_LEW_PROCESS_MSTR.T_REF_LDPL_FEATURE_GROUP_LOYALTY_2
;

