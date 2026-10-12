/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2025-03-19 Marcin Kikola    Initial version AP0263904
#------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_ref_ldpl_plan_kpi_item_grp_byr (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
byr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Business year number'),
itemgroup_int_id BIGNUMERIC(38,0) OPTIONS(description='Item group identifier'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
lp_advertising_discount NUMERIC(18,5)
OPTIONS(description='Plan value for Lidl Plus advertising discount in EUR. Used for data patch'),
non_lp_advertising_discount NUMERIC(18,5)
OPTIONS(description='Plan value for Total advertising discount in EUR. Used for data patch'),
total_advertising_discount NUMERIC(18,5)
OPTIONS(description='Plan value for Non Lidl Plus advertising discount in EUR. Used for data patch'),
loyalty_advertising_discount NUMERIC(18,5)
OPTIONS(description='Plan value for Loyalty advertising discount in EUR. Used for data patch'),
promo_advertising_discount NUMERIC(18,5)
OPTIONS(description='Plan value for Promo advertising discount in EUR. Used for data patch'),
lp_advertising_discount_fa NUMERIC(18,5)
OPTIONS(description='Plan value for Lidl Plus advertising discount food aktion in EUR. Used for data patch'),
non_lp_advertising_discount_fa NUMERIC(18,5)
OPTIONS(description='Plan value for Total advertising discount food aktion in EUR. Used for data patch'),
total_advertising_discount_fa NUMERIC(18,5)
OPTIONS(description='Plan value for Non Lidl Plus advertising food aktion discount in EUR. Used for data patch'),
loyalty_advertising_discount_fa NUMERIC(18,5)
OPTIONS(description='Plan value for Loyalty advertising food aktion discount in EUR. Used for data patch'),
promo_advertising_discount_fa NUMERIC(18,5)
OPTIONS(description='Plan value for Promo advertising food aktion discount in EUR. Used for data patch'),
total_unsold_item_procedure NUMERIC(18,5)
OPTIONS(description='Plan value for Total unsold item procedure in EUR. Used for data patch'),
total_permanent_discount_price_area_diff NUMERIC(18,5)
OPTIONS(description='Plan value for Total permanent discount price area difference in EUR. Used for data patch'),
total_net_val_eur_plan NUMERIC(18,5) OPTIONS(description='Plan value for total revenue net value. Used for data patch'),
total_net_val_eur_plan_fa NUMERIC(18,5)
OPTIONS(description='Plan value for total revenue Food Aktion net value. Used for data patch'),
dwh_load_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row created time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id) NOT ENFORCED
);