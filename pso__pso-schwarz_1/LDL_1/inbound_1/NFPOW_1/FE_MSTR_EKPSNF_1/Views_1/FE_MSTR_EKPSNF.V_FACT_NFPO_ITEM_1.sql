CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_FACT_NFPO_ITEM_1 (
   nfpo_item_sid                            COMMENT 'Surrogate Key NFPO ITEM_1 INSTANCE.
CBX: CNT_ITEM.REF_NO
LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID'
  ,nfpo_total_item_org_order_qty            COMMENT 'Total order quantity from CBX. Based on columns in t_fact_nfpo_item_local_organization.'
  ,nfpo_adv_stock_qty                       COMMENT 'Promotional quantity '
  ,nfpo_adv_store_cnt                       COMMENT 'Number of stores in the promotion (calculated)'
  ,nfpo_adjust_adv_sales_0_qty              COMMENT 'Pre-orders before advertise date (WT)'
  ,nfpo_adjust_adv_sales_1_qty              COMMENT 'Adjusted advertise sales_1 cumulated until advertise date (WT)'
  ,nfpo_adjust_adv_sales_3_qty              COMMENT 'Adjusted advertise sales_1 cumulated until advertise date (WT) +2'
  ,nfpo_adjust_adv_sales_7_qty              COMMENT 'Adjusted advertise sales_1 cumulated until advertise date (WT) +6'
  ,nfpo_adjust_adv_sales_14_qty             COMMENT 'Adjusted advertise sales_1 cumulated until advertise date (WT) +13'
  ,nfpo_adjust_adv_sales_21_qty             COMMENT 'Adjusted advertise sales_1 cumulated until advertise date (WT) +20'
  ,nfpo_total_adjust_adv_sales_qty          COMMENT 'Total abverkauf bereinigt'
  ,nfpo_total_adjust_sales_qty              COMMENT 'Adjusted total advertise sales_1 quantity cumulated from the beginning of the sales_1 of the first advertising date of the item_1 in the organization without limitation to the advertising period.Ttime range of the cumulation is set to 2 years.'
  ,nfpo_adjust_adv_return_0_qty             COMMENT 'Adjusted returns before advertise date (WT) (should always be 0, possibly cancellations for Online Shop)'
  ,nfpo_adjust_adv_return_1_qty             COMMENT 'Adjusted returns until advertise date (WT)'
  ,nfpo_adjust_adv_return_3_qty             COMMENT 'Adjusted returns until advertise date (WT) +2'
  ,nfpo_adjust_adv_return_7_qty             COMMENT 'Adjusted returns until advertise date (WT) +6'
  ,nfpo_adjust_adv_return_14_qty            COMMENT 'Adjusted returns until advertise date (WT) +13'
  ,nfpo_adjust_adv_return_21_qty            COMMENT 'Adjusted returns until advertise date (WT) +20'
  ,nfpo_total_return_qty                    COMMENT ''
  ,nfpo_adjust_adv_sales_0_net_euro_val     COMMENT 'Adjusted net value of pre-orders before advertise date (WT)'
  ,nfpo_adjust_adv_sales_1_net_euro_val     COMMENT 'Adjusted net sales_1 until advertise date (WT) '
  ,nfpo_adjust_adv_sales_3_net_euro_val     COMMENT 'Adjusted net sales_1 until advertise date (WT) +2'
  ,nfpo_adjust_adv_sales_7_net_euro_val     COMMENT 'Adjusted net sales_1 until advertise date (WT) +6'
  ,nfpo_adjust_adv_sales_14_net_euro_val    COMMENT 'Adjusted net sales_1 until advertise date (WT) +13'
  ,nfpo_adjust_adv_sales_21_net_euro_val    COMMENT 'Adjusted net sales_1 until advertise date (WT) +20'
  ,nfpo_total_adjust_adv_sales_net_euro_val COMMENT 'Total Nettoumsatz bereinigt'
  ,nfpo_adv_sales_7_margin_euro_val         COMMENT 'Purchase price (EK) calculation volume sold until advertise date (WT) +6'
  ,nfpo_expected_item_org_order_purch_net_euro_price COMMENT 'erwarteter EK-Preis (ermittelt mit Durchfallogik), gewichtet aggregiert mit Gewicht Bestellmenge.
Expected purchase price (determined with selection logic), weighted aggregated with weight of order quantity'
  ,nfpo_expected_item_org_order_purch_net_euro_val COMMENT 'Expected net purchase volume: Order quantity * expected purchase price, aggregated by org level. Based on precalculated columns in t_fact_nfpo_item_local_organization.'
  ,nfpo_min_target_sales_gross_euro_price   COMMENT 'Average target gross sales_1 price (ZVP = Zielverkaufspreis) determined by calculating the weighted average over all organizations. Based on precalculated columns in t_fact_nfpo_item_local_organization.'
  ,nfpo_expected_item_org_order_sales_net_euro_val COMMENT 'Expected net sales_1 volume : order quantity * expected sales_1 price.  Based on precalculated columns in t_fact_nfpo_item_local_organization.'
  ,nfpo_expected_item_org_order_margin_rate COMMENT 'Expected margin rate determined by calculating the weighted average over all organizations, from purchase price (EK) current, ZVP and VAT rate (fixed 19%). Based on precalculated columns in t_fact_nfpo_item_local_organization.'
  ,nfpo_item_org_order_purch_net_euro_price COMMENT 'Average charged on price (WBP) from CBX per article, country_1, weighted with order quantity. Aggregated on article level from t_fact_nfpo_item_local_organization.This is not the planned WBP on item_1 level from CBX.'
  ,nfpo_avg_adv_sales_gross_euro_price      COMMENT 'Average gross sales_1 price over all advertise dates (WT gesamt) determined by calculating the weighted average over all organizations.Based on precalculated columns in t_fact_nfpo_item_local_organization.'
  ,nfpo_avg_adv_sales_margin_rate           COMMENT 'Average sales_1 margin rate (Durchschnitts-EK-Kalk-Rate) realized over all advertise dates (WT gesamt). Based on precalculated columns in t_fact_nfpo_item_local_organization_1,'
  ,nfpo_item_unbiased_star_rating_cnt       COMMENT 'count of unbiased sentiment ratings for the item_1'
  ,nfpo_item_avg_unbiased_star_score_meas   COMMENT 'average of unbiased star ratings for the item_1 (currently from online shops only)'
  ,nfpo_item_unbiased_sentiment_rating_cnt  COMMENT 'count of unbiased sentiment ratings for the item_1'
  ,nfpo_item_avg_unbiased_sentiment_score_meas COMMENT 'average of unbiased sentiment ratings for the item_1'
  ,nfpo_item_complaint_sentiment_rating_cnt COMMENT 'count of complaint sentiment ratings for the item_1'
  ,nfpo_item_avg_complaint_sentiment_score_meas COMMENT 'average of complaint sentiment ratings for the item_1'
  ,nfpo_sel_purch_net_euro_price            COMMENT 'EK01_1, price scenario 1, fallback price used for EK aktuell,'
  ,nfpo_ldl_initial_purch_net_euro_price    COMMENT 'EK04_1, price scenario 2, Lidl price, if not available Kaufland price'
  ,nfpo_ldl_final_purch_net_euro_price      COMMENT 'EK4, price scenario 3. Lidl price, if this is not available then Kaufland price'
  ,nfpo_ldl_us_purch_net_price              COMMENT 'EK0, price scenario 6, Lidl price'
  ,nfpo_ldl_us_purch_net_price_curr_cd      COMMENT 'currency code for EK04_1, price scenario 6'
  ,nfpo_ldl_binding_purch_net_euro_price    COMMENT 'EK06_1, price scenario 7. Lidl price, if this is not available Kaufland price'
  ,nfpo_ldl_item_order_purch_net_euro_price COMMENT 'EK08_1, price scenario 9, Lidl price, if not available Kaufland price'
  ,nfpo_ldl_sqm_net_euro_price              COMMENT 'EK09_1, price scenario 11, Lidl price, if not available Kaufland price'
  ,nfpo_planned_item_org_order_purch_net_euro_val COMMENT ''
  ,nfpo_kfl_retail_org_order_cnt            COMMENT ''
  ,nfpo_ldl_retail_org_order_cnt            COMMENT ''
  ,nfpo_kfl_retail_org_sales_cnt            COMMENT ''
  ,nfpo_ldl_retail_org_sales_cnt            COMMENT ''
  ,nfpo_kfl_dig_org_order_cnt               COMMENT ''
  ,nfpo_ldl_dig_org_order_cnt               COMMENT ''
  ,nfpo_kfl_dig_org_sales_cnt               COMMENT ''
  ,nfpo_ldl_dig_org_sales_cnt               COMMENT ''
  ,nfpo_item_cnt                            COMMENT 'Item_1 count on granularity item. Always with 1.'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'Comment 2Do'
AS SELECT
   nfpo_item_sid
  ,nfpo_total_item_org_order_qty
  ,nfpo_adv_stock_qty
  ,nfpo_adv_store_cnt
  ,nfpo_adjust_adv_sales_0_qty
  ,nfpo_adjust_adv_sales_1_qty
  ,nfpo_adjust_adv_sales_3_qty
  ,nfpo_adjust_adv_sales_7_qty
  ,nfpo_adjust_adv_sales_14_qty
  ,nfpo_adjust_adv_sales_21_qty
  ,nfpo_total_adjust_adv_sales_qty
  ,nfpo_total_adjust_sales_qty
  ,nfpo_adjust_adv_return_0_qty
  ,nfpo_adjust_adv_return_1_qty
  ,nfpo_adjust_adv_return_3_qty
  ,nfpo_adjust_adv_return_7_qty
  ,nfpo_adjust_adv_return_14_qty
  ,nfpo_adjust_adv_return_21_qty
  ,nfpo_total_return_qty
  ,nfpo_adjust_adv_sales_0_net_euro_val
  ,nfpo_adjust_adv_sales_1_net_euro_val
  ,nfpo_adjust_adv_sales_3_net_euro_val
  ,nfpo_adjust_adv_sales_7_net_euro_val
  ,nfpo_adjust_adv_sales_14_net_euro_val
  ,nfpo_adjust_adv_sales_21_net_euro_val
  ,nfpo_total_adjust_adv_sales_net_euro_val
  ,nfpo_adv_sales_7_margin_euro_val
  ,nfpo_expected_item_org_order_purch_net_euro_price
  ,nfpo_expected_item_org_order_purch_net_euro_val
  ,nfpo_min_target_sales_gross_euro_price
  ,nfpo_expected_item_org_order_sales_net_euro_val
  ,nfpo_expected_item_org_order_margin_rate
  ,nfpo_item_org_order_purch_net_euro_price
  ,nfpo_avg_adv_sales_gross_euro_price
  ,nfpo_avg_adv_sales_margin_rate
  ,nfpo_item_unbiased_star_rating_cnt
  ,nfpo_item_avg_unbiased_star_score_meas
  ,nfpo_item_unbiased_sentiment_rating_cnt
  ,nfpo_item_avg_unbiased_sentiment_score_meas
  ,nfpo_item_complaint_sentiment_rating_cnt
  ,nfpo_item_avg_complaint_sentiment_score_meas
  ,nfpo_sel_purch_net_euro_price
  ,nfpo_ldl_initial_purch_net_euro_price
  ,nfpo_ldl_final_purch_net_euro_price
  ,nfpo_ldl_us_purch_net_price
  ,nfpo_ldl_us_purch_net_price_curr_cd
  ,nfpo_ldl_binding_purch_net_euro_price
  ,nfpo_ldl_item_order_purch_net_euro_price
  ,nfpo_ldl_sqm_net_euro_price
  ,nfpo_planned_item_org_order_purch_net_euro_val
  ,nfpo_kfl_retail_org_order_cnt
  ,nfpo_ldl_retail_org_order_cnt
  ,nfpo_kfl_retail_org_sales_cnt
  ,nfpo_ldl_retail_org_sales_cnt
  ,nfpo_kfl_dig_org_order_cnt
  ,nfpo_ldl_dig_org_order_cnt
  ,nfpo_kfl_dig_org_sales_cnt
  ,nfpo_ldl_dig_org_sales_cnt
  ,nfpo_item_cnt
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
  
FROM CORE.T_FACT_NFPO_ITEM_1
;