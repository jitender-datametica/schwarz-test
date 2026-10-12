CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_fact_nfpo_item_local_organization_2 (nfpo_item_sid
OPTIONS(description='''Surrogate Key NFPO ITEM_2 INSTANCE.
CBX: CNT_ITEM.REF_NO
LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID'''),
nfpo_org_sid
OPTIONS(description='''Surrogate key internal organization.
LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID'''),
nfpo_item_order_sales_status_id
OPTIONS(description='''Order and sales_2 status_2 of the item_2 in the local organization.
Source - manually filled'''),
nfpo_total_item_org_order_qty
OPTIONS(description='Total order quantity from CBX. Based on columns in t_fact_nfpo_item_local_organization_advertise_day.'),
nfpo_adv_stock_qty OPTIONS(description='Promotional quantity '), nfpo_adv_store_cnt
OPTIONS(description='Number of stores in the promotion (calculated)'), nfpo_adjust_adv_sales_0_qty
OPTIONS(description='Pre-orders before advertise date (WT)'), nfpo_adjust_adv_sales_1_qty
OPTIONS(description='Adjusted advertise sales_2 cumulated until advertise date (WT)'), nfpo_adjust_adv_sales_3_qty
OPTIONS(description='Adjusted advertise sales_2 cumulated until advertise date (WT) +2'), nfpo_adjust_adv_sales_7_qty
OPTIONS(description='Adjusted advertise sales_2 cumulated until advertise date (WT) +6'), nfpo_adjust_adv_sales_14_qty
OPTIONS(description='Adjusted advertise sales_2 cumulated until advertise date (WT) +13'), nfpo_adjust_adv_sales_21_qty
OPTIONS(description='Adjusted advertise sales_2 cumulated until advertise date (WT) +20'), nfpo_total_adjust_adv_sales_qty
OPTIONS(description='Adjusted total advertise sales_2 cumulated'), nfpo_total_adjust_sales_qty
OPTIONS(description='Adjusted total advertise sales_2 cumulated from the beginning of the sales_2 for the first advertising date of the item_2 in the organization with out limitation to the advertising period. time range of the cumulation is set to 2 years'),
nfpo_adjust_adv_return_0_qty
OPTIONS(description='Adjusted returns before advertise date (WT) (should always be 0, possibly cancellations for Online Shop)'),
nfpo_adjust_adv_return_1_qty OPTIONS(description='Adjusted returns until advertise date (WT)'),
nfpo_adjust_adv_return_3_qty OPTIONS(description='Adjusted returns until advertise date (WT) +2'),
nfpo_adjust_adv_return_7_qty OPTIONS(description='Adjusted returns until advertise date (WT) +6'),
nfpo_adjust_adv_return_14_qty OPTIONS(description='Adjusted returns until advertise date (WT) +13'),
nfpo_adjust_adv_return_21_qty OPTIONS(description='Adjusted returns until advertise date (WT) +20'),
nfpo_total_return_qty OPTIONS(description=''), nfpo_adjust_adv_sales_0_net_euro_val
OPTIONS(description='Adjusted net value of pre-orders before advertise date (WT)'), nfpo_adjust_adv_sales_1_net_euro_val
OPTIONS(description='Adjusted net sales_2 until advertise date (WT) '), nfpo_adjust_adv_sales_3_net_euro_val
OPTIONS(description='Adjusted net sales_2 until advertise date (WT) +2'), nfpo_adjust_adv_sales_7_net_euro_val
OPTIONS(description='Adjusted net sales_2 until advertise date (WT) +6'), nfpo_adjust_adv_sales_14_net_euro_val
OPTIONS(description='Adjusted net sales_2 until advertise date (WT) +13'), nfpo_adjust_adv_sales_21_net_euro_val
OPTIONS(description='Adjusted net sales_2 until advertise date (WT) +20'), nfpo_total_adjust_adv_sales_net_euro_val
OPTIONS(description='Adjusted total net sales_2'), nfpo_total_adjust_adv_sales_gross_euro_val
OPTIONS(description='Adjusted total gross sales_2'), nfpo_adv_sales_1_margin_euro_val
OPTIONS(description='Purchase price (EK) calculation volume sold until advertise date (WT) '),
nfpo_adv_sales_3_margin_euro_val
OPTIONS(description='Purchase price (EK) calculation volume sold until advertise date (WT) +2'),
nfpo_adv_sales_7_margin_euro_val
OPTIONS(description='Purchase price (EK) calculation volume sold until advertise date (WT) +6'),
nfpo_adv_sales_14_margin_euro_val
OPTIONS(description='Purchase price (EK) calculation volume sold until advertise date (WT) +13'),
nfpo_adv_sales_21_margin_euro_val
OPTIONS(description='Purchase price (EK) calculation volume sold until advertise date (WT) +20'),
nfpo_total_adv_sales_margin_euro_val
OPTIONS(description='''Total Purchase price (EK) calculation volume sold,
difference between net sales_2 value and net purchase value. net purch value is adjust sales_2 qty * item_org_order_purch_net_euro_price (Charged on price  country_2 (WBP Land_2)).'''),
nfpo_item_org_order_deliv_1_cal_week
OPTIONS(description='''Scheduled calendar_2 week for the delivery.
CBX: LDL_ITEM_QUANTITY.LDL_CTRY_DELIVERY_WEEK1, LDL_CTRY_DELIVERY_WEEK2, LDL_CTRY_DELIVERY_WEEK3
LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST.CY_WEEK_DELIVERY'''),
nfpo_item_org_order_deliv_1_qty OPTIONS(description='nfpo_item_org_order_deliv_qty zum 1.LT'),
nfpo_item_org_deliv_1_purch_net_euro_val
OPTIONS(description='EK-Volumen, delivery qty * WBP Land_2 (item_org_order_purch_net_euro_price)'),
nfpo_item_org_order_deliv_2_cal_week
OPTIONS(description='''Scheduled calendar_2 week for the delivery.
CBX: LDL_ITEM_QUANTITY.LDL_CTRY_DELIVERY_WEEK1, LDL_CTRY_DELIVERY_WEEK2, LDL_CTRY_DELIVERY_WEEK3
LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST.CY_WEEK_DELIVERY'''),
nfpo_item_org_order_deliv_2_qty OPTIONS(description='nfpo_item_org_order_deliv_qty zum 2.LT'),
nfpo_item_org_deliv_2_purch_net_euro_val
OPTIONS(description='EK-Volumen, delivery qty * WBP Land_2 (item_org_order_purch_net_euro_price)'),
nfpo_item_org_order_deliv_3_cal_week
OPTIONS(description='''Scheduled calendar_2 week for the delivery.
CBX: LDL_ITEM_QUANTITY.LDL_CTRY_DELIVERY_WEEK1, LDL_CTRY_DELIVERY_WEEK2, LDL_CTRY_DELIVERY_WEEK3
LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST.CY_WEEK_DELIVERY'''),
nfpo_item_org_order_deliv_3_qty OPTIONS(description='nfpo_item_org_order_deliv_qty zum 3.LT'),
nfpo_item_org_deliv_3_purch_net_euro_val
OPTIONS(description='EK-Volumen, delivery qty * WBP Land_2 (item_org_order_purch_net_euro_price)'),
nfpo_expected_item_org_order_purch_net_euro_price
OPTIONS(description='Average expected net pruchase price (EK) determined by calculating the weighted average over all organizations.'),
nfpo_expected_item_org_order_purch_net_euro_val
OPTIONS(description='''Einkaufsvolumen erwartet: Bestellmenge * erwarteter EK-Preis
Expected net purchase volume: Order quantity * expected purchase price, aggregated by org level.'''),
nfpo_min_target_sales_gross_euro_price
OPTIONS(description='Average target gross sales_2 price (ZVP = Zielverkaufspreis) determined by calculating the weighted average over all organizations. Based on precalculated columns in t_fact_nfpo_item_local_organization.'),
nfpo_expected_item_sales_vat_rate
OPTIONS(description='reference vat rate to derive planned sales_2 net price from planned sales_2 gross price'),
nfpo_expected_item_org_order_sales_net_euro_price
OPTIONS(description='erwarteter VK_2-Preis (aus ZVP und vat_rate (bisher fix 19%)'),
nfpo_expected_item_org_order_sales_net_euro_val
OPTIONS(description='''Verkaufsvolumen erwartet: Bestellmenge * erwarteter VK_2-Preis
Expected sales_2 volume: order quantity * expected retail price'''),
nfpo_expected_item_org_order_margin_rate
OPTIONS(description='''erwartete marge: 80: aus EK aktuell, ZVP und VAT-Rate (fest 19%). Gewicht bei Aggregation:Bestellmenge.
Expected margin rate determined by calculating the weighted average over all organizations, from purchase price (EK) current, ZVP and VAT rate (fixed 19%).'''),
nfpo_item_org_order_purch_net_euro_price
OPTIONS(description='''WBP aus CBX pro Artikel_2 und  Land_2
Charged on price (WBP) from CBX per item_2 and country.'''),
nfpo_adv_stock_purch_net_euro_val
OPTIONS(description='Mit dem Landes-Einkaufspreis (WBP (nfpo_item_org_order_purch_net_euro_price)) bewertete Aktionsmenge'),
nfpo_planned_item_org_order_purch_net_euro_val
OPTIONS(description='''WBP Land_2 (ohne Durchfalllogik) * Bestellmenge: "EK Volumen"
Purchasing volume: Charged on price (WBP) country_2 (without selection logic) * Order quantity.'''),
nfpo_avg_adv_sales_vat_rate
OPTIONS(description='Average weighted VAT (MWST) Rate WT gesamt (aus den Sparten-Quelldaten)'),
nfpo_avg_adv_sales_net_euro_price OPTIONS(description='Average net sales_2 price over all advertise dates (WT gesamt),'),
nfpo_avg_adv_sales_gross_euro_price
OPTIONS(description='Average gross sales_2 price over all advertise dates (WT gesamt) determined by calculating the weighted average over all organizations.'),
nfpo_avg_adv_sales_margin_rate
OPTIONS(description='Average sales_2 margin rate (Durchschnitts-EK-Kalk-Rate) realized over all advertise dates (WT gesamt)'),
nfpo_avg_adv_sales_margin_euro_price
OPTIONS(description='Average margin price (Durchschnitts-EK-Kalk) per piece realized over all advertise dates (WT gesamt).'),
nfpo_item_unbiased_star_rating_cnt
OPTIONS(description='count of unbiased star ratings for the item_2 (currently from online shops only)'),
nfpo_item_avg_unbiased_star_score_meas
OPTIONS(description='average of unbiased star ratings for the item_2 (currently from online shops only)'),
nfpo_item_unbiased_sentiment_rating_cnt OPTIONS(description='count of unbiased sentiment ratings for the item_2'),
nfpo_item_avg_unbiased_sentiment_score_meas OPTIONS(description='average of unbiased sentiment ratings for the item_2'),
nfpo_item_complaint_sentiment_rating_cnt OPTIONS(description='count of complaint sentiment ratings for the item_2'),
nfpo_item_avg_complaint_sentiment_score_meas OPTIONS(description='average of complaint sentiment ratings for the item_2'),
nfpo_item_org_order_note_txt
OPTIONS(description='''Order notes of the local NFPO.
CBX: LDL_ITEM_QUANTITY.LDL_ARTICLE_INFORMATION
LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST.CLIENT_ORDER_NOTES'''),
nfpo_prev_item_1_adjust_adv_sales_7_qty OPTIONS(description='Abverkauf bereinigt kumuliert bis WT+6 Vorgänger 1'),
nfpo_prev_item_1_adjust_adv_return_7_qty OPTIONS(description='Rückgaben bis WT+6 Vorgänger 1'),
nfpo_planned_item_org_order_deliv_1_qty OPTIONS(description=''), nfpo_planned_item_org_order_deliv_2_qty
OPTIONS(description=''), nfpo_planned_item_org_order_deliv_3_qty OPTIONS(description=''),
nfpo_planned_item_org_sales_gross_euro_val OPTIONS(description='not needed, from local organization (ADP ,etc)'),
nfpo_item_org_order_carton_kg_weight_meas
OPTIONS(description='''Case weight in kg.
CBX: LDL_ITEM_QUANTITY.LDL_CTRY_BRUTTO_KOLLI
LDL: P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST.CLIENT_ORDER_CARTON_WEIGHT
core_rel:t_nfpo_item_organization_order_hist.nfpo_item_org_order_carton_kg_weight_meas'''),
nfpo_prev_item_1_total_item_org_order_qty OPTIONS(description='Bestellmenge Vorgängerartikel 1'), dwh_created_tmsp
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'), dwh_updated_tmsp
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'), dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(description = 'Comment 2Do') 
AS SELECT *
FROM nfpow_core.t_fact_nfpo_item_local_organization_2;