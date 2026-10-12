/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS_AC#.V_BW_LP_ITEM_MIT_COUPON_2
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2024    Ulrich Ross               Init
#     
#                                                                                
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bw_lp_item_mit_coupon_2 (client_id, client_desc, country_iso_cd, cy_month,
cy_month_name, coupon_type_id, coupon_type_desc, coupon_type_group_id, coupon_type_group_desc, coupon_type_subgroup_id,
coupon_type_subgroup_desc, feature_id, feature_desc, feature_group_id, feature_group_desc, feature_subgroup_id,
feature_subgroup_desc, discount_type_id, discount_type_desc, loyalty_id, loyalty_desc, itemgroup_int_id,
itemgroup_int_desc, lidl_plus_abverkauf_bereinigt_ejr_mit_lp_aktion_lj, lidl_plus_umsatz_ejr_mit_lp_aktion_lj,
lidl_plus_preisveraenderung_mit_lp_aktion_lj, lidl_plus_preisveraenderung_mit_lp_aktion_lj_per,
lidl_plus_werbe_pv_mit_lp_aktion_lj, lidl_plus_werbe_pv_mit_lp_aktion_lj_per,
lidl_plus_restantenverwertung_sortiment_mit_lp_aktion_lj, lidl_plus_restantenverwertung_sortiment_mit_lp_aktion_lj_per,
lidl_plus_abschriften_gesamt_mit_lp_aktion_lj, lidl_plus_abschriften_gesamt_mit_lp_aktion_lj_per,
lidl_plus_restantenverwertung_aktion_mit_lp_aktion_lj, lidl_plus_restantenverwertung_aktion_mit_lp_aktion_lj_per,
lidl_plus_bon_mit_lp_aktion_lj, lidl_plus_bon_lw_mit_lp_aktionlj, lidl_plus_einloeser_mit_lp_aktion_lj) AS SELECT *
FROM ldl_p_lew_mart_cs.v_bw_lp_item_mit_coupon_2;