/*
 * History:
 * 
 * 1.0 2022-01-24 Pawel Wieczorek         #266102 Initial versions
 * 1.1 2022-01-24 Pawel Wieczorek         #266102 Remove space from comments - Table definitions must use trailing commas (test_table_comma_trailing) 
 * 1.2 2022-02-03 Pawel Wieczorek         #266102 Add columns feature_subgroup_id,feature_group_id, coupon_type_subgroup_id and coupon_type_group_id
 * 1.3 2022-04-08 Pawel Wieczorek         #266102 Remove group, subgroup and time and organisation level
 * 1.4 2022-09-23 Marcin Kikola           AP0144589 external id logic added to the definition of the table. Coupon_promo_sid added as id for external id
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_unq_cust_coupon_promo_discount_ldpl_mth (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), cy_month OPTIONS(description='Calendar Year+Month in form YYYYMM'),
move_to_store_id OPTIONS(description='Filialnummer nach letztem Filialumzug'), lidlplus_cust_fg
OPTIONS(description='Lidl Plus Customer Flag'), customer_sid OPTIONS(description='Customer identifier'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'), coupon_promo_sid
OPTIONS(description='Unique identifier of the coupon_promotion (surrogate key in t_coupon_promotion_hist. Default value for Sonstige -2)'),
feature_id
OPTIONS(description='Categorization of LidlPlus Coupons and their Promotion : p_lew_core.t_ref_coupon_promotion_type.coupon_promo_type_sid, based on SCRM NN.dim_promotion.promotion_type_description'),
coupon_type_id
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_coupon_type.orig_coupon_type_sid, based on SCRM L1.promotionhst.category'),
discount_type_id
OPTIONS(description='Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_discount_type.orig_discount_type_sid based on SCRM L1.promotionhst.discount_type'),
cm_cust_act OPTIONS(description='Current Month Customer Active flag 1 for active 0 for not active'), pm_cust_act
OPTIONS(description='Previous Month Customer Active flag 1 for active 0 for not active'), pym_cust_act
OPTIONS(description='Previous Year Month Customer Active flag 1 for active 0 for not active'), cm_discount_val
OPTIONS(description='Current Month Discount value'), pm_discount_val
OPTIONS(description='Previous Month Discount value'), pym_discount_val
OPTIONS(description='Previous Year Month Discount value'), load_id OPTIONS(description='Load identifier'), dwh_inserted
OPTIONS(description='Row insert time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS : UNIQUE CUSTOMER FOR COUPON PROMOTION DISCOUNT AGGREGATED TO MONTH LEVEL`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_agg_unq_cust_coupon_promo_discount_ldpl_mth;