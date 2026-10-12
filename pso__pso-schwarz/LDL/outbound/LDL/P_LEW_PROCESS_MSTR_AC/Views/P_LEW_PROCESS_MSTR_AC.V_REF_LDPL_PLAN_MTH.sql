/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-12-08 Pawel Wieczorek          Initial version
#  1.1 2022-01-17 Pawel Wieczorek          Change DISCOUNT_PLAN_VAL to PRICE_CHANGE_PLAN_VAL
#  1.2 2022-02-07 Pawel Wieczorek          Change PRICE_CHANGE_PLAN_VAL into two columns PRICE_CHANGE_LP_REV_PLAN_VAL and PRICE_CHANGE_TOT_REV_PLAN_VAL
#  1.2 2022-02-08 Pawel Wieczorek          #261360 Change comments
#  1.3 2022-12-01 Marcin Kikola            Extension of the logic in the table within AP0149031
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_ldpl_plan_mth (client_id
OPTIONS(description='Identifier for client'), cy_month OPTIONS(description='Month number'), harmo_cal_month_no
OPTIONS(description='Harmonized month no per country - month since rollout'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Currency tot identifier'), price_change_lp_rev_plan_val
OPTIONS(description='Plan for LidlPlus Price Change divided by LidlPlus net turnover. 5% is stored as 5.0'),
price_change_tot_rev_plan_val
OPTIONS(description='Plan for LidlPlus Price Change divided by total net turnover. 5% is stored as 5.0. Used for data patch'),
total_net_plan_val OPTIONS(description='Plan for total revenue net value. 5% is stored as 5.0. Used for data patch'),
total_kpges_rev_plan OPTIONS(description='Rvenue plan value taken from KPGES'), total_new_reg_cnt_plan
OPTIONS(description='Plan value for LidlPlus registered users. Used for data patch'), lp_customer_sid_cnt_plan
OPTIONS(description='Plan value for LidlPlus identified customers. Used for data patch'),
price_change_tot_rev_plan_val_gross OPTIONS(description='Calculated value of LP price change'), total_net_plan_val_gross
OPTIONS(description='Calculated value of LP revenue'), dwh_load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row created time'), dwh_updated OPTIONS(description='Row update time')) AS SELECT client_id,
 cy_month,
 harmo_cal_month_no,
 currency_iso_cd,
 curr_tot_id,
 price_change_lp_rev_plan_val,
 price_change_tot_rev_plan_val,
 total_net_plan_val,
 total_kpges_rev_plan,
 total_new_reg_cnt_plan,
 lp_customer_sid_cnt_plan,
 price_change_tot_rev_plan_val_gross,
 total_net_plan_val_gross,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.v_ref_ldpl_plan_mth;