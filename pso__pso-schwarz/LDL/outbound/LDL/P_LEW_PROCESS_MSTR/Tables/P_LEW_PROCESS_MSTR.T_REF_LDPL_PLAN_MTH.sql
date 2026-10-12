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
#  1.1 2022-02-07 Pawel Wieczorek          Change PRICE_CHANGE_PLAN_VAL into two columns PRICE_CHANGE_LP_REV_PLAN_VAL and PRICE_CHANGE_TOT_REV_PLAN_VAL
#  1.1 2022-02-08 Pawel Wieczorek          #261360 Change comments
#  1.2 2022-12-01 Marcin Kikola            Extension of the logic in the table within AP0149031
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_ldpl_plan_mth (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Month number'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
price_change_lp_rev_plan_val NUMERIC(18,5)
OPTIONS(description='Plan for LidlPlus Price Change divided by LidlPlus net turnover. 5% is stored as 5.0.'),
price_change_tot_rev_plan_val NUMERIC(18,5)
OPTIONS(description='Plan for LidlPlus Price Change divided by total net turnover. 5% is stored as 5.0. Used for data patch'),
total_net_plan_val NUMERIC(18,5)
OPTIONS(description='Plan for total revenue net value. 5% is stored as 5.0. Used for data patch'),
total_new_reg_cnt_plan NUMERIC(18,5)
OPTIONS(description='Plan value for LidlPlus registered users. Used for data patch'),
lp_customer_sid_cnt_plan NUMERIC(18,5)
OPTIONS(description='Plan value for LidlPlus identified customers. Used for data patch'),
dwh_load_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row created time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, cy_month) NOT ENFORCED
);