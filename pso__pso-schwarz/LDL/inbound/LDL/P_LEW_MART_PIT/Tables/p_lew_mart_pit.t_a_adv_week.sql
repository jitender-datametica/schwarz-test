/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_A_ADV_WEEK
#-------------------------------------------------------------------------------
# Description: Create DDL for Aggregation Table, contains the aggregation level REGION (warehouse), ADV_WEEK and ACTION_TYPE
# Encoding. UTF8noBom
#
# Aggregation Levels:
# ===================
# Adv.Week,COUNTRY
# Adv.Week,WH
# Adv.Week,WH,ActionType
# Adv.Week,COUNTRY,ActionType
#
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz     Initial version
#  1.1  2021-08-10 Dirk Hering      Fixes, formatting
#  1.2  2021-08-27 Mike Davis       FK support (now removed)
#  1.3  2022-01-24 Andreas Kurz     Reworked the structure after DM review
#  1.4	2022-06-26 Nikolai Toknov	Drop column PRICE_BUY_NET
#  1.5	2022-07-05 Nikolai Toknov	Adjusting columns types 
#  1.6  2022-08-03 Nikolai Toknov	Add ADV_ITEM_FA_CNT/ADV_ITEM_NF_CNT/ADV_ITEM_PV_CNT
#  2.0  2022-09-27 Nikolai Toknov	Add A_LEVEL_ID to CLUSTER
#  2.1	2022-11-21 Nikolai Toknov	Add column
#  2.2	2022-12-06 Nikolai Toknov	Drop column WAREHOUSE_NAME
#  2.2  2022-12-07 Nikolai Toknov	Change dafault values
#  3.0  2023-07-07 Nikolai Toknov	Add SUB_ITEM_GRP_SID, ITEM_GRP_INT_SID
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1  2024-11-18 Nikolai Toknov	Add PV-columns 
#  4.4  2025-02-03 Nikolai Toknov	Add column ADV_PERIOD_CNT
#-------------------------------------------------------------------------------
*/

/*
VC:
ADV_WEEK_MSTR_ID
*/
CREATE TABLE P_LEW_MART_PIT.T_A_ADV_WEEK CLUSTER BY (CLIENT_ID, A_LEVEL_ID)(
	CLIENT_ID								INTEGER		 		NOT NULL 		DEFAULT -1 					COMMENT 'Client ID e.g, AT:==1',
	COUNTRY_ISO_CD							VARCHAR(3)														COMMENT 'Country ISO Code = WAWI Country ',
	COUNTRY_DESCR							VARCHAR 														COMMENT 'Country Name',
	ADV_WEEK_ID								INTEGER		 		NOT NULL 		DEFAULT 888853				COMMENT 'Advertising Week e.g. 202137 for week 37 of 2021',
--	ADV_WEEK_MSTR_ID						INTEGER		 													COMMENT 'Advertising Week - Frontend Join. e.g. 20213701 for week 37 of 2021 for client AT (1). (( ADV_WEEK_ID * 100 ) + CLIENT_ID)',
	WAREHOUSE_SID							INTEGER		 		NOT NULL 		DEFAULT -1000 				COMMENT 'Warehouse Surrogate ID L2',
	ORIG_WH_NR								INTEGER		 													COMMENT 'Original Wahrehouse Number  / code from Wawi',
	SUB_ITEM_GRP_SID						INTEGER				NOT NULL		DEFAULT -2000 				COMMENT 'Additional Link to UWG Default values in case of missing UWGs',
	ITEM_GRP_INT_SID						INTEGER				NOT NULL		DEFAULT -2000 				COMMENT 'Additional Link to WGI Default values in case of missing WGI',
	ACTION_TYPE_ID							INTEGER		 		NOT NULL		DEFAULT -1000 				COMMENT 'Action Type 1-::NP and 2::NF | 3::FA | 1 ::PV',
	A_LEVEL_ID								INTEGER		 		NOT NULL		DEFAULT -1 					COMMENT 'Aggregation Level of the KPI',
	ADV_PERIOD_CNT							NUMBER(38,0)													COMMENT 'Number of unique store-level (start and end dates) periods.',
	ADD_RECEIPT_CNT							NUMBER(38,0) 						DEFAULT 0 					COMMENT 'Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_RECEIPT_PER_STORE_CNT				NUMBER(38,0)													COMMENT 'Additional number of receipts, caused by the advertised PV item per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_VAL					NUMBER(38,5) 													COMMENT 'Additional TurnOVER, caused by the advertised PV item. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_PER_STORE_VAL			NUMBER(38,5)													COMMENT 'Additional TurnOVER, caused by the advertised PV item, per store (where the PV item was sold). Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.',

	ADD_TURNOVER_REVENUE_NET_VAL			NUMBER(38,5) 													COMMENT 'Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_REVENUE_NET_PER_STORE_VAL	NUMBER(38,5)													COMMENT 'Additional Revenue, caused by the advertised PV item per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',

	ADV_ITEM_CNT							NUMBER(38,0)						DEFAULT 0					COMMENT 'Number of action items that have been sold in any action_type (PV / NF / FA) during an advertising period.',
	ADV_ITEM_FA_CNT							NUMBER(38,0)						DEFAULT 0 					COMMENT 'Number of FA action items that have been sold during an advertising period.',
	ADV_ITEM_NF_CNT							NUMBER(38,0)						DEFAULT 0 					COMMENT 'Number of NF action items that have been sold during an advertising period.',
	ADV_ITEM_PV_CNT							NUMBER(38,0)						DEFAULT 0 					COMMENT 'Number of PV action items that have been sold during an advertising period.',
	ADV_ITEM_PV_LP_CNT						NUMBER(38,0)						DEFAULT 0 					COMMENT 'Number of action items that have been sold as action_type LP during an advertising period, in the region of a chosen related advertising week.',
	ADV_ITEM_PV_NPPS_CNT					NUMBER(38,0)						DEFAULT 0 					COMMENT 'Number of action items that have been sold as action_type PD during an advertising period, in the region of a chosen related advertising week.',
	ADV_ITEM_PV_WAWI_CNT					NUMBER(38,0)						DEFAULT 0 					COMMENT 'Number of action items that have been sold as action_type WAWI during an advertising period, in the region of a chosen related advertising week.',

	ADV_RECEIPT_ADV_TURNOVER_NET_VAL		NUMBER(38,5) 													COMMENT 'Total action net turnOVER (only the advertised items), of receipts that contain the specific advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.',
	ADV_RECEIPT_NP_TURNOVER_NET_VAL			NUMBER(38,5) 													COMMENT 'Normal price net turnOVER of receipts: Sum of the net turnOVER of all other non-advertised items of receipts containing the advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of all advertised items (including the specific advertised item) is excluded. See descriptions of the detailed formula components.',
	ADV_RECEIPT_TOTAL_TURNOVER_NET_VAL		NUMBER(38,5) 													COMMENT 'Total net turnOVER of receipts (promotion, non-promotion items), that contain the specific advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.',
	BASE_RECEIPT_CNT						NUMBER(38,0)						DEFAULT 0 					COMMENT 'Expected/estimated number of receipts with specific item / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_NET_VAL					NUMBER(38,5) 													COMMENT 'Expected/estimated turnOVER of specific item / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_QTY						NUMBER(38,5) 													COMMENT 'Expected / estimated sold quantity of the action item within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_REVENUE_NET_VAL			NUMBER(38,5) 													COMMENT 'Expected / estimated generated revenue of the action item within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.',
	CHERRY_PICKER_RECEIPT_CNT				NUMBER(38,0) 						DEFAULT 0 					COMMENT 'Number of \"cherry picker\" receipts, that contain the PV item and the net turnOVER sum of all PV items on this receipt is at least 70% of the total receipt turnOVER. Only calculated for PV items. Return receipts are ignored. Not trivially aggregable.',
	CHERRY_PICKER_RECEIPT_CNT_PCT			NUMBER(38,5) 													COMMENT 'Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	DELIV_QTY								NUMBER(38,5) 													COMMENT 'Delivered Quantity (pc/kg) of the advertised NF/FA item. This is the sum of the deliveries (5 days before the period start date, up to 13 days after the period start date) and the stock on the 6th day before the period start date. Only for NF/FA items.',
	HEAVY_BUYER_RECEIPT_CNT					NUMBER(38,0) 						DEFAULT 0 					COMMENT 'Number of \"heavy buyer\" receipts, which contain the advertised item (any type PV / NF / FA) and whose net turnOVER sum of all advertised items (any type PV / NF / FA) on this receipt is at least 70% of the total receipt''s turnOVER, and the sales quantity sum of all these advertised items on this receipt is at least 70% of the total receipt''s sales quantity. Return receipts are ignored. Not trivially aggregable.',
	HEAVY_BUYER_RECEIPT_CNT_PCT				NUMBER(38,5) 													COMMENT 'Heavy Buyer Quote in %: Number of Heavy Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',

	PV_EFFIC_REVENUE_FACTOR					NUMBER(38,5)													COMMENT 'Additional Revenue vs. Additional TurnOVER as a factor, caused by the advertised PV item. Indirectly uses the baseline values for revenue, turnOVER from the last 6 weeks. Only for PV.',
	PV_EFFIC_TURNOVER_FACTOR				NUMBER(38,5)													COMMENT '(Additional TurnOVER minus Costs for the Price Reduction) vs. Costs for the Price Reduction, for the advertised PV item.',
	PV_NET_VAL								NUMBER(38,5)													COMMENT 'Absolute Advertising PV value in local currency. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.',
	PV_NET_VAL_SHARE_PCT					NUMBER(38,5)													COMMENT 'Advertising PV as percentage of absolute advertising PV vs. total turnOVER of all items (promo, non-promo).',
	PV_LP_NET_VAL							NUMBER(38,5)													COMMENT 'Absolute Advertising PV value in local currency for LP action type. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.',
	PV_LP_NET_VAL_SHARE_PCT					NUMBER(38,5)													COMMENT 'Advertising PV as percentage of absolute advertising PV LP vs. total turnOVER of all items (promo, non-promo).',
	PV_NPPS_NET_VAL							NUMBER(38,5)													COMMENT 'Absolute Advertising PV value in local currency for PD action type. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.',
	PV_NPPS_NET_VAL_SHARE_PCT				NUMBER(38,5)													COMMENT 'Advertising PV as percentage of absolute advertising PV PD vs. total turnOVER of all items (promo, non-promo).',
	PV_WAWI_NET_VAL							NUMBER(38,5)													COMMENT 'Absolute Advertising PV value in local currency for WAWI action type. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.',
	PV_WAWI_NET_VAL_SHARE_PCT				NUMBER(38,5)													COMMENT 'Advertising PV as percentage of absolute advertising PV WAWI vs. total turnOVER of all items (promo, non-promo).',


	RECEIPT_CNT								NUMBER(38,0)						DEFAULT 0 					COMMENT 'Number of advertised items receipts for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item and possibly other items. The advertised item can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item was bought, independently of the sold quantity.',
	RECEIPT_CNT_SHARE_PCT					NUMBER(38,5) 													COMMENT 'Share of All Total Receipts in %: Share of the receipts that contain this advertised item, of the total number of receipts (containing promotion and / or non-promotion items), of a country for the specific timeframe (advertising period / advertising week).',
	RECEIPT_PER_STORE_CNT					NUMBER(38,0)						DEFAULT 0					COMMENT 'Number of advertised items receipts per store for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item and possibly other items. The advertised item can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item was bought, independently of the sold quantity.',
	RESTBON_NP_TURNOVER_NET_VAL				NUMBER(38,5) 													COMMENT 'Rest of the receipt having a normal price: Average sum of the net turnOVER of all other non-advertised items of receipts containing the advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of all advertised items (including the specific advertised item) is excluded. See descriptions of the detailed formula components.',
	RESTBON_TURNOVER_NET_VAL				NUMBER(38,5) 													COMMENT 'Rest of the receipt: Average sum of the net turnOVER of all other items (incl. other advertised items) of receipts containing the advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of the advertised item is excluded. See descriptions of the detailed formula components.',
	RESTBON_TURNOVER_REVENUE_NET_VAL		NUMBER(38,5) 													COMMENT 'The generated revenue (turnOVER minus buying price volume) of all items (promotion, non-promotion items) of the rest of the receipts (excluding the action item), which contain the advertised item. For the specific timeframe (advertising period / advertising week), in local currency.',

	STORE_CNT								NUMBER(38,0)						DEFAULT 0 					COMMENT 'Number of stores that sold the action item in the specific timeframe (advertising period / advertising week), in the region.For NF/FA items, additional 5 days prior advertising period are considered. No trivial aggregation, because each store might have multiple different items advertised.',
	TOTAL_RECEIPT_CNT						NUMBER(38,0)						DEFAULT 0 					COMMENT 'Total number of all receipts (containing promotion and / or non-promotion items) of a country for the specific timeframe (advertising period / advertising week).',
	TOTAL_RECEIPT_PER_STORE_CNT				NUMBER(38,5) 													COMMENT 'Total number of all receipts (containing promotion and / or non-promotion items) per store of a country for the specific timeframe (advertising period / advertising week).',
	TOTAL_TURNOVER_NET_VAL					NUMBER(38,5) 													COMMENT 'Total net turnOVER of all items (promotion, non-promotion items) of a country for the specific timeframe (advertising period / advertising week), in local currency. Returns are ignored. Especially on advertising week level: only the 7 days of the advertising week are considered.',
	TURNOVER_1D_PCT							NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only) of the first day of the advertising period.For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_1D_QTY							NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) of advertised items (NF / FA / PV) of the first day of the advertising period.For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_3D_PCT							NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_3D_QTY							NUMBER(38,5) 													COMMENT 'The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_7D_PCT							NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_7D_QTY							NUMBER(38,5) 													COMMENT 'The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_MARGIN_PCT						NUMBER(38,5) 													COMMENT 'Revenue generated (turnOVER minus buying price volume) with this sold action item vs. TurnOVER in %.',
	TURNOVER_NET_PER_STORE_VAL				NUMBER(38,5) 													COMMENT 'Net turnOVER of the advertised item per store, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_VAL						NUMBER(38,5) 													COMMENT 'Net turnOVER of the advertised item, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_VAL_SHARE_PCT				NUMBER(38,5) 													COMMENT 'Total TurnOVER Share in %: TurnOVER of this advertised item vs. the total turnOVER of all items (promo, non-promo) of the country, for the specific timeframe (advertising period / advertising week).',
	TURNOVER_QTY							NUMBER(38,5) 													COMMENT 'Sold quantity (returns are considered) of advertised items (NF / FA / PV) during their advertising period.For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_REVENUE_NET_VAL				NUMBER(38,5) 													COMMENT 'Revenue generated with this sold action item. Absolute value of turnOVER minus buying price volume.',
	TURNOVER_REVENUE_NET_STORE_VAL			NUMBER(38,5)													COMMENT 'Absolute revenue in local currency per store.',
	VOLUME_BUY_NET_VAL						NUMBER(38,5) 													COMMENT 'Buying Volume based on sales in local currency. Calculated as the net buying price, multiplied by the sales quantity of this advertised item during the period.',
	TOTAL_STORE_CNT							INTEGER		 						DEFAULT 0 					COMMENT 'Number of stores that sold the any items in the specific timeframe (advertising period / advertising week), in the region.',
	
	REJECT_FG								SMALLINT	 		NOT NULL 		DEFAULT 0 					COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID						INTEGER		 		NOT NULL 		DEFAULT -1 					COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID						INTEGER		 		NOT NULL 		DEFAULT 0 					COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG								SMALLINT	 		NOT NULL 		DEFAULT 0 					COMMENT 'Logical Deleted Flag indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP		 	NOT NULL 		DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP		 												COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID									INTEGER				NOT NULL 		DEFAULT 0 					COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, ADV_WEEK_ID, WAREHOUSE_SID, ACTION_TYPE_ID, DELETED_FG)
)	COMMENT='Aggregation Table contains the aggregation level REGION (warehouse), ADV_WEEK and ACTION_TYPE'
;