/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2025-03-19 Marcin Kikola    Initial version AP0263904
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_ref_ldpl_plan_kpi_item_grp_byr_1 (client_id
OPTIONS(description='Identifier for client'), byr OPTIONS(description='Business year number'), itemgroup_int_id
OPTIONS(description='Item_1 group identifier'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Currency tot identifier'), lp_advertising_discount_busyear
OPTIONS(description='Plan value for Lidl Plus advertising discount in EUR. Used for data patch'),
non_lp_advertising_discount_busyear
OPTIONS(description='Plan value for Total advertising discount in EUR. Used for data patch'),
total_advertising_discount_busyear_old
OPTIONS(description='Plan value for Non Lidl Plus advertising discount in EUR. Used for data patch. No data sent since 2025'),
total_advertising_discount_busyear
OPTIONS(description='Plan value for Non Lidl Plus advertising discount in EUR. Used for data patch. New field added in 2025'),
loyalty_advertising_discount_busyear
OPTIONS(description='Plan value for Loyalty advertising discount in EUR. Used for data patch'),
promo_advertising_discount_busyear
OPTIONS(description='Plan value for Promo advertising discount in EUR. Used for data patch'), lp_advertising_discount_fa
OPTIONS(description='Plan value for Lidl Plus advertising discount food aktion_1 in EUR. Used for data patch'),
non_lp_advertising_discount_fa
OPTIONS(description='Plan value for Total advertising discount food aktion_1 in EUR. Used for data patch'),
total_advertising_discount_fa_old
OPTIONS(description='Plan value for Non Lidl Plus advertising food aktion_1 discount in EUR. Used for data. No data sent since 2025'),
total_advertising_discount_fa
OPTIONS(description='Plan value for Non Lidl Plus advertising food aktion_1 discount in EUR. Used for data patch. New field added in 2025'),
loyalty_advertising_discount_fa
OPTIONS(description='Plan value for Loyalty advertising food aktion_1 discount in EUR. Used for data patch'),
promo_advertising_discount_fa
OPTIONS(description='Plan value for Promo advertising food aktion_1 discount in EUR. Used for data patch'),
total_unsold_item_procedure
OPTIONS(description='Plan value for Total unsold item_1 procedure in EUR. Used for data patch'),
total_permanent_discount_price_area_diff
OPTIONS(description='Plan value for Total permanent discount price area difference in EUR. Used for data patch'),
total_net_val_eur_plan_busyear OPTIONS(description='Plan value for total revenue net value. Used for data patch'),
total_net_val_eur_plan_fa OPTIONS(description='Plan value for total revenue Food Aktion_1 net value. Used for data patch'),
dwh_load_id OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row created time'), dwh_updated
OPTIONS(description='Row update time')) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_ref_ldpl_plan_kpi_item_grp_byr_1;