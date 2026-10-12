/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_A_ADV_PERIOD
#-------------------------------------------------------------------------------
# Description: Create DDL for Aggregation Table Aggregation Table on Adv.-Period
# Encoding. UTF8noBom
#
# Aggregation Levels:
# ===================
# Adv.Period,COUNTRY,ActionType
# Adv.Period,WH,ActionType
# 
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-10 Dirk Hering     Fixes, formatting
#  1.2  2021-08-27 Mike Davis      FK support (now removed)
#  1.3	2022-06-26 Nikolai Toknov	Drop column PRICE_BUY_NET
#  1.4  2022-06-27 Nikolai Toknov	Add ADV_WEEK_ID and ADV_WEEK_MSTR_ID
#  1.5	2022-07-05 Nikolai Toknov	Adjusting columns types 
#  2.0  2022-09-27 Nikolai Toknov	Add A_LEVEL_ID to CLUSTER
#  2.1	2022-12-06 Nikolai Toknov	Drop column WAREHOUSE_NAME
#  2.2  2022-12-07 Nikolai Toknov	Change dafault values
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC. 
#  4.1  2024-11-18 Nikolai Toknov	Add PV-columns 
#  4.2  2025-01-19 Nikolai Toknov	Change data type TOTAL_RECEIPT_PER_STORE_CNT
#  4.4  2025-02-03 Nikolai Toknov	Add column ADV_PERIOD_CNT
#-------------------------------------------------------------------------------
*/

/*
VC:
ADV_WEEK_MSTR_ID
ADV_PERIOD_MSTR_ID

*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_a_adv_period (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT:==1'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
adv_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Advertising Week e.g. 202137 for week 37 of 2021'),
adv_period_id INTEGER DEFAULT 888853 NOT NULL
OPTIONS(description='Unique identifier of Adv. Period. e.g. 20212413 Adv.Period from Mon to Wednesday Adv.Week 2021/24'),
warehouse_sid INTEGER DEFAULT - 2000 NOT NULL OPTIONS(description='Warehouse Surrogate ID L2'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse Number  / code from Wawi'),
action_type_id INTEGER DEFAULT - 2000 NOT NULL OPTIONS(description='Action Type 1-::NP and 2::NF | 3::FA | 1 ::PV'),
a_level_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Aggregation Level of the KPI'),
adv_period_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of unique store-level (start and end dates) periods.'),
add_receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_receipt_per_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='Additional number of receipts, caused by the advertised PV item per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Additional TurnOVER, caused by the advertised PV item. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='Additional TurnOVER, caused by the advertised PV item, per store (where the PV item was sold). Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_revenue_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='Additional Revenue, caused by the advertised PV item per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
adv_item_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of action items that have been sold in any action_type (PV / NF / FA) during an advertising period.'),
adv_item_fa_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of FA action items that have been sold during an advertising period.'),
adv_item_nf_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of NF action items that have been sold during an advertising period.'),
adv_item_pv_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of PV action items that have been sold during an advertising period.'),
adv_item_pv_lp_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of action items that have been sold as action_type LP during an advertising period, in the region of a chosen related advertising week.'),
adv_item_pv_npps_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of action items that have been sold as action_type PD during an advertising period, in the region of a chosen related advertising week.'),
adv_item_pv_wawi_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of action items that have been sold as action_type WAWI during an advertising period, in the region of a chosen related advertising week.'),
adv_receipt_adv_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Total action net turnOVER (only the advertised items), of receipts that contain the specific advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.'),
adv_receipt_np_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Normal price net turnOVER of receipts: Sum of the net turnOVER of all other non-advertised items of receipts containing the advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of all advertised items (including the specific advertised item) is excluded. See descriptions of the detailed formula components.'),
adv_receipt_total_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Total net turnOVER of receipts (promotion, non-promotion items), that contain the specific advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.'),
base_receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Expected/estimated number of receipts with specific item / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.'),
base_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Expected/estimated turnOVER of specific item / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.'),
base_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='Expected / estimated sold quantity of the action item within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.'),
base_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Expected / estimated generated revenue of the action item within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.'),
cherry_picker_receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of\"cherry picker\" receipts, that contain the PV item and the net turnOVER sum of all PV items on this receipt is at least 70% of the total receipt turnOVER. Only calculated for PV items. Return receipts are ignored. Not trivially aggregable.'),
cherry_picker_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
deliv_qty BIGNUMERIC(38,5)
OPTIONS(description='Delivered Quantity (pc/kg) of the advertised NF/FA item. This is the sum of the deliveries (5 days before the period start date, up to 13 days after the period start date) and the stock on the 6th day before the period start date. Only for NF/FA items.'),
heavy_buyer_receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of\"heavy buyer\" receipts, which contain the advertised item (any type PV / NF / FA) and whose net turnOVER sum of all advertised items (any type PV / NF / FA) on this receipt is at least 70% of the total receipt\'s turnOVER, and the sales quantity sum of all these advertised items on this receipt is at least 70% of the total receipt\'s sales quantity. Return receipts are ignored. Not trivially aggregable.'),
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
receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of advertised items receipts for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item and possibly other items. The advertised item can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item was bought, independently of the sold quantity.'),
receipt_cnt_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Share of All Total Receipts in %: Share of the receipts that contain this advertised item, of the total number of receipts (containing promotion and / or non-promotion items), of a country for the specific timeframe (advertising period / advertising week).'),
receipt_per_store_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of advertised items receipts per store for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item and possibly other items. The advertised item can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item was bought, independently of the sold quantity.'),
restbon_np_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Rest of the receipt having a normal price: Average sum of the net turnOVER of all other non-advertised items of receipts containing the advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of all advertised items (including the specific advertised item) is excluded. See descriptions of the detailed formula components.'),
restbon_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Rest of the receipt: Average sum of the net turnOVER of all other items (incl. other advertised items) of receipts containing the advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of the advertised item is excluded. See descriptions of the detailed formula components.'),
restbon_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='The generated revenue (turnOVER minus buying price volume) of all items (promotion, non-promotion items) of the rest of the receipts (excluding the action item), which contain the advertised item. For the specific timeframe (advertising period / advertising week), in local currency.'),
store_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of stores that sold the action item in the specific timeframe (advertising period / advertising week), in the region.For NF/FA items, additional 5 days prior advertising period are considered. No trivial aggregation, because each store might have multiple different items advertised.'),
total_receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Total number of all receipts (containing promotion and / or non-promotion items) of a country for the specific timeframe (advertising period / advertising week).'),
total_receipt_per_store_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Total number of all receipts (containing promotion and / or non-promotion items) per store of a country for the specific timeframe (advertising period / advertising week).'),
total_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Total net turnOVER of all items (promotion, non-promotion items) of a country for the specific timeframe (advertising period / advertising week), in local currency. Returns are ignored. Especially on advertising week level: only the 7 days of the advertising week are considered.'),
turnover_1d_pct BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only) of the first day of the advertising period.For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_1d_qty BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) of advertised items (NF / FA / PV) of the first day of the advertising period.For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_3d_pct BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_3d_qty BIGNUMERIC(38,5)
OPTIONS(description='The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_7d_pct BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_7d_qty BIGNUMERIC(38,5)
OPTIONS(description='The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_margin_pct BIGNUMERIC(38,5)
OPTIONS(description='Revenue generated (turnOVER minus buying price volume) with this sold action item vs. TurnOVER in %.'),
turnover_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='Net turnOVER of the advertised item per store, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Net turnOVER of the advertised item, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Total TurnOVER Share in %: TurnOVER of this advertised item vs. the total turnOVER of all items (promo, non-promo) of the country, for the specific timeframe (advertising period / advertising week).'),
turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) of advertised items (NF / FA / PV) during their advertising period.For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Revenue generated with this sold action item. Absolute value of turnOVER minus buying price volume.'),
turnover_revenue_net_store_val BIGNUMERIC(38,5) OPTIONS(description='Absolute revenue in local currency per store.'),
volume_buy_net_val BIGNUMERIC(38,5)
OPTIONS(description='Buying Volume based on sales in local currency. Calculated as the net buying price, multiplied by the sales quantity of this advertised item during the period.'),
total_store_cnt INTEGER DEFAULT 0
OPTIONS(description='Number of stores that sold the any items in the specific timeframe (advertising period / advertising week), in the region.'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, adv_period_id, warehouse_sid, action_type_id, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, a_level_id
OPTIONS(description='Aggregation Table on Adv.-Period');