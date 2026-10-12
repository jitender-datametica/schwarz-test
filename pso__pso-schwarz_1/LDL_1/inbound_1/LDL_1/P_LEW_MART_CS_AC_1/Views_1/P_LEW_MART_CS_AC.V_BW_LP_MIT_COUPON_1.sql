/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS_AC#.V_BW_LP_MIT_COUPON_1
#----------------------------------------------------------------------------
# History:
#  1.0  30.08.2023    Ulrich Ross               Init
#                                               User Story 501416
#                                                                                
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_BW_LP_MIT_COUPON_1
(
    client_id
  , client_desc
  , cy_month
  , cy_month_name
  , YEAR
  , coupon_type_id
  , coupon_type_desc
  , coupon_type_group_id
  , coupon_type_group_desc
  , coupon_type_subgroup_id
  , coupon_type_subgroup_desc
  , count_receipt    
  , cnt_cust 
  , discount_val 
  , discount_pct 
 )
AS
SELECT  
    client_id
  , client_desc
  , cy_month
  , cy_month_name
  , YEAR
  , coupon_type_id
  , coupon_type_desc
  , coupon_type_group_id
  , coupon_type_group_desc
  , coupon_type_subgroup_id
  , coupon_type_subgroup_desc
  , count_receipt    
  , cnt_cust 
  , discount_val 
  , discount_pct 
FROM P_LEW_MART_CS.V_BW_LP_MIT_COUPON_1  
;