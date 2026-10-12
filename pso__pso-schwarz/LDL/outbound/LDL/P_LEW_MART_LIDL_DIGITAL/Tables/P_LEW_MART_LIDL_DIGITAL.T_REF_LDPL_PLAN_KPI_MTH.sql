/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2025-03-19 Marcin Kikola    Initial version AP0263904
#------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_ref_ldpl_plan_kpi_mth (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Month number'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
lp_customer_sid_cnt_plan NUMERIC(18,5)
OPTIONS(description='Plan value for Lidl Plus identified customers. Used for data patch'),
lp_receipt_cnt_plan NUMERIC(18,5) OPTIONS(description='Plan value for Lidl Plus count of receipts. Used for data patch'),
lp_net_val_eur_plan NUMERIC(18,5) OPTIONS(description='Plan for Lidl Plus revenue net value. Used for data patch'),
total_net_val_eur_plan NUMERIC(18,5) OPTIONS(description='Plan value for total revenue net value. Used for data patch'),
lp_discount_val_eur_plan NUMERIC(18,5) OPTIONS(description='Plan value for Lidl Plus discount. Used for data patch'),
lp_new_reg_cnt_plan NUMERIC(18,5) OPTIONS(description='Plan value for Lidl Plus registered users. Used for data patch'),
lp_advertising_discount NUMERIC(18,5)
OPTIONS(description='Plan value for Lidl Plus advertising discount in EUR. Used for data patch'),
non_lp_advertising_discount NUMERIC(18,5)
OPTIONS(description='Plan value for Total Plus advertising discount in EUR. Used for data patch'),
total_advertising_discount NUMERIC(18,5)
OPTIONS(description='Plan value for Non Lidl Plus advertising discount in EUR. Used for data patch'),
loyalty_advertising_discount NUMERIC(18,5)
OPTIONS(description='Plan value for Loyalty advertising discount in EUR. Used for data patch'),
promo_advertising_discount NUMERIC(18,5)
OPTIONS(description='Plan value for Loyalty advertising discount in EUR. Used for data patch'),
dwh_load_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row created time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, cy_month) NOT ENFORCED
);