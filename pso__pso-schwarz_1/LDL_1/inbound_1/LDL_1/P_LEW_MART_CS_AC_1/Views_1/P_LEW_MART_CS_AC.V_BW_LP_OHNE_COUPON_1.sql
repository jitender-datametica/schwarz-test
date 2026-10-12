/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS_AC#.V_BW_LP_OHNE_COUPON_1
#----------------------------------------------------------------------------
# History:
#  1.0  30.08.2023    Ulrich Ross               Init
#                                               User Story 501416
#                                                                                
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_BW_LP_OHNE_COUPON_1
(
    client_id
  , country_iso_cd
  , client_desc
  , cy_month
  , cy_month_name
  , YEAR
  , new_cust
  , lp_cust_discval
  , non_lp_cust_discval
  , discval_all
  , all_num_recp
  , cm_dereg_cnt
  , new_cust_per_country
  , lp_total_net_val
  , download_cnt
  , non_lp_total_net_val
  , store_cnt
  , cm_reg_cnt
  , non_lp_num_recp
  , lp_cust_recp
  , cm_total_new_reg_cnt
  , reg_cust
  , all_total_net_val
  , lp_num_recp
  , lp_pricechange_disc_perc
  , non_lp_pricechange_disc_perc
  , all_pricechange_disc_perc
  , lp_pricechange_ejr_perc
  , lp_active_cust
  , lp_revenue_share_perc
  , lp_bon_id_rate
  , lp_buying_freq
  , lp_revnue_per_cust
  , lp_avg_bon
  , non_lp_avg_bon
  , all_avg_bon  
 )
AS
SELECT  
    client_id
  , country_iso_cd
  , client_desc
  , cy_month
  , cy_month_name
  , YEAR
  , new_cust
  , lp_cust_discval
  , non_lp_cust_discval
  , discval_all
  , all_num_recp
  , cm_dereg_cnt
  , new_cust_per_country
  , lp_total_net_val
  , download_cnt
  , non_lp_total_net_val
  , store_cnt
  , cm_reg_cnt
  , non_lp_num_recp
  , lp_cust_recp
  , cm_total_new_reg_cnt
  , reg_cust
  , all_total_net_val
  , lp_num_recp
  , lp_pricechange_disc_perc
  , non_lp_pricechange_disc_perc
  , all_pricechange_disc_perc  
  , lp_pricechange_ejr_perc
  , lp_active_cust
  , lp_revenue_share_perc
  , lp_bon_id_rate
  , lp_buying_freq
  , lp_revnue_per_cust
  , lp_avg_bon
  , non_lp_avg_bon
  , all_avg_bon
FROM P_LEW_MART_CS.V_BW_LP_OHNE_COUPON_1  
;
 