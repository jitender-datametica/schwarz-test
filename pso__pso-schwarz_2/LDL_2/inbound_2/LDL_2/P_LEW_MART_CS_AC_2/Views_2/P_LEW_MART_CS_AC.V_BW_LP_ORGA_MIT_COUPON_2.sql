/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS_AC#.V_BW_LP_ORGA_MIT_COUPON_2
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2024    Ulrich Ross               Init
#     
#                                                                                
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_BW_LP_ORGA_MIT_COUPON_2
(
   client_id
  ,client_desc
  ,country_iso_cd
  ,cy_month
  ,cy_month_name
  ,coupon_type_id
  ,coupon_type_desc
  ,coupon_type_group_id
  ,coupon_type_group_desc
  ,coupon_type_subgroup_id
  ,coupon_type_subgroup_desc
  ,feature_id
  ,feature_desc
  ,feature_group_id
  ,feature_group_desc
  ,feature_subgroup_id
  ,feature_subgroup_desc
  ,discount_type_id
  ,discount_type_desc
  ,loyalty_id
  ,loyalty_desc
  ,receipt_total_net_val_uniq
  ,count_customer
  ,lp_preisveraenderung_aktion
  ,lp_preisveraenderung_aktion_prozent
  ,lp_werbepv_aktion
  ,lp_werbe_pv_aktion_prozent
  ,lp_restantenverwert_sort
  ,lp_restantenverwert_sort_prozent
  ,lp_abschriften_gesamt
  ,lp_abschriften_gesamt_prozent
  ,lp_val_restantenverwert_aktion
  ,lp_restantenverwert_aktion_prozent_prozent
 )
 AS

SELECT 
   client_id
  ,client_desc
  ,country_iso_cd
  ,cy_month
  ,cy_month_name
  ,coupon_type_id
  ,coupon_type_desc
  ,coupon_type_group_id
  ,coupon_type_group_desc
  ,coupon_type_subgroup_id
  ,coupon_type_subgroup_desc
  ,feature_id
  ,feature_desc
  ,feature_group_id
  ,feature_group_desc
  ,feature_subgroup_id
  ,feature_subgroup_desc
  ,discount_type_id
  ,discount_type_desc
  ,loyalty_id
  ,loyalty_desc
  ,receipt_total_net_val_uniq
  ,count_customer
  ,lp_preisveraenderung_aktion
  ,lp_preisveraenderung_aktion_prozent
  ,lp_werbepv_aktion
  ,lp_werbe_pv_aktion_prozent
  ,lp_restantenverwert_sort
  ,lp_restantenverwert_sort_prozent
  ,lp_abschriften_gesamt
  ,lp_abschriften_gesamt_prozent
  ,lp_val_restantenverwert_aktion
  ,lp_restantenverwert_aktion_prozent_prozent
FROM p_lew_mart_cs.v_bw_lp_orga_mit_coupon_2  
;