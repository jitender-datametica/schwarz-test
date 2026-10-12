/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_A_ADV_WEEK_THEME_NAT
#-------------------------------------------------------------------------------
# Description: Create DDL for Aggregation Table on REGION (Warehouse), Theme NAT and Adv.-Week  
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-03-14 Nikolai Toknov    	Initial version
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1  2024-11-18 Nikolai Toknov	Add PV-columns 
#-------------------------------------------------------------------------------
*/

/*
VC:
ADV_WEEK_MSTR_ID
THEME_GRP_NAT_MSTR_SID
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_a_adv_week_theme_nat (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT:==1'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
adv_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Advertising Week'),
warehouse_sid INTEGER DEFAULT - 2000 NOT NULL OPTIONS(description='Warehouse Surrogate ID L2'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse Number  / code from Wawi'),
theme_grp_nat_sid INTEGER DEFAULT - 1000 NOT NULL OPTIONS(description='FK to Theme Group INTEGER '),
action_type_id INTEGER DEFAULT - 1000 NOT NULL OPTIONS(description='Action Type 1-::NP and 2::NF | 3::FA | 1 ::PV'),
a_level_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Aggregation Level of the KPI'),
add_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_receipt_per_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='Additional number of receipts, caused by the advertised PV item per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Additional TurnOVER, caused by the advertised PV item. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='Additional TurnOVER, caused by the advertised PV item, per store (where the PV item was sold). Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_qty BIGNUMERIC(38,0)
OPTIONS(description='Additional turnover qantity, caused by the advertised PV item. Calculated by number of soled item qty of current week, minus ist baseline value from the last 6 weeks. Only PV.'),
add_turnover_per_store_qty BIGNUMERIC(38,0)
OPTIONS(description='Additional turnover qantity, caused by the advertised PV item per store. Calculated by number of soled item qty of current week, minus ist baseline value from the last 6 weeks. Only PV.'),
add_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_revenue_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='Additional Revenue, caused by the advertised PV item per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
adv_item_cnt BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='PIT KPI-Id:18|Aktionsartikel (Anz.)'),
adv_item_fa_cnt BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='PIT KPI-Id:19|Aktionsartikel FA (Anz.)'),
adv_item_nf_cnt BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='PIT KPI-Id:20|Aktionsartikel NF (Anz.)'),
adv_item_pv_cnt BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='PIT KPI-Id:21|Aktionsartikel PV (Anz.)'),
adv_item_pv_lp_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of action items that have been sold as action_type LP during an advertising period, in the region of a chosen related advertising week.'),
adv_item_pv_npps_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of action items that have been sold as action_type PD during an advertising period, in the region of a chosen related advertising week.'),
adv_item_pv_wawi_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of action items that have been sold as action_type WAWI during an advertising period, in the region of a chosen related advertising week.'),
adv_receipt_adv_turnover_net_val BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:56|Umsatz Aktionsbons Aktionsartikel'),
adv_receipt_np_turnover_net_val BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:22|Aktivierter NP-Umsatz'),
adv_receipt_total_turnover_net_val BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:57|Umsatz Aktionsbons Gesamt'),
base_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='Expected/estimated number of receipts with specific item / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.'),
base_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Expected/estimated turnOVER of specific item / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.'),
base_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='Expected / estimated sold quantity of the action item within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.'),
base_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Expected / estimated generated revenue of the action item within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.'),
cherry_picker_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of\"cherry picker\" receipts, that contain the PV item and the net turnOVER sum of all PV items on this receipt is at least 70% of the total receipt turnOVER. Only calculated for PV items. Return receipts are ignored. Not trivially aggregatable.'),
cherry_picker_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
heavy_buyer_receipt_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of\"heavy buyer\" receipts, which contain the advertised item (any type PV / NF / FA) and whose net turnOVER sum of all advertised items (any type PV / NF / FA) on this receipt is at least 70% of the total receipts turnOVER, and the sales quantity sum of all these advertised items on this receipt is at least 70% of the total receipts sales quantity. Return receipts are ignored. Not trivially aggregatable.'),
heavy_buyer_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='Heavy Buyer Quote in %: Number of Heavy Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
pv_effic_revenue_factor BIGNUMERIC(38,5)
OPTIONS(description='Additional Revenue vs. Additional TurnOVER as a factor, caused by the advertised PV item. Indirectly uses the baseline values for revenue, turnOVER from the last 6 weeks. Only for PV.'),
pv_effic_turnover_factor BIGNUMERIC(38,5)
OPTIONS(description='(Additional TurnOVER minus Costs for the Price Reduction) vs. Costs for the Price Reduction, for the advertised PV item.'),
pv_net_val BIGNUMERIC(38,5)
OPTIONS(description='Absolute Advertising PV value in local currency. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.'),
pv_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Advertising PV as percentage of absolute advertising PV vs. total turnOVER of all items (promo, non-promo).'),
pv_lp_net_val BIGNUMERIC(38,5)
OPTIONS(description='Absolute Advertising PV value in local currency for LP action type. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.'),
pv_lp_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Advertising PV as percentage of absolute advertising PV LP vs. total turnOVER of all items (promo, non-promo).'),
pv_npps_net_val BIGNUMERIC(38,5)
OPTIONS(description='Absolute Advertising PV value in local currency for PD action type. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.'),
pv_npps_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Advertising PV as percentage of absolute advertising PV PD vs. total turnOVER of all items (promo, non-promo).'),
pv_wawi_net_val BIGNUMERIC(38,5)
OPTIONS(description='Absolute Advertising PV value in local currency for WAWI action type. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.'),
pv_wawi_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Advertising PV as percentage of absolute advertising PV WAWI vs. total turnOVER of all items (promo, non-promo).'),
receipt_cnt BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='PIT KPI-Id:29|Bons Aktionsartikel (Anz.) '),
receipt_cnt_share_pct BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:28|Bon Penetration (%)'),
receipt_per_store_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='PIT KPI-Id:30|Bons Aktionsartikel / Filiale (Anz.) '),
restbon_np_turnover_net_val BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:50|Ø-Restbon NP'),
restbon_turnover_net_val BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:48|Ø-Restbon'),
restbon_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='The generated revenue (turnOVER minus buying price volume) of all items (promotion, non-promotion items) of the rest of the receipts (excluding the action item), which contain the advertised item. For the specific timeframe (advertising period / advertising week), in local currency.'),
store_cnt BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='PIT KPI-Id:24|Anz. Filialen Abverkauf'),
total_receipt_cnt BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='PIT KPI-Id:32|Bons Gesamt (Anz.)'),
total_turnover_net_val BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:60|Umsatz Gesamt WW / KW'),
turnover_margin_pct BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:17|Abverkaufs-Kalkulation (%)'),
turnover_net_per_store_val BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:55|Umsatz / Filiale'),
turnover_net_val BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:54|Umsatz'),
turnover_net_val_share_pct BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:62|UA (%)'),
turnover_qty BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='PIT KPI-Id:10|Abverkauf (Werbeperiode) (Stk/kg)'),
turnover_revenue_net_val BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:15|Abverkaufsertrag'),
turnover_revenue_net_store_val BIGNUMERIC(38,5) OPTIONS(description='Absolute revenue in local currency per store.'),
volume_buy_net_val BIGNUMERIC(38,5) OPTIONS(description='PIT KPI-Id:41|EK-Volumen Basis Abverkauf (LW)'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, adv_week_id, warehouse_sid, theme_grp_nat_sid, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, a_level_id
OPTIONS(description='Aggregation Table on REGION (Warehouse), Theme NAT and Adv.-Week');