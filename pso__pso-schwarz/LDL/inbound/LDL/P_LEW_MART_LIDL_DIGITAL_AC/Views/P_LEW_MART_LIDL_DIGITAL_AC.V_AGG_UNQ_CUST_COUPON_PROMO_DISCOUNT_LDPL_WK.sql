/*
 * History:
 * 
 * 1.0 2022-01-24 Pawel Wieczorek         #266102 Initial versions
 * 1.1 2022-01-24 Pawel Wieczorek         #266102 Remove space from comments - Table definitions must use trailing commas (test_table_comma_trailing) 
 * 1.2 2022-02-03 Pawel Wieczorek         #266102 Add columns feature_subgroup_id,feature_group_id, coupon_type_subgroup_id and coupon_type_group_id
 * 1.3 2022-04-08 Pawel Wieczorek         #266102 Remove group, subgroup and time and organisation level 
 * 1.4 2022-09-23 Marcin Kikola           AP0144589 external id logic added to the definition of the table. Coupon_promo_sid added as id for external id
 */


CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.v_agg_unq_cust_coupon_promo_discount_ldpl_wk
COMMENT = 'Lidlplus : Unique customer for coupon promotion discount aggregated to week level'
(
     aspect_id COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
    ,client_id COMMENT 'Identifier for client'
    ,cy_week COMMENT 'The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.    [Week Identifier]'
    ,move_to_store_id COMMENT 'Filialnummer nach letztem Filialumzug'
    ,lidlplus_cust_fg COMMENT 'Lidl Plus Customer Flag'
    ,customer_sid COMMENT 'Customer identifier'
    ,currency_iso_cd COMMENT 'ISO code for the currency of the client.'
    ,curr_tot_id COMMENT 'Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'
    ,coupon_promo_sid COMMENT 'Unique identifier of the coupon_promotion (surrogate key in t_coupon_promotion_hist. Default value for Sonstige -2)'
    ,feature_id COMMENT 'Categorization of LidlPlus Coupons and their Promotion : p_lew_core.t_ref_coupon_promotion_type.coupon_promo_type_sid, based on SCRM NN.dim_promotion.promotion_type_description'
    ,coupon_type_id COMMENT 'Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_coupon_type.orig_coupon_type_sid, based on SCRM L1.promotionhst.category'
    ,discount_type_id COMMENT 'Categorization of LidlPlus Coupons : p_lew_core.t_ref_orig_discount_type.orig_discount_type_sid based on SCRM L1.promotionhst.discount_type'  
    ,cw_cust_act COMMENT 'Current Week Customer Active flag 1 for active 0 for not active'
    ,pw_cust_act COMMENT 'Previous Week Customer Active flag 1 for active 0 for not active'
    ,pyw_cust_act COMMENT 'Previous Year Week Customer Active flag 1 for active 0 for not active'  
    ,cw_discount_val COMMENT 'Current Week Discount value'
    ,pw_discount_val COMMENT 'Previous Week Discount value'
    ,pyw_discount_val COMMENT 'Previous Year Week Discount value'    
    ,load_id COMMENT 'Load identifier'
    ,dwh_inserted COMMENT 'Row insert time'
    ,dwh_updated COMMENT 'Row update time'
) 
AS
SELECT
     aspect_id 
    ,client_id
    ,cy_week
    ,move_to_store_id
    ,lidlplus_cust_fg 
    ,customer_sid 
    ,currency_iso_cd 
    ,curr_tot_id 
    ,coupon_promo_sid
    ,feature_id
    ,coupon_type_id
    ,discount_type_id  
    ,cw_cust_act 
    ,pw_cust_act 
    ,pyw_cust_act     
    ,cw_discount_val 
    ,pw_discount_val 
    ,pyw_discount_val    
    ,load_id 
    ,dwh_inserted 
    ,dwh_updated 
FROM p_lew_mart_lidl_digital.v_agg_unq_cust_coupon_promo_discount_ldpl_wk   
;



