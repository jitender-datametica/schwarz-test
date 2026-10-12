/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2025-03-19 Marcin Kikola    Initial version AP0263904
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_ref_ldpl_plan_kpi_mth_2 (client_id
OPTIONS(description='Identifier for client'), cy_month OPTIONS(description='Month number'), busyear
OPTIONS(description='Business year number'), harmo_cal_month_no
OPTIONS(description='Harmonized month no per country_2 - month since rollout'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Currency tot identifier'), lp_customer_sid_cnt_plan
OPTIONS(description='Plan value for Lidl Plus identified customers. Used for data patch'),
lp_customer_sid_cnt_plan_busyear
OPTIONS(description='Plan value for Lidl Plus identified customers per business year. Used for data patch'),
lp_receipt_cnt_plan OPTIONS(description='Plan value for Lidl Plus count of receipts. Used for data patch'),
lp_net_val_eur_plan OPTIONS(description='Plan value for Lidl Plus revenue net value in EUR. Used for data patch'),
total_net_val_eur_plan OPTIONS(description='Plan value for total revenue net value in EUR. Used for data patch'),
lp_discount_val_eur_plan OPTIONS(description='Plan value for Lidl Plus discount in EUR. Used for data patch'),
lp_new_reg_cnt_plan OPTIONS(description='Plan value for Lidl Plus registered users. Used for data patch'),
lp_new_reg_cnt_plan_busyear
OPTIONS(description='Plan value for Lidl Plus registered users per business year. Used for data patch'),
lp_advertising_discount OPTIONS(description='Plan value for Lidl Plus advertising discount in EUR. Used for data patch'),
non_lp_advertising_discount
OPTIONS(description='Plan value for Total Plus advertising discount in EUR. Used for data patch'),
total_advertising_discount
OPTIONS(description='Plan value for Non Lidl Plus advertising discount in EUR. Used for data patch'),
loyalty_advertising_discount
OPTIONS(description='Plan value for Loyalty advertising discount in EUR. Used for data patch'),
promo_advertising_discount
OPTIONS(description='Plan value for Loyalty advertising discount in EUR. Used for data patch'), dwh_load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row created time'), dwh_updated
OPTIONS(description='Row update time')) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_ref_ldpl_plan_kpi_mth_2;