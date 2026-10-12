CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_FACT_NFPO_ITEM_LOCAL_ORGANIZATION_1 (
   nfpo_item_sid                            COMMENT 'Surrogate Key NFPO ITEM_1 INSTANCE.
CBX: CNT_ITEM.REF_NO
LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID'
  ,nfpo_org_sid                             COMMENT 'Surrogate key internal organization.
LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID'
  ,nfpo_item_order_sales_status_id          COMMENT 'Order and sales_1 status_1 of the item_1 in the local organization.
Source - manually filled'
  ,nfpo_total_item_org_order_qty            COMMENT 'Total order quantity from CBX. Based on columns in t_fact_nfpo_item_local_organization_advertise_day.'
  ,nfpo_adv_stock_qty                       COMMENT 'Promotional quantity '
  ,nfpo_adv_store_cnt                       COMMENT 'Number of stores in the promotion (calculated)'
  ,nfpo_adjust_adv_sales_0_qty              COMMENT 'Pre-orders before advertise date (WT)'
  ,nfpo_adjust_adv_sales_1_qty              COMMENT 'Adjusted advertise sales_1 cumulated until advertise date (WT)'
  ,nfpo_adjust_adv_sales_3_qty              COMMENT 'Adjusted advertise sales_1 cumulated until advertise date (WT) +2'
  ,nfpo_adjust_adv_sales_7_qty              COMMENT 'Adjusted advertise sales_1 cumulated until advertise date (WT) +6'
  ,nfpo_adjust_adv_sales_14_qty             COMMENT 'Adjusted advertise sales_1 cumulated until advertise date (WT) +13'
  ,nfpo_adjust_adv_sales_21_qty             COMMENT 'Adjusted advertise sales_1 cumulated until advertise date (WT) +20'
  ,nfpo_total_adjust_adv_sales_qty          COMMENT 'Adjusted total advertise sales_1 cumulated'
  ,nfpo_total_adjust_sales_qty              COMMENT 'Adjusted total advertise sales_1 cumulated from the beginning of the sales_1 for the first advertising date of the item_1 in the organization with out limitation to the advertising period. time range of the cumulation is set to 2 years'
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
  ,nfpo_total_adjust_adv_sales_net_euro_val COMMENT 'Adjusted total net sales_1'
  ,nfpo_total_adjust_adv_sales_gross_euro_val COMMENT 'Adjusted total gross sales_1'
  ,nfpo_adv_sales_1_margin_euro_val         COMMENT 'Purchase price (EK) calculation volume sold until advertise date (WT) '
  ,nfpo_adv_sales_3_margin_euro_val         COMMENT 'Purchase price (EK) calculation volume sold until advertise date (WT) +2'
  ,nfpo_adv_sales_7_margin_euro_val         COMMENT 'Purchase price (EK) calculation volume sold until advertise date (WT) +6'
  ,nfpo_adv_sales_14_margin_euro_val        COMMENT 'Purchase price (EK) calculation volume sold until advertise date (WT) +13'
  ,nfpo_adv_sales_21_margin_euro_val        COMMENT 'Purchase price (EK) calculation volume sold until advertise date (WT) +20'
  ,nfpo_total_adv_sales_margin_euro_val     COMMENT 'Total Purchase price (EK) calculation volume sold,
difference between net sales_1 value and net purchase value. net purch value is adjust sales_1 qty * item_org_order_purch_net_euro_price (Charged on price  country_1 (WBP Land_1)).'
  ,nfpo_item_org_order_deliv_1_cal_week     COMMENT 'Scheduled calendar_1 week for the delivery.
CBX: LDL_ITEM_QUANTITY.LDL_CTRY_DELIVERY_WEEK1, LDL_CTRY_DELIVERY_WEEK2, LDL_CTRY_DELIVERY_WEEK3
LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST.CY_WEEK_DELIVERY'
  ,nfpo_item_org_order_deliv_1_qty          COMMENT 'nfpo_item_org_order_deliv_qty zum 1.LT'
  ,nfpo_item_org_deliv_1_purch_net_euro_val COMMENT 'EK-Volumen, delivery qty * WBP Land_1 (item_org_order_purch_net_euro_price)'
  ,nfpo_item_org_order_deliv_2_cal_week     COMMENT 'Scheduled calendar_1 week for the delivery.
CBX: LDL_ITEM_QUANTITY.LDL_CTRY_DELIVERY_WEEK1, LDL_CTRY_DELIVERY_WEEK2, LDL_CTRY_DELIVERY_WEEK3
LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST.CY_WEEK_DELIVERY'
  ,nfpo_item_org_order_deliv_2_qty          COMMENT 'nfpo_item_org_order_deliv_qty zum 2.LT'
  ,nfpo_item_org_deliv_2_purch_net_euro_val COMMENT 'EK-Volumen, delivery qty * WBP Land_1 (item_org_order_purch_net_euro_price)'
  ,nfpo_item_org_order_deliv_3_cal_week     COMMENT 'Scheduled calendar_1 week for the delivery.
CBX: LDL_ITEM_QUANTITY.LDL_CTRY_DELIVERY_WEEK1, LDL_CTRY_DELIVERY_WEEK2, LDL_CTRY_DELIVERY_WEEK3
LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST.CY_WEEK_DELIVERY'
  ,nfpo_item_org_order_deliv_3_qty          COMMENT 'nfpo_item_org_order_deliv_qty zum 3.LT'
  ,nfpo_item_org_deliv_3_purch_net_euro_val COMMENT 'EK-Volumen, delivery qty * WBP Land_1 (item_org_order_purch_net_euro_price)'
  ,nfpo_expected_item_org_order_purch_net_euro_price COMMENT 'Average expected net pruchase price (EK) determined by calculating the weighted average over all organizations.'
  ,nfpo_expected_item_org_order_purch_net_euro_val COMMENT 'Einkaufsvolumen erwartet: Bestellmenge * erwarteter EK-Preis
Expected net purchase volume: Order quantity * expected purchase price, aggregated by org level.'
  ,nfpo_min_target_sales_gross_euro_price   COMMENT 'Average target gross sales_1 price (ZVP = Zielverkaufspreis) determined by calculating the weighted average over all organizations. Based on precalculated columns in t_fact_nfpo_item_local_organization.'
  ,nfpo_expected_item_sales_vat_rate        COMMENT 'reference vat rate to derive planned sales_1 net price from planned sales_1 gross price'
  ,nfpo_expected_item_org_order_sales_net_euro_price COMMENT 'erwarteter VK_1-Preis (aus ZVP und vat_rate (bisher fix 19%)'
  ,nfpo_expected_item_org_order_sales_net_euro_val COMMENT 'Verkaufsvolumen erwartet: Bestellmenge * erwarteter VK_1-Preis
Expected sales_1 volume: order quantity * expected retail price'
  ,nfpo_expected_item_org_order_margin_rate COMMENT 'erwartete marge: 80: aus EK aktuell, ZVP und VAT-Rate (fest 19%). Gewicht bei Aggregation:Bestellmenge.
Expected margin rate determined by calculating the weighted average over all organizations, from purchase price (EK) current, ZVP and VAT rate (fixed 19%).'
  ,nfpo_item_org_order_purch_net_euro_price COMMENT 'WBP aus CBX pro Artikel_1 und  Land_1
Charged on price (WBP) from CBX per item_1 and country.'
  ,nfpo_adv_stock_purch_net_euro_val        COMMENT 'Mit dem Landes-Einkaufspreis (WBP (nfpo_item_org_order_purch_net_euro_price)) bewertete Aktionsmenge'
  ,nfpo_planned_item_org_order_purch_net_euro_val COMMENT 'WBP Land_1 (ohne Durchfalllogik) * Bestellmenge: "EK Volumen"
Purchasing volume: Charged on price (WBP) country_1 (without selection logic) * Order quantity.'
  ,nfpo_avg_adv_sales_vat_rate              COMMENT 'Average weighted VAT (MWST) Rate WT gesamt (aus den Sparten-Quelldaten)'
  ,nfpo_avg_adv_sales_net_euro_price        COMMENT 'Average net sales_1 price over all advertise dates (WT gesamt),'
  ,nfpo_avg_adv_sales_gross_euro_price      COMMENT 'Average gross sales_1 price over all advertise dates (WT gesamt) determined by calculating the weighted average over all organizations.'
  ,nfpo_avg_adv_sales_margin_rate           COMMENT 'Average sales_1 margin rate (Durchschnitts-EK-Kalk-Rate) realized over all advertise dates (WT gesamt)'
  ,nfpo_avg_adv_sales_margin_euro_price     COMMENT 'Average margin price (Durchschnitts-EK-Kalk) per piece realized over all advertise dates (WT gesamt).'
  ,nfpo_item_unbiased_star_rating_cnt       COMMENT 'count of unbiased star ratings for the item_1 (currently from online shops only)'
  ,nfpo_item_avg_unbiased_star_score_meas   COMMENT 'average of unbiased star ratings for the item_1 (currently from online shops only)'
  ,nfpo_item_unbiased_sentiment_rating_cnt  COMMENT 'count of unbiased sentiment ratings for the item_1'
  ,nfpo_item_avg_unbiased_sentiment_score_meas COMMENT 'average of unbiased sentiment ratings for the item_1'
  ,nfpo_item_complaint_sentiment_rating_cnt COMMENT 'count of complaint sentiment ratings for the item_1'
  ,nfpo_item_avg_complaint_sentiment_score_meas COMMENT 'average of complaint sentiment ratings for the item_1'
  ,nfpo_item_org_order_note_txt             COMMENT 'Order notes of the local NFPO.
CBX: LDL_ITEM_QUANTITY.LDL_ARTICLE_INFORMATION
LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST.CLIENT_ORDER_NOTES'
  ,nfpo_prev_item_1_adjust_adv_sales_7_qty  COMMENT 'Abverkauf bereinigt kumuliert bis WT+6 Vorgänger 1'
  ,nfpo_prev_item_1_adjust_adv_return_7_qty COMMENT 'Rückgaben bis WT+6 Vorgänger 1'
  ,nfpo_planned_item_org_order_deliv_1_qty  COMMENT ''
  ,nfpo_planned_item_org_order_deliv_2_qty  COMMENT ''
  ,nfpo_planned_item_org_order_deliv_3_qty  COMMENT ''
  ,nfpo_planned_item_org_sales_gross_euro_val COMMENT 'not needed, from local organization (ADP ,etc)'
  ,nfpo_item_org_order_carton_kg_weight_meas COMMENT 'Case weight in kg.
CBX: LDL_ITEM_QUANTITY.LDL_CTRY_BRUTTO_KOLLI
LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST.CLIENT_ORDER_CARTON_WEIGHT
core_rel:t_nfpo_item_organization_order_hist.nfpo_item_org_order_carton_kg_weight_meas'
  ,nfpo_prev_item_1_total_item_org_order_qty COMMENT 'Bestellmenge Vorgängerartikel 1'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
  ,dwh_node_cd                              COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
)
COMMENT = 'Comment 2Do'
AS SELECT
   nfpo_item_sid
  ,nfpo_org_sid
  ,nfpo_item_order_sales_status_id
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
  ,nfpo_total_adjust_adv_sales_gross_euro_val
  ,nfpo_adv_sales_1_margin_euro_val
  ,nfpo_adv_sales_3_margin_euro_val
  ,nfpo_adv_sales_7_margin_euro_val
  ,nfpo_adv_sales_14_margin_euro_val
  ,nfpo_adv_sales_21_margin_euro_val
  ,nfpo_total_adv_sales_margin_euro_val
  ,nfpo_item_org_order_deliv_1_cal_week
  ,nfpo_item_org_order_deliv_1_qty
  ,nfpo_item_org_deliv_1_purch_net_euro_val
  ,nfpo_item_org_order_deliv_2_cal_week
  ,nfpo_item_org_order_deliv_2_qty
  ,nfpo_item_org_deliv_2_purch_net_euro_val
  ,nfpo_item_org_order_deliv_3_cal_week
  ,nfpo_item_org_order_deliv_3_qty
  ,nfpo_item_org_deliv_3_purch_net_euro_val
  ,nfpo_expected_item_org_order_purch_net_euro_price
  ,nfpo_expected_item_org_order_purch_net_euro_val
  ,nfpo_min_target_sales_gross_euro_price
  ,nfpo_expected_item_sales_vat_rate
  ,nfpo_expected_item_org_order_sales_net_euro_price
  ,nfpo_expected_item_org_order_sales_net_euro_val
  ,nfpo_expected_item_org_order_margin_rate
  ,nfpo_item_org_order_purch_net_euro_price
  ,nfpo_adv_stock_purch_net_euro_val
  ,nfpo_planned_item_org_order_purch_net_euro_val
  ,nfpo_avg_adv_sales_vat_rate
  ,nfpo_avg_adv_sales_net_euro_price
  ,nfpo_avg_adv_sales_gross_euro_price
  ,nfpo_avg_adv_sales_margin_rate
  ,nfpo_avg_adv_sales_margin_euro_price
  ,nfpo_item_unbiased_star_rating_cnt
  ,nfpo_item_avg_unbiased_star_score_meas
  ,nfpo_item_unbiased_sentiment_rating_cnt
  ,nfpo_item_avg_unbiased_sentiment_score_meas
  ,nfpo_item_complaint_sentiment_rating_cnt
  ,nfpo_item_avg_complaint_sentiment_score_meas
  ,nfpo_item_org_order_note_txt
  ,nfpo_prev_item_1_adjust_adv_sales_7_qty
  ,nfpo_prev_item_1_adjust_adv_return_7_qty
  ,nfpo_planned_item_org_order_deliv_1_qty
  ,nfpo_planned_item_org_order_deliv_2_qty
  ,nfpo_planned_item_org_order_deliv_3_qty
  ,nfpo_planned_item_org_sales_gross_euro_val
  ,nfpo_item_org_order_carton_kg_weight_meas
  ,nfpo_prev_item_1_total_item_org_order_qty
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
  ,dwh_node_cd
  
FROM CORE.T_FACT_NFPO_ITEM_LOCAL_ORGANIZATION_1
;