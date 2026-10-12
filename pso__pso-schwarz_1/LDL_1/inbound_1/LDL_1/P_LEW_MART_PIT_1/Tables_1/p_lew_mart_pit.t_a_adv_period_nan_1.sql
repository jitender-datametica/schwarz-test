/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_A_ADV_PERIOD_NAN_1
#-------------------------------------------------------------------------------
# Description: Create DDL for Aggregation Table for ADV_WEEK, ACTION_TYPE, item_1 (NAN)
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
#  2.3	2023-03-16 Nikolai Toknov	INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#  2.4  2023-07-19 Nikolai Toknov   Add MEDIUM_AGG_LIST_DESCR. AP0079142_BS0011293_PIT_REPORTING_ITEM_NEW_COLUMNS
#  2.5  2023-09-06 Andreas Kurz 	Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
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

ALTER table P_LEW_MART_PIT.T_A_ADV_PERIOD_NAN_1 ADD
	COUPON_AGG_LIST_DESCR							VARCHAR																		COMMENT 'LP Coupons Description';


*/
CREATE TABLE P_LEW_MART_PIT.T_A_ADV_PERIOD_NAN_1 CLUSTER BY (CLIENT_ID, A_LEVEL_ID)(
	CLIENT_ID								INTEGER				NOT NULL	DEFAULT -1 						COMMENT 'Client ID e.g, AT:==1',
	COUNTRY_ISO_CD							VARCHAR(3) 														COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR							VARCHAR 														COMMENT 'Country_1 Name',
	ADV_WEEK_ID								INTEGER				NOT NULL	DEFAULT 888853 					COMMENT 'Advertising Week',
--	ADV_WEEK_MSTR_ID						INTEGER															COMMENT 'Advertising Week - Frontend Join',
	ADV_PERIOD_ID							INTEGER				NOT NULL	DEFAULT 88885399 				COMMENT 'Advertising Period',
--	ADV_PERIOD_MSTR_ID						INTEGER															COMMENT 'Advertising Period - Frontend Join',

	PV_TYPE_ID								NUMBER(38,0)													COMMENT 'Type of PV (List of PV Types: Wawi PV ::= 1 | LP ::= 2 | PD_1 ::= 3 | -1 ::= N/A | -2 ::= Total PV)',													

	MEDIUM_SID								INTEGER				NOT NULL	DEFAULT -2000 					COMMENT 'Advertising Media, ',
--	MEDIUM_MSTR_SID							INTEGER															COMMENT 'Advertising Media - Frontend Join',
	MEDIUM_GRP_SID							INTEGER				NOT NULL	DEFAULT -2000 					COMMENT 'Advertising Media, ',
--	MEDIUM_GRP_MSTR_SID						INTEGER															COMMENT 'Advertising Media - Frontend Join',
	
	THEME_GRP_NAT_SID						INTEGER				NOT NULL	DEFAULT -1000 					COMMENT 'FK to Theme Group ',
--	THEME_GRP_NAT_MSTR_SID					INTEGER															COMMENT '[VC] MSTR surrogate Key : Theme Group NAT',
										
	THEME_GRP_INT_SID						INTEGER				NOT NULL	DEFAULT -1000 					COMMENT 'FK to Theme Group ',
--	THEME_GRP_INT_MSTR_SID					INTEGER															COMMENT '[VC] MSTR surrogate Key : Theme Group INT',

	THEME_GRP_NAT_CAT_SID					INTEGER		 		NOT NULL	DEFAULT -1000					COMMENT ' Unique system ID, sid, for the theme nat group category.',
--	THEME_GRP_NAT_CAT_MSTR_SID				INTEGER															COMMENT ' Unique system ID, sid, for the theme nat group category + Client_ID, as MSTR Key',

	MEDIUM_SID_LST							VARCHAR 														COMMENT 'Comma-separated list of all media_sid in [], in which this item_1 has been advertised during this period.',
	MEDIUM_GRP_SID_LST						VARCHAR 														COMMENT 'Comma-separated list of all grp.media_sid in [], in which this item_1 has been advertised during this period.',


	MEDIUM_AGG_LIST_DESCR					VARCHAR 														COMMENT 'Comma-separated list of all advertising media (of all media groups), in which this item_1 has been advertised during this period.',
	MEDIUM_GRP_AGG_LIST_DESCR				VARCHAR 														COMMENT 'Comma-separated list of all advertising grp.media (of all media groups), in which this item_1 has been advertised during this period.',

	COUPON_AGG_LIST_DESCR					VARCHAR															COMMENT 'LP Coupons Description',		

	WAREHOUSE_SID							INTEGER				NOT NULL	DEFAULT -2000 					COMMENT 'Warehouse Surrogate ID L2',
	ORIG_WH_NR								INTEGER															COMMENT 'Original Wahrehouse Number  / code from Wawi',
	ORIG_ITEM_NR							INTEGER				NOT NULL 									COMMENT 'Item_1 NaN (National Artikel_1 Nummer) Link to Item_1 History',
--	ORIG_ITEM_MSTR_NR						INTEGER															COMMENT 'Item_1 NaN (National Artikel_1 Nummer) Link - Frontend Join',
	SUB_ITEM_GRP_SID						INTEGER				NOT NULL	DEFAULT -2000 					COMMENT 'Additional Link to UWG Default values in case of missing UWGs',
	ITEM_GRP_INT_SID						INTEGER				NOT NULL	DEFAULT -2000 					COMMENT 'Additional Link to WGI Default values in case of missing WGI',
	ACTION_TYPE_ID							INTEGER				NOT NULL	DEFAULT -2000 					COMMENT 'Action Type 1-::NP and 2::NF | 3::FA | 1 ::PV',
	PV_ON_PV_DESCR							VARCHAR															COMMENT 'Ursprungs-Werbe-PV: Shows if item_1 has already a Werbe-PV applied f.e. when LP-Werbe-PV on WaWi-Werbe-PV we display WaWi-Werbe-PV',
	A_LEVEL_ID								INTEGER				NOT NULL	DEFAULT -1 						COMMENT 'Aggregation Level of the KPI',
	ADV_PERIOD_CNT							NUMBER(38,0)													COMMENT 'Number of unique store-level (start and end dates) periods.',
	ADD_RECEIPT_CNT							NUMBER(38,0)					DEFAULT 0 						COMMENT 'Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_RECEIPT_PER_STORE_CNT				NUMBER(38,0)													COMMENT 'Additional number of receipts, caused by the advertised PV item_1 per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_REVENUE_NET_VAL			NUMBER(38,5) 													COMMENT 'Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_PER_STORE_VAL			NUMBER(38,5) 													COMMENT 'Additional Turnover, caused by the advertised PV item_1, per store. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_VAL					NUMBER(38,5) 													COMMENT 'Additional Turnover, caused by the advertised PV item. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_QTY						NUMBER(38,0)													COMMENT 'Additional turnover qantity, caused by the advertised PV item. Calculated by number of soled item_1 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_PER_STORE_QTY				NUMBER(38,0)													COMMENT 'Additional turnover qantity, caused by the advertised PV item_1 per store. Calculated by number of soled item_1 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADV_ITEM_PER_RECEIPT_CNT				NUMBER(38,5) 													COMMENT 'Average number (pieces) of the advertised item_1 per receipt, which contains this item_1, during the advertising period.',
	ADD_TURNOVER_REVENUE_NET_PER_STORE_VAL	NUMBER(38,5)													COMMENT 'Additional Revenue, caused by the advertised PV item_1 per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADV_RECEIPT_ADV_TURNOVER_NET_VAL		NUMBER(38,5) 													COMMENT 'Total action net turnOVER (only the advertised items), of receipts that contain the specific advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.',
	ADV_RECEIPT_NP_TURNOVER_NET_VAL			NUMBER(38,5) 													COMMENT 'Normal price net turnOVER of receipts: Sum of the net turnOVER of all other non-advertised items of receipts containing the advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of all advertised items (including the specific advertised item_1) is excluded. See descriptions of the detailed formula components.',
	ADV_RECEIPT_TOTAL_TURNOVER_NET_VAL		NUMBER(38,5) 													COMMENT 'Total net turnOVER of receipts (promotion, non-promotion items), that contain the specific advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.',
	BASE_RECEIPT_CNT						NUMBER(38,0)					DEFAULT 0 						COMMENT 'Expected/estimated number of receipts with specific item_1 / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	BASE_RESTBON_TURNOVER_NET_VAL			NUMBER(38,5) 													COMMENT 'Expected baseline value for Turnover of Receipt Rest (Avg.) from the last 6 advertising weeks (median OVER the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_NET_VAL					NUMBER(38,5) 													COMMENT 'Expected/estimated turnOVER of specific item_1 / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_QTY						NUMBER(38,5) 													COMMENT 'Expected / estimated sold quantity of the action item_1 within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_REVENUE_NET_VAL			NUMBER(38,5) 													COMMENT 'Expected / estimated generated revenue of the action item_1 within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	CHEAPER_MAX_PCT							NUMBER(38,5) 													COMMENT 'Maximum price reduction in % for the advertised PV item_1, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_1 type on advertising period level. ',
	CHEAPER_MIN_PCT							NUMBER(38,5) 													COMMENT 'Minimum price reduction in % for the advertised PV item_1, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_1 type on advertising period level. ',
	CHEAPER_RANGE							VARCHAR 														COMMENT 'Price reduction in % for the advertised PV item. Calculated only for PV item_1 type on advertising period level. Price reductions could be different for each store, so it is displayed as a range from the minimum to the maximum reduction, which occured in a store.',
	CHEAPER_WEIGHTED_AVG_IN_PCT				NUMBER(38,5) 													COMMENT '[Gewichteter Mittelwert Billiger] Weighted avarage price reduction in % for the advertised PV item_1, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_1 type on advertising period level. ',
	CHERRY_PICKER_RECEIPT_CNT				NUMBER(38,0)					DEFAULT 0 						COMMENT 'Number of \"cherry picker\" receipts, that contain the PV item_1 and the net turnOVER sum of all PV items on this receipt is at least 70% of the total receipt turnOVER. Only calculated for PV items. Return receipts are ignored. Not trivially aggregatable.',
	CHERRY_PICKER_RECEIPT_CNT_PCT			NUMBER(38,5) 													COMMENT 'Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	DELIV_QTY								NUMBER(38,5) 													COMMENT 'Delivered Quantity (pc/kg) of the advertised NF/FA item. This is the sum of the deliveries (5 days before the period start date, up to 13 days after the period start date) and the stock on the 6th day before the period start date. Only for NF/FA items.',
	EXCLUSIVE_BUYER_RECEIPT_CNT				NUMBER(38,0)					DEFAULT 0 						COMMENT 'Number of the \"exclusive buyer\" receipts, that contain only one PV item_1 (multiple pieces of this item_1 are possible), and no other items on this receipt. Only calculated for PV items.',
	EXCLUSIVE_BUYER_RECEIPT_CNT_PCT			NUMBER(38,5) 													COMMENT 'Exclusive Buyer Quote in %: Number of Exclusive Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	HEAVY_BUYER_RECEIPT_CNT					NUMBER(38,0)					DEFAULT 0 						COMMENT 'Number of \"heavy buyer\" receipts, which contain the advertised item_1 (any type PV / NF / FA) and whose net turnOVER sum of all advertised items (any type PV / NF / FA) on this receipt is at least 70% of the total receipt''s turnOVER, and the sales_1 quantity sum of all these advertised items on this receipt is at least 70% of the total receipt''s sales_1 quantity. Return receipts are ignored. Not trivially aggregatable.',
	HEAVY_BUYER_RECEIPT_CNT_PCT				NUMBER(38,5) 													COMMENT 'Heavy Buyer Quote in %: Number of Heavy Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	PRICE_BUY_NET							NUMBER(38,5) 													COMMENT 'Net buying price of the advertised item. Calculated as average of the delivered net value sum, divided by the delivered quantity from the warehouse receivings. ',
	PRICE_RETAIL_NEW_MAX_GROSS				NUMBER(38,5) 													COMMENT 'Price Retail New Max. (Gross): Maximum new gross price (sales_1 price) for the advertised item_1, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the \"new\" price, which is reduced from the old price.',
	PRICE_RETAIL_NEW_MIN_GROSS				NUMBER(38,5) 													COMMENT 'Price Retail New Min. (Gross): Minimum new gross price (sales_1 price) for the advertised PV item_1, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the \"new\" price, which is reduced from the old price.',
	PRICE_RETAIL_NEW_GROSS_RANGE			VARCHAR 														COMMENT 'Price Retail New (Gross): Gross retail price (sales_1 price) for the advertised item. Prices could be different for each store, so it is displayed as a range from the minimum to the maximum price, which occured in a store. Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the \"new\" price, which is reduced from the old price.',
	PRICE_RETAIL_OLD_MAX_GROSS				NUMBER(38,5) 													COMMENT 'Source, logic will be decided by CO! Price Retail Old Max. (Gross): Maximum old gross price (sales_1 price) for the advertised PV item_1, which occured in a store (old prices could be different for each store). Calculated only for PV item_1 type on advertising period level.',
	PRICE_RETAIL_OLD_MIN_GROSS				NUMBER(38,5) 													COMMENT 'Source, logic will be decided by CO! Price Retail Old Min. (Gross): Minimum old gross price (sales_1 price) for the advertised PV item_1, which occured in a store (old prices could be different for each store). Calculated only for PV item_1 type on advertising period level.',
	PRICE_RETAIL_OLD_GROSS_RANGE			VARCHAR 														COMMENT 'Price Retail Old (Gross): Old gross retail price (sales_1 price) for the advertised PV item. Calculated only for PV item_1 type on advertising period level. Old prices could be different for each store, so it is displayed as a range from the minimum to the maximum old price, which occured in a store.',
	PRICE_RETAIL_OLD_WEIGHTED_AVG_GROSS		NUMBER(38,5) 													COMMENT '[Gewichteter Mittelwert VK_1 (alt) (brutto)]  Weighted avarage price Retail Old (Gross): Weighted avarage old gross price (sales_1 price) for the advertised item_1, which occured in a store (prices could be different for each store).',
	PRICE_RETAIL_NEW_WEIGHTED_AVG_GROSS		NUMBER(38,5) 													COMMENT '[Gewichteter Mittelwert VK_1 (neu) (brutto)]  Weighted avarage price Retail New (Gross): Weighted avarage new gross price (sales_1 price) for the advertised item_1, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the \"new\" price, which is reduced from the old price.',
	PV_EFFIC_REVENUE_FACTOR					NUMBER(38,5) 													COMMENT 'Additional Revenue vs. Additional TurnOVER as a factor, caused by the advertised PV item. Indirectly uses the baseline values for revenue, turnOVER from the last 6 weeks. Only for PV.',
	PV_EFFIC_TURNOVER_FACTOR				NUMBER(38,5) 													COMMENT '(Additional TurnOVER minus Costs for the Price Reduction) vs. Costs for the Price Reduction, for the advertised PV item.',
	PV_NET_VAL								NUMBER(38,5) 													COMMENT 'Absolute Advertising PV value in local currency. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.',
	PV_NET_VAL_SHARE_PCT					NUMBER(38,5) 													COMMENT 'Advertising PV as percentage of absolute advertising PV vs. total turnOVER of all items (promo, non-promo).',
	PV_LP_NET_VAL							NUMBER(38,5)													COMMENT 'Absolute Advertising PV value in local currency for LP action type. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.',
	PV_LP_NET_VAL_SHARE_PCT					NUMBER(38,5)													COMMENT 'Advertising PV as percentage of absolute advertising PV LP vs. total turnOVER of all items (promo, non-promo).',
	PV_NPPS_NET_VAL							NUMBER(38,5)													COMMENT 'Absolute Advertising PV value in local currency for PD_1 action type. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.',
	PV_NPPS_NET_VAL_SHARE_PCT				NUMBER(38,5)													COMMENT 'Advertising PV as percentage of absolute advertising PV PD_1 vs. total turnOVER of all items (promo, non-promo).',
	PV_WAWI_NET_VAL							NUMBER(38,5)													COMMENT 'Absolute Advertising PV value in local currency for WAWI action type. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.',
	PV_WAWI_NET_VAL_SHARE_PCT				NUMBER(38,5)													COMMENT 'Advertising PV as percentage of absolute advertising PV WAWI vs. total turnOVER of all items (promo, non-promo).',	
	PV_RECEIPT_CNT_FACTOR					NUMBER(38,5) 													COMMENT 'Factor of the Number of Receipts having this advertised PV item_1 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.',
	PV_TURNOVER_NET_VAL_FACTOR				NUMBER(38,5) 													COMMENT 'Factor of the TurnOVER of this advertised PV item_1 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.',
	PV_TURNOVER_QTY_FACTOR					NUMBER(38,5) 													COMMENT 'Factor of the Sales_1 Quantity of this advertised PV item_1 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.',
	RECEIPT_CNT								NUMBER(38,0) 					DEFAULT 0 						COMMENT 'Number of advertised items receipts for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_1 and possibly other items. The advertised item_1 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_1 was bought, independently of the sold quantity.',
	RECEIPT_CNT_SHARE_PCT					NUMBER(38,5) 													COMMENT 'Share of All Total Receipts in %: Share of the receipts that contain this advertised item_1, of the total number of receipts (containing promotion and / or non-promotion items), of a country_1 for the specific timeframe (advertising period / advertising week).',
	RECEIPT_PER_STORE_CNT					NUMBER(38,5) 													COMMENT 'Number of advertised items receipts per store for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_1 and possibly other items. The advertised item_1 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_1 was bought, independently of the sold quantity.',
	RESTBON_EFFECT_PCT						NUMBER(38,5) 													COMMENT 'Turnover of the rest of the receipt vs. its baseline in %, caused by the advertised PV item. Calculated by comparing the rest of the receipt during this promotion vs. the baseline value from the last 6 weeks. Only for PV. Only for these stores, which had this PV item_1 in promotion in the current advertising week.',
	RESTBON_NP_TURNOVER_NET_VAL				NUMBER(38,5) 													COMMENT 'Rest of the receipt having a normal price: Average sum of the net turnOVER of all other non-advertised items of receipts containing the advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of all advertised items (including the specific advertised item_1) is excluded. See descriptions of the detailed formula components.',
	RESTBON_TURNOVER_NET_VAL				NUMBER(38,5) 													COMMENT 'Rest of the receipt: Average sum of the net turnOVER of all other items (incl. other advertised items) of receipts containing the advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of the advertised item_1 is excluded. See descriptions of the detailed formula components.',
	RESTBON_TURNOVER_REVENUE_NET_VAL		NUMBER(38,5) 													COMMENT 'The generated revenue (turnOVER minus buying price volume) of all items (promotion, non-promotion items) of the rest of the receipts (excluding the action item_1), which contain the advertised item. For the specific timeframe (advertising period / advertising week), in local currency.',
	STORE_CNT								NUMBER(38,0)					DEFAULT 0 						COMMENT 'Number of stores that sold the action item_1 in the specific timeframe (advertising period / advertising week), in the region. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TOTAL_RECEIPT_CNT						NUMBER(38,0)					DEFAULT 0 						COMMENT 'Total number of all receipts (containing promotion and / or non-promotion items) of a country_1 for the specific timeframe (advertising period / advertising week).',
	TOTAL_TURNOVER_NET_VAL					NUMBER(38,5) 													COMMENT 'Total net turnOVER of all items (promotion, non-promotion items) of a country_1 for the specific timeframe (advertising period / advertising week), in local currency. Returns are ignored. Especially on advertising week level: only the 7 days of the advertising week are considered.',
	TURNOVER_1D_PCT							NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only) of the first day of the advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_1D_PER_STORE_QTY				NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) per store of advertised items (NF / FA / PV) of the first day of the advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_1D_QTY							NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) of advertised items (NF / FA / PV) of the first day of the advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_3D_PCT							NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_3D_PER_STORE_QTY				NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) per store of advertised items (NF / FA / PV): The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_3D_QTY							NUMBER(38,5) 													COMMENT 'The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_7D_PCT							NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_7D_PER_STORE_QTY				NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) per store of advertised items (NF / FA / PV): The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_7D_QTY							NUMBER(38,5) 													COMMENT 'The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_42D_PCT						NUMBER(38,5)													COMMENT 'Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 42 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_42D_PER_STORE_QTY				NUMBER(38,0)													COMMENT 'Sold quantity (returns are considered) per store of advertised items (NF / FA / PV): The metric will use the number of sold items always for 42 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_42D_QTY						NUMBER(38,0)													COMMENT 'The metric will use the number of sold items always for 42 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_MARGIN_PCT						NUMBER(38,5) 													COMMENT 'Revenue generated (turnOVER minus buying price volume) with this sold action item_1 vs. Turnover in %.',
	TURNOVER_NET_PER_STORE_VAL				NUMBER(38,5) 													COMMENT 'Net turnOVER of the advertised item_1 per store, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_VAL						NUMBER(38,5) 													COMMENT 'Net turnOVER of the advertised item_1, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_VAL_SHARE_PCT				NUMBER(38,5) 													COMMENT 'Total Turnover Share in %: Turnover of this advertised item_1 vs. the total turnOVER of all items (promo, non-promo) of the country_1, for the specific timeframe (advertising period / advertising week).',
	TURNOVER_PCT							NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_PER_STORE_QTY					NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) per store of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_QTY							NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_REVENUE_NET_VAL				NUMBER(38,5) 													COMMENT 'Revenue generated with this sold action item. Absolute value of turnOVER minus buying price volume.',
	TURNOVER_REVENUE_NET_STORE_VAL			NUMBER(38,5)													COMMENT 'Absolute revenue in local currency per store.',
	VOLUME_BUY_NET_VAL						NUMBER(38,5) 													COMMENT 'Buying Volume based on sales_1 in local currency. Calculated as the net buying price, multiplied by the sales_1 quantity of this advertised item_1 during the period.',
    -- debugging purposes
	PERIOD_DURATION_DAYS					NUMBER(38,0)					DEFAULT 0 						COMMENT 'The number of days that have been counted from the beginning of the period.',

	REJECT_FG								SMALLINT			NOT NULL 	DEFAULT 0 						COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID						INTEGER				NOT NULL 	DEFAULT -1 						COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID						INTEGER				NOT NULL 	DEFAULT 0 						COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG								SMALLINT			NOT NULL 	DEFAULT 0 						COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP			NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP			 											COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID									INTEGER		 		NOT NULL 	DEFAULT 0 						COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, ADV_PERIOD_ID, ORIG_ITEM_NR, WAREHOUSE_SID, DELETED_FG)
)	COMMENT='Aggregation Table for ADV_WEEK, ACTION_TYPE, item_1 (NAN)'
;
