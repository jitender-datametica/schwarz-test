/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for AGG_REGION_ADV_WEEK_NAN
#-------------------------------------------------------------------------------
# Description: DDL for frontend MSTR Aggregate Table at the NAN (orig_item_nr) level
#              aggregated on Country_1 / Region_1 (WH), AdvWeek, ActionType. Information included for UWG, WGI.
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-09   Mike Davis     Initial version
#                                   Keeps defaults, virtuals and nullability (for reference).
#  1.1  2021-08-13   Mike Davis     Checks, AKU-Formatting
#                                   Defaults, virtuals and nullability removed where
#                                   this is specified at a lower (previous) level.
#                                   Nullability kept for PRIMARY KEY.
#  1.2  2021-09-13 Massimo Morelli  Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz     Reworked the structure after DM review
#  1.4  2022-06-02 Prasanna Ranjan	Replaced CURRENT_ADV_WEEK_FG
#  2.0	2022-07-12 Nikolai Toknov  Changing the script for DevOps
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was Join
#  3.1  2023-06-28 Nikolai Toknov	Fix issue with DAT_VALID_FROM from the main branch
#  3.2  2023-07-26 Nikolai Toknov	Remove NOT NULL for an improvement in the definition of REJECT_FG
#  4.0  2024-02-13 Prasanna Ranjan	Added new columns for PIT Increment 2 (PV)
#  4.1  2024-03-25 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.2  2024-03-25 Nikolai Toknov   add PV_LP_NET_VAL, PV_LP_NET_VAL_SHARE_PCT, PV_PD_NET_VAL, PV_PD_NET_VAL_SHARE_PCT, PV_WAWI_NET_VAL, PV_WAWI_NET_VAL_SHARE_PCT
#  4.3  2024-09-24 Prasanna Ranjan	Adjustment Increment 2.1 (PV)
#  4.4 	2025-02-12 Andreas Kurz		Removing PV_TYPE_ID Column
#  4.5  2025-06-26 Andreas Kurz		Added 3 columns for weighted Avg VK_1 Alt / Neu und Billiger in PCT
#-------------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_FE_MSTR_PIT.T_AGG_REGION_ADV_WEEK_NAN_1 CLUSTER BY (CLIENT_ID, ADV_WEEK_ID) (

	CLIENT_ID								INTEGER			NOT NULL 															COMMENT 'Client id',
	COUNTRY_ISO_CD							VARCHAR(3) 																			COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR							VARCHAR 																			COMMENT 'Country_1 Name',

	WAREHOUSE_SID							INTEGER			NOT NULL 															COMMENT 'Warehouse Surrogate ID',
	WAREHOUSE_MSTR_SID						INTEGER		 																		COMMENT 'Warehouse Surrogate ID',
	-- GID
	WAREHOUSE_GID							INTEGER		 				DEFAULT -1000											COMMENT 'Warehouse Surrogate GID - As-Was Join key for Frontend',
	WAREHOUSE_MSTR_GID 						INTEGER 																			COMMENT 'Technical Field: MSTR GID',

	WAREHOUSE_NAME							VARCHAR 																			COMMENT 'Warehouse Name',
	ORIG_WH_NR								INTEGER		 																		COMMENT 'Original Warehouse Number  / code from Wawi',

	ADV_WEEK_ID								INTEGER			NOT NULL 															COMMENT 'Advertising week BK',
	ADV_WEEK_MSTR_ID						INTEGER		 																		COMMENT 'Advertising week MSTR Key (AdvWeek No. concatenated with 2-digit client ID)',

	ADV_WEEK_START_DT						DATE 																				COMMENT 'Start Date of Adv-Week',
	ADV_WEEK_END_DT							DATE 																				COMMENT 'End Date of Adv.-Week',
	ADV_WEEK_START_DT_DESCR					VARCHAR 																			COMMENT 'Start Date of the Adv. Week in German format for the frontend',
	ADV_WEEK_END_DT_DESCR					VARCHAR 																			COMMENT 'End Date of the Adv. Week in German format for the frontend',

	ADV_WEEK_START_DAY_SDESCR				VARCHAR 																			COMMENT 'German short description of the week day, when this adv week starts',
	ADV_WEEK_END_DAY_SDESCR					VARCHAR 																			COMMENT 'German short description of the week day, when this adv week ends',

	ADV_WEEK_START_DAY_DESCR				VARCHAR 																			COMMENT 'German description of the week day, when this adv week starts',
	ADV_WEEK_END_DAY_DESCR					VARCHAR 																			COMMENT 'German description of the week day, when this adv week ends',

	LENGTH_OF_ADV_WEEK						SMALLINT	 																		COMMENT '[Optional]: Number of Days in Adv. Week',
	ADV_WEEK_YEAR_ID						INTEGER		 																		COMMENT 'Year ID of the Adv.-Week. 202137 -> 2021. Needed for Reporting',
	ADV_WEEK_WEEK_NR						INTEGER		 																		COMMENT 'Adv.Week Week Nbr. E.g. 202137 -> 37. Needed for Reporting',
	ADV_WEEK_SDESCR							VARCHAR 																			COMMENT 'Adv. Week Short Description',
	ADV_WEEK_DESCR							VARCHAR 																			COMMENT 'Adv.Week Description',
	ADV_WEEK_LDESCR							VARCHAR 																			COMMENT 'Adv. Week Long Description incl. dates',
	ADV_WEEK_OVERLAP_LDESCR					VARCHAR 																			COMMENT 'Adv.Week Long Description incl. dates and the maximum date of the OVERlapping range into the next adv week',
	PREV_1_ADV_WEEK_ID						INTEGER		 																		COMMENT 'Previous 1 Adv.Week ID e.g. 202124 -> 202123',
	NEXT_1_ADV_WEEK_ID						INTEGER		 																		COMMENT 'Next 1 Adv.Week ID e.g. 202124 -> 202125',
	PREV_1_YEAR_ADV_WEEK_ID					INTEGER		 																		COMMENT 'Previous 1 Year Adv.Week ID e.g. 202124 -> 202024',
	LAST_ADV_WEEK_FG						SMALLINT					DEFAULT 0 												COMMENT '[View] Flag / indicator last Adv.Week = 1',
	LAST_CLOSED_ADV_WEEK_FG					SMALLINT					DEFAULT 0 												COMMENT '[View] Flag / indicator last closed Adv.Week = 1',
	MOV_ADV_WEEK_START_FROM_CURRENT			INTEGER		 																		COMMENT '[View]: Current Adv.-Week is ::0 , pervious Adv.-Week is -1 Next Adv. Week is +1',
	MAX_ADV_PERIOD_END_DT					DATE 																				COMMENT '[View] maximum assigned Adv. Period End Date, in case of OVERlapping period. Needed for Reporting Information Window.',
	REPORTING_LINE_SID						INTEGER			NOT NULL 															COMMENT 'Hierarchy_1 level number to identify the individual reporting line (row) of e.g. a precalculated summary line.',
	REPORTING_LINE_DESCR					VARCHAR 																			COMMENT 'Description of the Reporting Line',

	-- GID
	ORIG_ITEM_GID							INTEGER						DEFAULT -1000											COMMENT 'NAN orig Item_1 number Surrogate GID - As-Was Join key for Frontend',
	ORIG_ITEM_MSTR_GID 						INTEGER 																			COMMENT 'Technical Field: MSTR GID',								

	ORIG_ITEM_NR							INTEGER		 																		COMMENT 'Item_1 business identifier. NaN := National Article Number',
	ORIG_ITEM_MSTR_NR						INTEGER					 															COMMENT 'Item_1 business identifier. (NaN := National Article Number) MSTR Key: Special MSTR Join criteria to have surrogate ORIG_ITEM_NR + CLIENT_ID',
	DAT_VALID_FROM							DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD')
																																COMMENT 'Original Item_1 Source DATE from.',
	ITEM_NAME								VARCHAR 																			COMMENT '(short) item_1 name in local LANGUAGE',
	ITEM_DESCR								VARCHAR 																			COMMENT '(long) item_1 description in local LANGUAGE',
	ITEM_INT_DESCR							VARCHAR 																			COMMENT '(long) item_1 description in international LANGUAGE of centre (Deutsch)',
	ITEM_FAM_GRP_SID						INTEGER		 																		COMMENT 'Sid for item_1 family group.',
	ITEM_FAM_GRP_SRC_ID						INTEGER		 																		COMMENT 'ID for family group from source system.',
	ITEM_FAM_GRP_SRC_CD						VARCHAR 																			COMMENT 'Wawi Code for Article family group',
	ITEM_FAM_GRP_NAME						VARCHAR 																			COMMENT 'Family group name.',
	ITEM_FAM_GRP_DESCR						VARCHAR 																			COMMENT 'Family group description (local).',
	ITEM_FAM_GRP_INT_DESCR					VARCHAR 																			COMMENT 'Family group description (international).',

	-- UWG
	SUB_ITEM_GRP_GID						INTEGER						DEFAULT -1000											COMMENT 'UWG orig Item_1 number Surrogate GID - As-Was Join key for Frontend',
	SUB_ITEM_GRP_MSTR_GID 					INTEGER																				COMMENT 'Technical Field: MSTR GID',								
	
	SUB_ITEM_GRP_SID						INTEGER		 																		COMMENT 'Sid for item_1 sub group. UWG',
	SUB_ITEM_GRP_MSTR_SID					INTEGER		 																		COMMENT 'Sub Item_1 Group SID (MSTR formatted) ',
	SUB_ITEM_GRP_SRC_CD						VARCHAR 																			COMMENT 'Item_1 sub group Wawi Source Code',
	SUB_ITEM_GRP_NAME						VARCHAR 																			COMMENT 'Item_1 sub group name.',
	SUB_ITEM_GRP_DESCR						VARCHAR 																			COMMENT 'Item_1 sub group description (local).',
	SUB_ITEM_GRP_INT_DESCR					VARCHAR 																			COMMENT 'Item_1 sub group description (international).',

	-- WGI
	ITEM_GRP_INT_GID						INTEGER						DEFAULT -1000											COMMENT 'UWG orig Item_1 number Surrogate GID - As-Was Join key for Frontend',
	ITEM_GRP_INT_MSTR_GID 					INTEGER																				COMMENT 'Technical Field: MSTR GID',			

	ITEM_GRP_INT_SID						INTEGER		 																		COMMENT 'Sid for item_1 international group. WGI',
	ITEM_GRP_INT_MSTR_SID					INTEGER		 																		COMMENT 'SID for item_1 group international (WGI) (MSTR formatted) ',
	ITEM_GRP_INT_SRC_CD						VARCHAR 																			COMMENT 'Code for international group from source system.',
	ITEM_GRP_INT_NAME						VARCHAR 																			COMMENT 'International group name.',
	ITEM_GRP_INT_DESCR						VARCHAR 																			COMMENT 'International group description (local).',
	ITEM_GRP_INT_INT_DESCR					VARCHAR 																			COMMENT 'International group description (international).',
	BRAND_SID								INTEGER		 																		COMMENT 'Sid for brand_1 of item.',
	BRAND_NAME								VARCHAR 																			COMMENT 'Brand_1 name.',
	BRAND_TYPE_CD							VARCHAR 																			COMMENT 'Brand_1 type.',
	BUYING_LIST_TYPE_ID						INTEGER		 																		COMMENT 'ID for buying list type. Only on Country_1 Level – no regionalization.',
	BUYING_LIST_TYPE_DESCR					VARCHAR 																			COMMENT 'Buying list type description (local).',
	BUYING_LIST_TYPE_INT_DESCR				VARCHAR 																			COMMENT 'Buying list type description (international).',
	SUPPLIER_LIST_DESCR						VARCHAR 																			COMMENT 'Future use: Comma separated list of suppliers / Vendors of this article. Descriptive Information only.',
	ACTION_TYPE_ID							INTEGER			NOT NULL 															COMMENT 'Action type id. -2 = Reporting Line Total, -1 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively. ',
	ACTION_TYPE_SORT_VAL					INTEGER		 																		COMMENT 'Sort information for reporting purposes.',
	ACTION_TYPE_NAME						VARCHAR 																			COMMENT '(short) name in local LANGUAGE',
	ACTION_TYPE_DESCR						VARCHAR 																			COMMENT '(long)  description in local LANGUAGE (may be unavailable)',
--	PV_TYPE_ID								NUMBER(38,0)																COMMENT 'Type of PV (List of PV Types: Wawi PV ::= 1 | LP ::= 2 | NPPS ::= 3 | -1 ::= N/A | -2 ::= Total PV)'
	SORT_ORDER_VAL							VARCHAR 																			COMMENT 'Default sorting order for the report',

	--  Fakten / Measures / KPIs
	ADD_RECEIPT_CNT							NUMBER(38,0) 																		COMMENT 'Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_RECEIPT_PER_STORE_CNT				NUMBER(38,0)																		COMMENT 'Additional number of receipts, caused by the advertised PV item_1 per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_VAL					NUMBER(38,5) 																		COMMENT 'Additional TurnOVER, caused by the advertised PV item. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_PER_STORE_VAL			NUMBER(38,5) 																		COMMENT 'Additional TurnOVER, caused by the advertised PV item_1, per store. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_QTY						NUMBER(38,0)																		COMMENT 'Additional turnover qantity, caused by the advertised PV item. Calculated by number of soled item_1 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_PER_STORE_QTY				NUMBER(38,0)																		COMMENT 'Additional turnover qantity, caused by the advertised PV item_1 per store. Calculated by number of soled item_1 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_REVENUE_NET_VAL			NUMBER(38,5) 																		COMMENT 'Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_REVENUE_NET_PER_STORE_VAL	NUMBER(38,5)																		COMMENT 'Additional Revenue, caused by the advertised PV item_1 per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADV_ITEM_CNT							NUMBER(38,0) 																		COMMENT 'Number of action items that have been sold in any action_type (PV / NF / FA) during an advertising period.',
	ADV_ITEM_PER_RECEIPT_CNT				NUMBER(38,5) 																		COMMENT 'Average number (pieces) of the advertised item_1 per receipt, which contains this item_1, during the advertising period.',
	ADV_RECEIPT_ADV_TURNOVER_NET_VAL		NUMBER(38,5) 																		COMMENT 'Total action net turnOVER (only the advertised items), of receipts that contain the specific advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.',
	ADV_RECEIPT_NP_TURNOVER_NET_VAL			NUMBER(38,5) 																		COMMENT 'Normal price net turnOVER of receipts: Sum of the net turnOVER of all other non-advertised items of receipts containing the advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of all advertised items (including the specific advertised item_1) is excluded. See descriptions of the detailed formula components.',
	ADV_RECEIPT_TOTAL_TURNOVER_NET_VAL		NUMBER(38,5) 																		COMMENT 'Total net turnOVER of receipts (promotion, non-promotion items), that contain the specific advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.',
	BASE_RECEIPT_CNT						NUMBER(38,0) 																		COMMENT 'Expected/estimated number of receipts with specific item_1 / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	BASE_RESTBON_TURNOVER_NET_VAL			NUMBER(38,5) 																		COMMENT 'Expected baseline value for TurnOVER of Receipt Rest (Avg.) from the last 6 advertising weeks (median OVER the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_NET_VAL					NUMBER(38,5) 																		COMMENT 'Expected/estimated turnOVER of specific item_1 / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_QTY						NUMBER(38,5) 																		COMMENT 'Expected / estimated sold quantity of the action item_1 within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_REVENUE_NET_VAL			NUMBER(38,5) 																		COMMENT 'Expected / estimated generated revenue of the action item_1 within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	CHEAPER_MAX_PCT							NUMBER(38,5) 																		COMMENT 'Maximum price reduction in % for the advertised PV item_1, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_1 type on advertising period level. ',
	CHEAPER_MIN_PCT							NUMBER(38,5) 																		COMMENT 'Minimum price reduction in % for the advertised PV item_1, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_1 type on advertising period level. ',
	CHEAPER_RANGE							VARCHAR 																			COMMENT 'Price reduction in % for the advertised PV item. Calculated only for PV item_1 type on advertising period level. Price reductions could be different for each store, so it is displayed as a range from the minimum to the maximum reduction, which occured in a store.',
	
	CHEAPER_WEIGHTED_AVG_IN_PCT				NUMBER(38,5) 																		COMMENT '[Gewichteter Mittelwert Billiger] Weighted avarage price reduction in % for the advertised PV item_1, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_1 type on advertising period level. ',

	CHERRY_PICKER_RECEIPT_CNT				NUMBER(38,0) 																		COMMENT 'Number of \"cherry picker\" receipts, that contain the PV item_1 and the net turnOVER sum of all PV items on this receipt is at least 70% of the total receipt turnOVER. Only calculated for PV items. Return receipts are ignored. Not trivially aggregatable.',
	CHERRY_PICKER_RECEIPT_CNT_PCT			NUMBER(38,5) 																		COMMENT 'Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	EXCLUSIVE_BUYER_RECEIPT_CNT				NUMBER(38,0) 																		COMMENT 'Number of the \"exclusive buyer\" receipts, that contain only one PV item_1 (multiple pieces of this item_1 are possible), and no other items on this receipt. Only calculated for PV items.',
	EXCLUSIVE_BUYER_RECEIPT_CNT_PCT			NUMBER(38,5) 																		COMMENT 'Exclusive Buyer Quote in %: Number of Exclusive Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	HEAVY_BUYER_RECEIPT_CNT					NUMBER(38,0) 																		COMMENT 'Number of \"heavy buyer\" receipts, which contain the advertised item_1 (any type PV / NF / FA) and whose net turnOVER sum of all advertised items (any type PV / NF / FA) on this receipt is at least 70% of the total receipt''s turnOVER, and the sales_1 quantity sum of all these advertised items on this receipt is at least 70% of the total receipt''s sales_1 quantity. Return receipts are ignored. Not trivially aggregatable.',
	HEAVY_BUYER_RECEIPT_CNT_PCT				NUMBER(38,5) 																		COMMENT 'Heavy Buyer Quote in %: Number of Heavy Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	PRICE_BUY_NET							NUMBER(38,5) 																		COMMENT 'Net buying price of the advertised item. Calculated as average of the delivered net value sum, divided by the delivered quantity from the warehouse receivings. ',
	PRICE_RETAIL_NEW_GROSS_RANGE			VARCHAR 																			COMMENT 'Price Retail New (Gross): Gross retail price (sales_1 price) for the advertised item. Prices could be different for each store, so it is displayed as a range from the minimum to the maximum price, which occured in a store. Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the \"new\" price, which is reduced from the old price.',
	PRICE_RETAIL_NEW_MAX_GROSS				NUMBER(38,5) 																		COMMENT 'Price Retail New Max. (Gross): Maximum new gross price (sales_1 price) for the advertised item_1, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the \"new\" price, which is reduced from the old price.',
	PRICE_RETAIL_NEW_MIN_GROSS				NUMBER(38,5) 																		COMMENT 'Price Retail New Min. (Gross): Minimum new gross price (sales_1 price) for the advertised PV item_1, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the \"new\" price, which is reduced from the old price.',
	PRICE_RETAIL_OLD_GROSS_RANGE			VARCHAR 																			COMMENT 'Price Retail Old (Gross): Old gross retail price (sales_1 price) for the advertised PV item. Calculated only for PV item_1 type on advertising period level. Old prices could be different for each store, so it is displayed as a range from the minimum to the maximum old price, which occured in a store.',
	PRICE_RETAIL_OLD_MAX_GROSS				NUMBER(38,5) 																		COMMENT 'Source, logic will be decided by CO! Price Retail Old Max. (Gross): Maximum old gross price (sales_1 price) for the advertised PV item_1, which occured in a store (old prices could be different for each store). Calculated only for PV item_1 type on advertising period level.',
	PRICE_RETAIL_OLD_MIN_GROSS				NUMBER(38,5) 																		COMMENT 'Source, logic will be decided by CO! Price Retail Old Min. (Gross): Minimum old gross price (sales_1 price) for the advertised PV item_1, which occured in a store (old prices could be different for each store). Calculated only for PV item_1 type on advertising period level. ',

	PRICE_RETAIL_OLD_WEIGHTED_AVG_GROSS		NUMBER(38,5) 																		COMMENT '[Gewichteter Mittelwert VK_1 (alt) (brutto)]  Weighted avarage price Retail Old (Gross): Weighted avarage old gross price (sales_1 price) for the advertised item_1, which occured in a store (prices could be different for each store).',
	PRICE_RETAIL_NEW_WEIGHTED_AVG_GROSS		NUMBER(38,5) 																		COMMENT '[Gewichteter Mittelwert VK_1 (neu) (brutto)]  Weighted avarage price Retail New (Gross): Weighted avarage new gross price (sales_1 price) for the advertised item_1, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the \"new\" price, which is reduced from the old price.',

	PV_EFFIC_REVENUE_FACTOR					NUMBER(38,5) 																		COMMENT 'Additional Revenue vs. Additional TurnOVER as a factor, caused by the advertised PV item. Indirectly uses the baseline values for revenue, turnOVER from the last 6 weeks. Only for PV.',
	PV_EFFIC_TURNOVER_FACTOR				NUMBER(38,5) 																		COMMENT '(Additional TurnOVER minus Costs for the Price Reduction) vs. Costs for the Price Reduction, for the advertised PV item.',
	PV_NET_VAL								NUMBER(38,5) 																		COMMENT 'Absolute Advertising PV value in local currency. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.',
	PV_NET_VAL_SHARE_PCT					NUMBER(38,5) 																		COMMENT 'Advertising PV as percentage of absolute advertising PV vs. total turnOVER of all items (promo, non-promo).',
	PV_LP_NET_VAL							NUMBER(38,5)																		COMMENT 'Absolute Advertising PV value in local currency for LP action type. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.',
	PV_LP_NET_VAL_SHARE_PCT					NUMBER(38,5)																		COMMENT 'Advertising PV as percentage of absolute advertising PV LP vs. total turnOVER of all items (promo, non-promo).',
	PV_NPPS_NET_VAL							NUMBER(38,5)																		COMMENT 'Absolute Advertising PV value in local currency for NPPS action type. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.',
	PV_NPPS_NET_VAL_SHARE_PCT				NUMBER(38,5)																		COMMENT 'Advertising PV as percentage of absolute advertising PV NPPS vs. total turnOVER of all items (promo, non-promo).',
	PV_WAWI_NET_VAL							NUMBER(38,5)																		COMMENT 'Absolute Advertising PV value in local currency for WAWI action type. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.',
	PV_WAWI_NET_VAL_SHARE_PCT				NUMBER(38,5)																		COMMENT 'Advertising PV as percentage of absolute advertising PV WAWI vs. total turnOVER of all items (promo, non-promo).',
	PV_RECEIPT_CNT_FACTOR					NUMBER(38,5) 																		COMMENT 'Factor of the Number of Receipts having this advertised PV item_1 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.',
	PV_TURNOVER_NET_VAL_FACTOR				NUMBER(38,5) 																		COMMENT 'Factor of the TurnOVER of this advertised PV item_1 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.',
	PV_TURNOVER_QTY_FACTOR					NUMBER(38,5) 																		COMMENT 'Factor of the Sales_1 Quantity of this advertised PV item_1 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.',
	RECEIPT_CNT								NUMBER(38,0) 																		COMMENT 'Number of advertised items receipts for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_1 and possibly other items. The advertised item_1 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_1 was bought, independently of the sold quantity.',
	RECEIPT_CNT_SHARE_PCT					NUMBER(38,5) 																		COMMENT 'Share of All Total Receipts in %: Share of the receipts that contain this advertised item_1, of the total number of receipts (containing promotion and / or non-promotion items), of a country_1 for the specific timeframe (advertising period / advertising week).',
	RECEIPT_PER_STORE_CNT					NUMBER(38,5) 																		COMMENT 'Number of advertised items receipts per store for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_1 and possibly other items. The advertised item_1 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_1 was bought, independently of the sold quantity.',
	RESTBON_EFFECT_PCT						NUMBER(38,5) 																		COMMENT 'TurnOVER of the rest of the receipt vs. its baseline in %, caused by the advertised PV item. Calculated by comparing the rest of the receipt during this promotion vs. the baseline value from the last 6 weeks. Only for PV. Only for these stores, which had this PV item_1 in promotion in the current advertising week.',
	RESTBON_NP_TURNOVER_NET_VAL				NUMBER(38,5) 																		COMMENT 'Rest of the receipt having a normal price: Average sum of the net turnOVER of all other non-advertised items of receipts containing the advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of all advertised items (including the specific advertised item_1) is excluded. See descriptions of the detailed formula components.',
	RESTBON_TURNOVER_NET_VAL				NUMBER(38,5) 																		COMMENT 'Rest of the receipt: Average sum of the net turnOVER of all other items (incl. other advertised items) of receipts containing the advertised item_1, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnOVER of the advertised item_1 is excluded. See descriptions of the detailed formula components.',
	RESTBON_TURNOVER_REVENUE_NET_VAL		NUMBER(38,5) 																		COMMENT 'The generated revenue (turnOVER minus buying price volume) of all items (promotion, non-promotion items) of the rest of the receipts (excluding the action item_1), which contain the advertised item. For the specific timeframe (advertising period / advertising week), in local currency.',
	STORE_CNT								NUMBER(38,0) 																		COMMENT 'Number of stores that sold the action item_1 in the specific timeframe (advertising period / advertising week), in the region. For NF/FA items, additional 5 days prior advertising period are considered. No trivial aggregation, because each store might have multiple different items advertised.',
	TOTAL_RECEIPT_CNT						NUMBER(38,0) 																		COMMENT 'Total number of all receipts (containing promotion and / or non-promotion items) of a country_1 for the specific timeframe (advertising period / advertising week).',
	TOTAL_TURNOVER_NET_VAL					NUMBER(38,5) 																		COMMENT 'Total net turnOVER of all items (promotion, non-promotion items) of a country_1 for the specific timeframe (advertising period / advertising week), in local currency. Returns are ignored. Especially on advertising week level: only the 7 days of the advertising week are considered.',
	TURNOVER_MARGIN_PCT						NUMBER(38,5) 																		COMMENT 'Revenue generated (turnOVER minus buying price volume) with this sold action item_1 vs. TurnOVER in %.',
	TURNOVER_NET_PER_STORE_VAL				NUMBER(38,5) 																		COMMENT 'Net turnOVER of the advertised item_1 per store, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_VAL						NUMBER(38,5) 																		COMMENT 'Net turnOVER of the advertised item_1, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_VAL_SHARE_PCT				NUMBER(38,5) 																		COMMENT 'Total TurnOVER Share in %: TurnOVER of this advertised item_1 vs. the total turnOVER of all items (promo, non-promo) of the country_1, for the specific timeframe (advertising period / advertising week).',
	TURNOVER_QTY							NUMBER(38,5) 																		COMMENT 'Sold quantity (returns are considered) of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_REVENUE_NET_VAL				NUMBER(38,5) 																		COMMENT 'Revenue generated with this sold action item. Absolute value of turnOVER minus buying price volume.',
	TURNOVER_REVENUE_NET_STORE_VAL			NUMBER(38,5)																		COMMENT 'Absolute revenue in local currency per store.',
	VOLUME_BUY_NET_VAL						NUMBER(38,5) 																		COMMENT 'Buying Volume based on sales_1 in local currency. Calculated as the net buying price, multiplied by the sales_1 quantity of this advertised item_1 during the period.',

	--  Technical fields
	REJECT_FG								SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID						INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID						INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Manual/Static',
	DELETED_FG								SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 							COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP		 																	COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID									INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Technical Field. ETL / AB-Initio Process ID',
	PRIMARY KEY (CLIENT_ID, WAREHOUSE_SID, ADV_WEEK_ID, REPORTING_LINE_SID, ORIG_ITEM_NR, ACTION_TYPE_ID, DELETED_FG)
)	COMMENT='Frontend MSTR Aggregate Table at the NAN level aggregated on Country_1 / Region_1 (WH), AdvWeek, ActionType. Information included for UWG, WGI.'
;