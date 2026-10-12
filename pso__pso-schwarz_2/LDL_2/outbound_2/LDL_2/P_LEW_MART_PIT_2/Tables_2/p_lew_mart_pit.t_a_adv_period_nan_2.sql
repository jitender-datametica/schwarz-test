/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_A_ADV_PERIOD_NAN_2
#-------------------------------------------------------------------------------
# Description: Create DDL for Aggregation Table for ADV_WEEK, ACTION_TYPE, item_2 (NAN)
# Encoding. UTF8noBom
#
# Aggregation Levels:
# ===================
# Adv.Week, NaN, UWG, WGI, WH, ActionType, Medium, Theme
#
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-12 Dirk Hering     	Fixes, formatting
#  1.2  2021-08-27 Mike Davis      	FK support (now removed)
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.4	2022-06-27 Nikolai Toknov	Rename ADV_MEDIUM_-> MEDIUM_
#									Change ADV_THEME_SID -> ADV_THEME_NATIONAL_ and ADV_THEME_INTERNATIONAL_
#  1.5	2022-07-05 Nikolai Toknov	Adjusting columns types 
#  1.6	2022-07-06 Nikolai Toknov	Change column ADV_THEME_NATIONAL_SID,ADV_THEME_INTERNATIONAL_SID -> THEME_GRP_SID 
#  1.7	2022-07-21 Andreas Kurz		PK added WAREHOUSE_SID
#  2.0  2022-09-27 Nikolai Toknov	Add A_LEVEL_ID to CLUSTER
#  2.1	2022-12-06 Nikolai Toknov	Drop column WAREHOUSE_NAME
#  2.2  2022-12-07 Nikolai Toknov	Change dafault values
#  2.3	2023-03-16 Nikolai Toknov	INTEGER /NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INTEGER  - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#  2.4  2023-07-19 Nikolai Toknov   Add MEDIUM_AGG_LIST_DESCR. AP0079142_BS0011293_PIT_REPORTING_ITEM_NEW_COLUMNS
#  2.5  2023-09-06 Andreas Kurz 	Changes INTEGER /NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INTEGER  / NAT aus APT
#									Adding THEME_GRP_CAT Columns 
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1  2024-04-26 Nikolai Toknov	Add 42T-KPIs
#  4.1  2024-11-18 Nikolai Toknov	Add PV-columns 
#  4.2  2024-12-22 Nikolai Toknov	Add columns MEDIUM_SID_LST, MEDIUM_GRP_SID_LST, MEDIUM_GRP_AGG_LIST_DESCR
#  4.3  2025-01-25 Nikolai Toknov	Add columns PRICE_RETAIL_OLD_WEIGHTED_AVG_GROSS, PRICE_RETAIL_NEW_WEIGHTED_AVG_GROSS, CHEAPER_WEIGHTED_AVG_IN_PCT
#  4.4  2025-02-03 Nikolai Toknov	Add column ADV_PERIOD_CNT
#  4.5  2025-03-20 Nikolai Toknov	Add column PV_ON_PV_DESCR
#  4.6	2025-05-14 Nikolai Toknov 	Inkrement 2.1 CR new types of LP-promotions(Mail: 09.05.2025)
#-------------------------------------------------------------------------------
*/
/*
VC:
ADV_WEEK_MSTR_ID
ADV_PERIOD_MSTR_ID
MEDIUM_MSTR_SID
MEDIUM_GRP_MSTR_SID
THEME_GRP_NAT_MSTR_SID
ORIG_ITEM_MSTR_NR
THEME_GRP_NAT_CAT_MSTR_SID
THEME_GRP_INT_MSTR_SID

ALTER table LDL.P_LEW_MART_PIT.T_A_ADV_PERIOD_NAN_2 ADD
	COUPON_AGG_LIST_DESCR							STRING																		COMMENT 'LP Coupons Description';


*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_a_adv_period_nan_2 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT:==1'),
country_iso_cd STRING(3) OPTIONS(description='Country_2 ISO Code = WAWI Country_2 '),
country_descr STRING(16777216) OPTIONS(description='Country_2 Name'),
adv_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Advertising Week'),
adv_period_id INTEGER DEFAULT 88885399 NOT NULL OPTIONS(description='Advertising Period'),
pv_type_id BIGNUMERIC(38,0)
OPTIONS(description='Type of PV (List of PV Types: Wawi PV ::= 1 | LP ::= 2 | PD_2 ::= 3 | -1 ::= N/A | -2 ::= Total PV)'),
medium_sid INTEGER DEFAULT - 2000 NOT NULL OPTIONS(description='Advertising Media, '),
medium_grp_sid INTEGER DEFAULT - 2000 NOT NULL OPTIONS(description='Advertising Media, '),
theme_grp_nat_sid INTEGER DEFAULT - 1000 NOT NULL OPTIONS(description='FK to Theme Group '),
theme_grp_int_sid INTEGER DEFAULT - 1000 NOT NULL OPTIONS(description='FK to Theme Group '),
theme_grp_nat_cat_sid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description=' Unique system ID, sid, for the theme nat group category.'),
medium_sid_lst STRING(16777216)
OPTIONS(description='Comma-separated list of all media_sid in [], in which this item_2 has been advertised during this period.'),
medium_grp_sid_lst STRING(16777216)
OPTIONS(description='Comma-separated list of all grp.media_sid in [], in which this item_2 has been advertised during this period.'),
medium_agg_list_descr STRING(16777216)
OPTIONS(description='Comma-separated list of all advertising media (of all media groups), in which this item_2 has been advertised during this period.'),
medium_grp_agg_list_descr STRING(16777216)
OPTIONS(description='Comma-separated list of all advertising grp.media (of all media groups), in which this item_2 has been advertised during this period.'),
coupon_agg_list_descr STRING(16777216) OPTIONS(description='LP Coupons Description'),
warehouse_sid INTEGER DEFAULT - 2000 NOT NULL OPTIONS(description='Warehouse Surrogate ID L2'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse Number  / code from Wawi'),
orig_item_nr INTEGER NOT NULL OPTIONS(description='Item_2 NaN (National Artikel_2 Nummer) Link to Item_2 History'),
sub_item_grp_sid INTEGER DEFAULT - 2000 NOT NULL
OPTIONS(description='Additional Link to UWG Default values in case of missing UWGs'),
item_grp_int_sid INTEGER DEFAULT - 2000 NOT NULL
OPTIONS(description='Additional Link to WGI Default values in case of missing WGI'),
action_type_id INTEGER DEFAULT - 2000 NOT NULL OPTIONS(description='Action Type 1-::NP and 2::NF | 3::FA | 1 ::PV'),
pv_on_pv_descr STRING(16777216)
OPTIONS(description='Ursprungs-Werbe-PV: Shows if item_2 has already a Werbe-PV applied f.e. when LP-Werbe-PV on WaWi-Werbe-PV we display WaWi-Werbe-PV'),
a_level_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Aggregation Level of the KPI'),
adv_period_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of unique store-level (start and end dates) periods.'),
add_receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_receipt_per_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='Additional number of receipts, caused by the advertised PV item_2 per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='Additional Turnover, caused by the advertised PV item_2, per store. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Additional Turnover, caused by the advertised PV item. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
add_turnover_qty BIGNUMERIC(38,0)
OPTIONS(description='Additional turnover qantity, caused by the advertised PV item. Calculated by number of soled item_2 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.'),
add_turnover_per_store_qty BIGNUMERIC(38,0)
OPTIONS(description='Additional turnover qantity, caused by the advertised PV item_2 per store. Calculated by number of soled item_2 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.'),
adv_item_per_receipt_cnt BIGNUMERIC(38,5)
OPTIONS(description='Average number (pieces) of the advertised item_2 per receipt, which contains this item_2, during the advertising period.'),
add_turnover_revenue_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='Additional Revenue, caused by the advertised PV item_2 per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.'),
adv_receipt_adv_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Total action net turnOVER (only the advertised items), of receipts that contain the specific advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.'),
adv_receipt_np_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Normal price net turnOVER of receipts: Sum of the net turnOVER of all other non-advertised items of receipts containing the advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of all advertised items (including the specific advertised item_2) is excluded. See descriptions of the detailed formula components.'),
adv_receipt_total_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Total net turnOVER of receipts (promotion, non-promotion items), that contain the specific advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.'),
base_receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Expected/estimated number of receipts with specific item_2 / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.'),
base_restbon_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Expected baseline value for Turnover of Receipt Rest (Avg.) from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.'),
base_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Expected/estimated turnOVER of specific item_2 / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.'),
base_turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='Expected / estimated sold quantity of the action item_2 within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.'),
base_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Expected / estimated generated revenue of the action item_2 within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.'),
cheaper_max_pct BIGNUMERIC(38,5)
OPTIONS(description='Maximum price reduction in % for the advertised PV item_2, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_2 type on advertising period level. '),
cheaper_min_pct BIGNUMERIC(38,5)
OPTIONS(description='Minimum price reduction in % for the advertised PV item_2, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_2 type on advertising period level. '),
cheaper_range STRING(16777216)
OPTIONS(description='Price reduction in % for the advertised PV item. Calculated only for PV item_2 type on advertising period level. Price reductions could be different for each store, so it is displayed as a range from the minimum to the maximum reduction, which occured in a store.'),
cheaper_weighted_avg_in_pct BIGNUMERIC(38,5)
OPTIONS(description='[Gewichteter Mittelwert Billiger] Weighted avarage price reduction in % for the advertised PV item_2, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_2 type on advertising period level. '),
cherry_picker_receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of\"cherry picker\" receipts, that contain the PV item_2 and the net turnOVER sum of all PV items on this receipt is at least 70% of the total receipt turnOVER. Only calculated for PV items. Return receipts are ignored. Not trivially aggregatable.'),
cherry_picker_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
deliv_qty BIGNUMERIC(38,5)
OPTIONS(description='Delivered Quantity (pc/kg) of the advertised NF/FA item. This is the sum of the deliveries (5 days before the period start date, up to 13 days after the period start date) and the stock on the 6th day before the period start date. Only for NF/FA items.'),
exclusive_buyer_receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of the\"exclusive buyer\" receipts, that contain only one PV item_2 (multiple pieces of this item_2 are possible), and no other items on this receipt. Only calculated for PV items.'),
exclusive_buyer_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='Exclusive Buyer Quote in %: Number of Exclusive Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
heavy_buyer_receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of\"heavy buyer\" receipts, which contain the advertised item_2 (any type PV / NF / FA) and whose net turnOVER sum of all advertised items (any type PV / NF / FA) on this receipt is at least 70% of the total receipt\'s turnOVER, and the sales_2 quantity sum of all these advertised items on this receipt is at least 70% of the total receipt\'s sales_2 quantity. Return receipts are ignored. Not trivially aggregatable.'),
heavy_buyer_receipt_cnt_pct BIGNUMERIC(38,5)
OPTIONS(description='Heavy Buyer Quote in %: Number of Heavy Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.'),
price_buy_net BIGNUMERIC(38,5)
OPTIONS(description='Net buying price of the advertised item. Calculated as average of the delivered net value sum, divided by the delivered quantity from the warehouse receivings. '),
price_retail_new_max_gross BIGNUMERIC(38,5)
OPTIONS(description='Price Retail New Max. (Gross): Maximum new gross price (sales_2 price) for the advertised item_2, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the\"new\" price, which is reduced from the old price.'),
price_retail_new_min_gross BIGNUMERIC(38,5)
OPTIONS(description='Price Retail New Min. (Gross): Minimum new gross price (sales_2 price) for the advertised PV item_2, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the\"new\" price, which is reduced from the old price.'),
price_retail_new_gross_range STRING(16777216)
OPTIONS(description='Price Retail New (Gross): Gross retail price (sales_2 price) for the advertised item. Prices could be different for each store, so it is displayed as a range from the minimum to the maximum price, which occured in a store. Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the\"new\" price, which is reduced from the old price.'),
price_retail_old_max_gross BIGNUMERIC(38,5)
OPTIONS(description='Source, logic will be decided by CO! Price Retail Old Max. (Gross): Maximum old gross price (sales_2 price) for the advertised PV item_2, which occured in a store (old prices could be different for each store). Calculated only for PV item_2 type on advertising period level.'),
price_retail_old_min_gross BIGNUMERIC(38,5)
OPTIONS(description='Source, logic will be decided by CO! Price Retail Old Min. (Gross): Minimum old gross price (sales_2 price) for the advertised PV item_2, which occured in a store (old prices could be different for each store). Calculated only for PV item_2 type on advertising period level.'),
price_retail_old_gross_range STRING(16777216)
OPTIONS(description='Price Retail Old (Gross): Old gross retail price (sales_2 price) for the advertised PV item. Calculated only for PV item_2 type on advertising period level. Old prices could be different for each store, so it is displayed as a range from the minimum to the maximum old price, which occured in a store.'),
price_retail_old_weighted_avg_gross BIGNUMERIC(38,5)
OPTIONS(description='[Gewichteter Mittelwert VK_2 (alt) (brutto)]  Weighted avarage price Retail Old (Gross): Weighted avarage old gross price (sales_2 price) for the advertised item_2, which occured in a store (prices could be different for each store).'),
price_retail_new_weighted_avg_gross BIGNUMERIC(38,5)
OPTIONS(description='[Gewichteter Mittelwert VK_2 (neu) (brutto)]  Weighted avarage price Retail New (Gross): Weighted avarage new gross price (sales_2 price) for the advertised item_2, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the\"new\" price, which is reduced from the old price.'),
pv_effic_revenue_factor BIGNUMERIC(38,5)
OPTIONS(description='Additional Revenue vs. Additional TurnOVER as a factor, caused by the advertised PV item. Indirectly uses the baseline values for revenue, turnOVER from the last 6 weeks. Only for PV.'),
pv_effic_turnover_factor BIGNUMERIC(38,5)
OPTIONS(description='(Additional TurnOVER minus Costs for the Price Reduction) vs. Costs for the Price Reduction, for the advertised PV item.'),
pv_net_val BIGNUMERIC(38,5)
OPTIONS(description='Absolute Advertising PV value in local currency. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.'),
pv_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Advertising PV as percentage of absolute advertising PV vs. total turnOVER of all items (promo, non-promo).'),
pv_lp_net_val BIGNUMERIC(38,5)
OPTIONS(description='Absolute Advertising PV value in local currency for LP action type. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.'),
pv_lp_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Advertising PV as percentage of absolute advertising PV LP vs. total turnOVER of all items (promo, non-promo).'),
pv_npps_net_val BIGNUMERIC(38,5)
OPTIONS(description='Absolute Advertising PV value in local currency for PD_2 action type. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.'),
pv_npps_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Advertising PV as percentage of absolute advertising PV PD_2 vs. total turnOVER of all items (promo, non-promo).'),
pv_wawi_net_val BIGNUMERIC(38,5)
OPTIONS(description='Absolute Advertising PV value in local currency for WAWI action type. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.'),
pv_wawi_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Advertising PV as percentage of absolute advertising PV WAWI vs. total turnOVER of all items (promo, non-promo).'),
pv_receipt_cnt_factor BIGNUMERIC(38,5)
OPTIONS(description='Factor of the Number of Receipts having this advertised PV item_2 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.'),
pv_turnover_net_val_factor BIGNUMERIC(38,5)
OPTIONS(description='Factor of the TurnOVER of this advertised PV item_2 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.'),
pv_turnover_qty_factor BIGNUMERIC(38,5)
OPTIONS(description='Factor of the Sales_2 Quantity of this advertised PV item_2 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.'),
receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of advertised items receipts for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_2 and possibly other items. The advertised item_2 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_2 was bought, independently of the sold quantity.'),
receipt_cnt_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Share of All Total Receipts in %: Share of the receipts that contain this advertised item_2, of the total number of receipts (containing promotion and / or non-promotion items), of a country_2 for the specific timeframe (advertising period / advertising week).'),
receipt_per_store_cnt BIGNUMERIC(38,5)
OPTIONS(description='Number of advertised items receipts per store for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_2 and possibly other items. The advertised item_2 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_2 was bought, independently of the sold quantity.'),
restbon_effect_pct BIGNUMERIC(38,5)
OPTIONS(description='Turnover of the rest of the receipt vs. its baseline in %, caused by the advertised PV item. Calculated by comparing the rest of the receipt during this promotion vs. the baseline value from the last 6 weeks. Only for PV. Only for these stores, which had this PV item_2 in promotion in the current advertising week.'),
restbon_np_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Rest of the receipt having a normal price: Average sum of the net turnOVER of all other non-advertised items of receipts containing the advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of all advertised items (including the specific advertised item_2) is excluded. See descriptions of the detailed formula components.'),
restbon_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Rest of the receipt: Average sum of the net turnOVER of all other items (incl. other advertised items) of receipts containing the advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of the advertised item_2 is excluded. See descriptions of the detailed formula components.'),
restbon_turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='The generated revenue (turnOVER minus buying price volume) of all items (promotion, non-promotion items) of the rest of the receipts (excluding the action item_2), which contain the advertised item. For the specific timeframe (advertising period / advertising week), in local currency.'),
store_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Number of stores that sold the action item_2 in the specific timeframe (advertising period / advertising week), in the region. For NF/FA items, additioal 5 days prior advertising period are considered.'),
total_receipt_cnt BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Total number of all receipts (containing promotion and / or non-promotion items) of a country_2 for the specific timeframe (advertising period / advertising week).'),
total_turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Total net turnOVER of all items (promotion, non-promotion items) of a country_2 for the specific timeframe (advertising period / advertising week), in local currency. Returns are ignored. Especially on advertising week level: only the 7 days of the advertising week are considered.'),
turnover_1d_pct BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only) of the first day of the advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_1d_per_store_qty BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) per store of advertised items (NF / FA / PV) of the first day of the advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_1d_qty BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) of advertised items (NF / FA / PV) of the first day of the advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_3d_pct BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_3d_per_store_qty BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) per store of advertised items (NF / FA / PV): The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_3d_qty BIGNUMERIC(38,5)
OPTIONS(description='The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_7d_pct BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_7d_per_store_qty BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) per store of advertised items (NF / FA / PV): The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_7d_qty BIGNUMERIC(38,5)
OPTIONS(description='The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_42d_pct BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 42 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_42d_per_store_qty BIGNUMERIC(38,0)
OPTIONS(description='Sold quantity (returns are considered) per store of advertised items (NF / FA / PV): The metric will use the number of sold items always for 42 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_42d_qty BIGNUMERIC(38,0)
OPTIONS(description='The metric will use the number of sold items always for 42 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.'),
turnover_margin_pct BIGNUMERIC(38,5)
OPTIONS(description='Revenue generated (turnOVER minus buying price volume) with this sold action item_2 vs. Turnover in %.'),
turnover_net_per_store_val BIGNUMERIC(38,5)
OPTIONS(description='Net turnOVER of the advertised item_2 per store, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='Net turnOVER of the advertised item_2, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.'),
turnover_net_val_share_pct BIGNUMERIC(38,5)
OPTIONS(description='Total Turnover Share in %: Turnover of this advertised item_2 vs. the total turnOVER of all items (promo, non-promo) of the country_2, for the specific timeframe (advertising period / advertising week).'),
turnover_pct BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_per_store_qty BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) per store of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_qty BIGNUMERIC(38,5)
OPTIONS(description='Sold quantity (returns are considered) of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.'),
turnover_revenue_net_val BIGNUMERIC(38,5)
OPTIONS(description='Revenue generated with this sold action item. Absolute value of turnOVER minus buying price volume.'),
turnover_revenue_net_store_val BIGNUMERIC(38,5) OPTIONS(description='Absolute revenue in local currency per store.'),
volume_buy_net_val BIGNUMERIC(38,5)
OPTIONS(description='Buying Volume based on sales_2 in local currency. Calculated as the net buying price, multiplied by the sales_2 quantity of this advertised item_2 during the period.'),
period_duration_days BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='The number of days that have been counted from the beginning of the period.'),
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
PRIMARY KEY (client_id, adv_period_id, orig_item_nr, warehouse_sid, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, a_level_id
OPTIONS(description='Aggregation Table for ADV_WEEK, ACTION_TYPE, item_2 (NAN)');