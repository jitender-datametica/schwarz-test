/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS_AC#.V_BW_LP_MIT_COUPON_2
#----------------------------------------------------------------------------
# History:
#  1.0  30.08.2023    Ulrich Ross               Init
#                                               User Story 501416
#                                                                                
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bw_lp_mit_coupon_2 (client_id, client_desc, cy_month, cy_month_name, year,
coupon_type_id, coupon_type_desc, coupon_type_group_id, coupon_type_group_desc, coupon_type_subgroup_id,
coupon_type_subgroup_desc, count_receipt, cnt_cust, discount_val, discount_pct) AS SELECT *
FROM ldl_p_lew_mart_cs.v_bw_lp_mit_coupon_2;