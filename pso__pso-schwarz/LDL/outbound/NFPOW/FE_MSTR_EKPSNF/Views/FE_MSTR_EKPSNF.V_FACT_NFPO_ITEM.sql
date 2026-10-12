CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_fact_nfpo_item (nfpo_item_sid
OPTIONS(description='''Surrogate Key NFPO ITEM INSTANCE.
CBX: CNT_ITEM.REF_NO
LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID'''),
nfpo_total_item_org_order_qty
OPTIONS(description='Total order quantity from CBX. Based on columns in t_fact_nfpo_item_local_organization.'),
nfpo_adv_stock_qty OPTIONS(description='Promotional quantity '), nfpo_adv_store_cnt
OPTIONS(description='Number of stores in the promotion (calculated)'), nfpo_adjust_adv_sales_0_qty
OPTIONS(description='Pre-orders before advertise date (WT)'), nfpo_adjust_adv_sales_1_qty
OPTIONS(description='Adjusted advertise sales cumulated until advertise date (WT)'), nfpo_adjust_adv_sales_3_qty
OPTIONS(description='Adjusted advertise sales cumulated until advertise date (WT) +2'), nfpo_adjust_adv_sales_7_qty
OPTIONS(description='Adjusted advertise sales cumulated until advertise date (WT) +6'), nfpo_adjust_adv_sales_14_qty
OPTIONS(description='Adjusted advertise sales cumulated until advertise date (WT) +13'), nfpo_adjust_adv_sales_21_qty
OPTIONS(description='Adjusted advertise sales cumulated until advertise date (WT) +20'), nfpo_total_adjust_adv_sales_qty
OPTIONS(description='Total abverkauf bereinigt'), nfpo_total_adjust_sales_qty
OPTIONS(description='Adjusted total advertise sales quantity cumulated from the beginning of the sales of the first advertising date of the item in the organization without limitation to the advertising period.Ttime range of the cumulation is set to 2 years.'),
nfpo_adjust_adv_return_0_qty
OPTIONS(description='Adjusted returns before advertise date (WT) (should always be 0, possibly cancellations for Online Shop)'),
nfpo_adjust_adv_return_1_qty OPTIONS(description='Adjusted returns until advertise date (WT)'),
nfpo_adjust_adv_return_3_qty OPTIONS(description='Adjusted returns until advertise date (WT) +2'),
nfpo_adjust_adv_return_7_qty OPTIONS(description='Adjusted returns until advertise date (WT) +6'),
nfpo_adjust_adv_return_14_qty OPTIONS(description='Adjusted returns until advertise date (WT) +13'),
nfpo_adjust_adv_return_21_qty OPTIONS(description='Adjusted returns until advertise date (WT) +20'),
nfpo_total_return_qty OPTIONS(description=''), nfpo_adjust_adv_sales_0_net_euro_val
OPTIONS(description='Adjusted net value of pre-orders before advertise date (WT)'), nfpo_adjust_adv_sales_1_net_euro_val
OPTIONS(description='Adjusted net sales until advertise date (WT) '), nfpo_adjust_adv_sales_3_net_euro_val
OPTIONS(description='Adjusted net sales until advertise date (WT) +2'), nfpo_adjust_adv_sales_7_net_euro_val
OPTIONS(description='Adjusted net sales until advertise date (WT) +6'), nfpo_adjust_adv_sales_14_net_euro_val
OPTIONS(description='Adjusted net sales until advertise date (WT) +13'), nfpo_adjust_adv_sales_21_net_euro_val
OPTIONS(description='Adjusted net sales until advertise date (WT) +20'), nfpo_total_adjust_adv_sales_net_euro_val
OPTIONS(description='Total Nettoumsatz bereinigt'), nfpo_adv_sales_7_margin_euro_val
OPTIONS(description='Purchase price (EK) calculation volume sold until advertise date (WT) +6'),
nfpo_expected_item_org_order_purch_net_euro_price
OPTIONS(description='''erwarteter EK-Preis (ermittelt mit Durchfallogik), gewichtet aggregiert mit Gewicht Bestellmenge.
Expected purchase price (determined with selection logic), weighted aggregated with weight of order quantity'''),
nfpo_expected_item_org_order_purch_net_euro_val
OPTIONS(description='Expected net purchase volume: Order quantity * expected purchase price, aggregated by org level. Based on precalculated columns in t_fact_nfpo_item_local_organization.'),
nfpo_min_target_sales_gross_euro_price
OPTIONS(description='Average target gross sales price (ZVP = Zielverkaufspreis) determined by calculating the weighted average over all organizations. Based on precalculated columns in t_fact_nfpo_item_local_organization.'),
nfpo_expected_item_org_order_sales_net_euro_val
OPTIONS(description='Expected net sales volume : order quantity * expected sales price.  Based on precalculated columns in t_fact_nfpo_item_local_organization.'),
nfpo_expected_item_org_order_margin_rate
OPTIONS(description='Expected margin rate determined by calculating the weighted average over all organizations, from purchase price (EK) current, ZVP and VAT rate (fixed 19%). Based on precalculated columns in t_fact_nfpo_item_local_organization.'),
nfpo_item_org_order_purch_net_euro_price
OPTIONS(description='Average charged on price (WBP) from CBX per article, country, weighted with order quantity. Aggregated on article level from NFPOW.t_fact_nfpo_item_local_organization.This is not the planned WBP on item level from CBX.'),
nfpo_avg_adv_sales_gross_euro_price
OPTIONS(description='Average gross sales price over all advertise dates (WT gesamt) determined by calculating the weighted average over all organizations.Based on precalculated columns in t_fact_nfpo_item_local_organization.'),
nfpo_avg_adv_sales_margin_rate
OPTIONS(description='Average sales margin rate (Durchschnitts-EK-Kalk-Rate) realized over all advertise dates (WT gesamt). Based on precalculated columns in t_fact_nfpo_item_local_organization,'),
nfpo_item_unbiased_star_rating_cnt OPTIONS(description='count of unbiased sentiment ratings for the item'),
nfpo_item_avg_unbiased_star_score_meas
OPTIONS(description='average of unbiased star ratings for the item (currently from online shops only)'),
nfpo_item_unbiased_sentiment_rating_cnt OPTIONS(description='count of unbiased sentiment ratings for the item'),
nfpo_item_avg_unbiased_sentiment_score_meas OPTIONS(description='average of unbiased sentiment ratings for the item'),
nfpo_item_complaint_sentiment_rating_cnt OPTIONS(description='count of complaint sentiment ratings for the item'),
nfpo_item_avg_complaint_sentiment_score_meas OPTIONS(description='average of complaint sentiment ratings for the item'),
nfpo_sel_purch_net_euro_price OPTIONS(description='EK01, price scenario 1, fallback price used for EK aktuell,'),
nfpo_ldl_initial_purch_net_euro_price
OPTIONS(description='EK04, price scenario 2, Lidl price, if not available Kaufland price'),
nfpo_ldl_final_purch_net_euro_price
OPTIONS(description='EK4, price scenario 3. Lidl price, if this is not available then Kaufland price'),
nfpo_ldl_us_purch_net_price OPTIONS(description='EK0, price scenario 6, Lidl price'),
nfpo_ldl_us_purch_net_price_curr_cd OPTIONS(description='currency code for EK04, price scenario 6'),
nfpo_ldl_binding_purch_net_euro_price
OPTIONS(description='EK06, price scenario 7. Lidl price, if this is not available Kaufland price'),
nfpo_ldl_item_order_purch_net_euro_price
OPTIONS(description='EK08, price scenario 9, Lidl price, if not available Kaufland price'), nfpo_ldl_sqm_net_euro_price
OPTIONS(description='EK09, price scenario 11, Lidl price, if not available Kaufland price'),
nfpo_planned_item_org_order_purch_net_euro_val OPTIONS(description=''), 
nfpo_kfl_retail_org_order_cnt OPTIONS(description=''), 
nfpo_ldl_retail_org_order_cnt OPTIONS(description=''), 
nfpo_kfl_retail_org_sales_cnt OPTIONS(description=''), 
nfpo_ldl_retail_org_sales_cnt OPTIONS(description=''), 
nfpo_kfl_dig_org_order_cnt OPTIONS(description=''), 
nfpo_ldl_dig_org_order_cnt OPTIONS(description=''), 
nfpo_kfl_dig_org_sales_cnt OPTIONS(description=''), 
nfpo_ldl_dig_org_sales_cnt OPTIONS(description=''), 
nfpo_item_cnt OPTIONS(description='Item count on granularity item. Always with 1.'), dwh_created_tmsp
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'), dwh_updated_tmsp
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.')
) 
OPTIONS(description = 'Comment 2Do') 
AS SELECT *
FROM nfpow_core.t_fact_nfpo_item;