/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_REGION_CENTRAL_NAN_2
#-------------------------------------------------------------------------------
# Description: DDL for frontend MSTR Aggregate Table at the NAN (orig_item_nr) level
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-08-02 Prasanna Ranjan  Initial version
#  4.1  2024-09-05 Nikolai Toknov	Adjustments of comments.
#  4.2  2024-09-24 Prasanna Ranjan	Adjustment Increment 2.1 (PV)
#  4.3  2024-12-17 Nikolai Toknov	Drop column PV_TYPE_ID
#  4.4  2024-12-23 Nikolai Toknov	Rename  MEDIUM_GRP_MSTR_SID_FE_LST -> MEDIUM_GRP_MSTR_SID_LST, MEDIUM_MSTR_SID_FE_LST -> MEDIUM_MSTR_SID_LST
#  4.5  2025-01-14 Nikolai Toknov	Drop columns MEDIUM_IGNORE_FG,MEDIUM_GRP_LIDLPLUS_FG,MEDIUM_ITEM_DISP_FG,MEDIUM_GRP_DRILLDOWN_DISP_FG
#  4.6  2025-01-25 Nikolai Toknov	Add columns PRICE_RETAIL_OLD_WEIGHTED_AVG_GROSS, PRICE_RETAIL_NEW_WEIGHTED_AVG_GROSS, CHEAPER_WEIGHTED_AVG_IN_PCT
#  4.7  2025-02-10 Nikolai Toknov	Add REJECT_LDESCR
#  4.8  2025-03-17 Nikolai Toknov	Add REPORTING_LINE_SID,REPORTING_LINE_DESCR
#  4.9  2025-03-20 Prasanna Ranjan	Add PV_ON_PV_DESCR
#  4.10 2025-03-24 Nikolai Toknov	Change for Azure-pipeline
#  4.11	2025-05-14 Nikolai Toknov 	Inkrement 2.1 CR new types of LP-promotions(Mail: 09.05.2025)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;
*/

/*
ALTER table P_LEW_FE_MSTR_PIT.T_AGG_REGION_CENTRAL_NAN_2 ADD
	REPORTING_LINE_SID						INTEGER					 								COMMENT 'Hierarchy_2 level number to identify the individual reporting line (row) of e.g. a precalculated summary line.',
	REPORTING_LINE_DESCR					VARCHAR 												COMMENT 'Description of the Reporting Line';
	PV_ON_PV_DESCR							VARCHAR													COMMENT 'Ursprungs-Werbe-PV: Shows if item_2 has already a Werbe-PV applied f.e. when LP-Werbe-PV on WaWi-Werbe-PV we display WaWi-Werbe-PV';

ALTER table P_LEW_FE_MSTR_PIT.T_AGG_REGION_CENTRAL_NAN_2 ADD
	COUPON_AGG_LIST_DESCR							VARCHAR																		COMMENT 'LP Coupons Description';

*/

CREATE TABLE P_LEW_FE_MSTR_PIT.T_AGG_REGION_CENTRAL_NAN_2 CLUSTER BY (CLIENT_ID, ADV_WEEK_ID) (
	CLIENT_ID								INTEGER			NOT NULL 													COMMENT 'Client id',
	COUNTRY_ISO_CD							VARCHAR(3) 																	COMMENT 'Country_2 ISO Code = WAWI Country_2 ',
	COUNTRY_DESCR							VARCHAR 																	COMMENT 'Country_2 Name',

	WAREHOUSE_SID							INTEGER			NOT NULL 													COMMENT 'Warehouse Surrogate ID',
	WAREHOUSE_MSTR_SID						INTEGER		 																COMMENT 'Warehouse Surrogate ID',
	-- GID
	WAREHOUSE_GID							INTEGER		 				DEFAULT -1000									COMMENT 'Warehouse Surrogate GID - As-Was Join key for Frontend',
	WAREHOUSE_MSTR_GID 						INTEGER 																	COMMENT 'Technical Field: MSTR GID',
	WAREHOUSE_NAME							VARCHAR 																	COMMENT 'Warehouse Name',
	ORIG_WH_NR								INTEGER		 																COMMENT 'Original Warehouse Number  / code from Wawi',

	ADV_WEEK_ID								INTEGER			NOT NULL 													COMMENT 'Advertising week BK',
	ADV_WEEK_MSTR_ID						INTEGER		 																COMMENT 'Advertising week MSTR Key. (AdvWeek No. concatenated with 2-digit client ID)',
	NEAREST_RLTD_ADV_WEEK_FG				SMALLINT																	COMMENT '1: Flag indicates, that the related adv week is the previous of the adv week; 0: any other related adv week',
	ADV_WEEK_START_DT						DATE 																		COMMENT 'Start Date of Adv-Week',
	ADV_WEEK_END_DT							DATE 																		COMMENT 'End Date of Adv.-Week',
	ADV_WEEK_START_DT_DESCR					VARCHAR 																	COMMENT 'Start Date of the Adv. Week in German format for the frontend',
	ADV_WEEK_END_DT_DESCR					VARCHAR 																	COMMENT 'End Date of the Adv. Week in German format for the frontend',
	ADV_WEEK_START_DAY_SDESCR				VARCHAR 																	COMMENT 'German short description of the week day, when this adv week starts',
	ADV_WEEK_END_DAY_SDESCR					VARCHAR 																	COMMENT 'German short description of the week day, when this adv week ends',
	ADV_WEEK_START_DAY_DESCR				VARCHAR 																	COMMENT 'German description of the week day, when this adv week starts',
	ADV_WEEK_END_DAY_DESCR					VARCHAR 																	COMMENT 'German description of the week day, when this adv week ends',
	LENGTH_OF_ADV_WEEK						SMALLINT	 																COMMENT 'Number of Days in Adv. Week',
	ADV_WEEK_YEAR_ID						INTEGER		 																COMMENT 'Year ID of the Adv.-Week. 202137 -> 2021. Needed for Reporting',
	ADV_WEEK_WEEK_NR						INTEGER		 																COMMENT 'Adv.Week Week Nbr. E.g. 202137 -> 37. Needed for Reporting',
	ADV_WEEK_SDESCR							VARCHAR 																	COMMENT 'Adv. Week Short Description',
	ADV_WEEK_DESCR							VARCHAR 																	COMMENT 'Adv.Week Description',
	ADV_WEEK_LDESCR							VARCHAR 																	COMMENT 'Adv. Week Long Description incl. dates',
	ADV_WEEK_OVERLAP_LDESCR					VARCHAR 																	COMMENT 'Adv.Week Long Description incl. dates and the maximum date of the overlapping range into the next adv week',

	PREV_1_ADV_WEEK_ID						INTEGER		 																COMMENT 'Previous 1 Adv.Week ID e.g. 202124 -> 202123',
	NEXT_1_ADV_WEEK_ID						INTEGER		 																COMMENT 'Next 1 Adv.Week ID e.g. 202124 -> 202125',
	PREV_1_YEAR_ADV_WEEK_ID					INTEGER		 																COMMENT 'Previous 1 Year Adv.Week ID e.g. 202124 -> 202024',
	LAST_ADV_WEEK_FG						SMALLINT					DEFAULT 0 										COMMENT 'Flag / indicator last Adv.Week = 1',
	LAST_CLOSED_ADV_WEEK_FG					SMALLINT					DEFAULT 0 										COMMENT 'Flag / indicator last closed Adv.Week = 1',
	MOV_ADV_WEEK_START_FROM_CURRENT			INTEGER		 																COMMENT 'Current Adv.-Week is ::0 , pervious Adv.-Week is -1 Next Adv. Week is +1',
	MAX_ADV_PERIOD_END_DT					DATE 																		COMMENT 'maximum assigned Adv. Period End Date, in case of overlapping period. Needed for Reporting Information Window.',

	REPORTING_LINE_SID						INTEGER					 													COMMENT 'Hierarchy_2 level number to identify the individual reporting line (row) of e.g. a precalculated summary line.',
	REPORTING_LINE_DESCR					VARCHAR 																	COMMENT 'Description of the Reporting Line',

	-- GID
	ORIG_ITEM_GID							INTEGER						DEFAULT -1000									COMMENT 'NAN orig Item_2 number Surrogate GID - As-Was Join key for Frontend',
	ORIG_ITEM_MSTR_GID 						INTEGER 																	COMMENT 'Technical Field: MSTR GID',

	ORIG_ITEM_NR							INTEGER		 																COMMENT 'Item_2 business identifier. NaN := National Article Number',
	ORIG_ITEM_MSTR_NR						INTEGER					 													COMMENT 'Item_2 business identifier. (NaN := National Article Number) MSTR Key: Special MSTR Join criteria to have surrogate ORIG_ITEM_NR + CLIENT_ID',
	DAT_VALID_FROM							DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') 	COMMENT 'Original Item_2 Source DATE from.',

	ITEM_NAME								VARCHAR 																	COMMENT '(short) item_2 name in local LANGUAGE',
	ITEM_DESCR								VARCHAR 																	COMMENT '(long) item_2 description in local LANGUAGE',
	ITEM_INT_DESCR							VARCHAR 																	COMMENT '(long) item_2 description in international LANGUAGE of centre (Deutsch)',

	ITEM_FAM_GRP_SID						INTEGER		 																COMMENT 'Sid for item_2 family group.',
	ITEM_FAM_GRP_SRC_ID						INTEGER		 																COMMENT 'ID for family group from source system.',
	ITEM_FAM_GRP_SRC_CD						VARCHAR 																	COMMENT 'Wawi Code for Article family group',
	ITEM_FAM_GRP_NAME						VARCHAR 																	COMMENT 'Family group name.',
	ITEM_FAM_GRP_DESCR						VARCHAR 																	COMMENT 'Family group description (local).',
	ITEM_FAM_GRP_INT_DESCR					VARCHAR 																	COMMENT 'Family group description (international).',

	-- UWG
	SUB_ITEM_GRP_GID						INTEGER						DEFAULT -1000									COMMENT 'UWG orig Item_2 number Surrogate GID - As-Was Join key for Frontend',
	SUB_ITEM_GRP_MSTR_GID 					INTEGER																		COMMENT 'Technical Field: MSTR GID',

	SUB_ITEM_GRP_SID						INTEGER		 																COMMENT 'Sub Item_2 Group SID',
	SUB_ITEM_GRP_MSTR_SID					INTEGER		 																COMMENT 'Sub Item_2 Group SID (MSTR formatted)',
	SUB_ITEM_GRP_SRC_CD						VARCHAR 																	COMMENT 'Item_2 sub group Wawi Source Code',
	SUB_ITEM_GRP_NAME						VARCHAR 																	COMMENT 'Item_2 sub group name.',
	SUB_ITEM_GRP_DESCR						VARCHAR 																	COMMENT 'Item_2 sub group description (local).',
	SUB_ITEM_GRP_INT_DESCR					VARCHAR 																	COMMENT 'Item_2 sub group description (international).',

	-- WGI
	ITEM_GRP_INT_GID						INTEGER						DEFAULT -1000									COMMENT 'UWG orig Item_2 number Surrogate GID - As-Was Join key for Frontend',
	ITEM_GRP_INT_MSTR_GID 					INTEGER																		COMMENT 'Technical Field: MSTR GID',

	ITEM_GRP_INT_SID						INTEGER		 																COMMENT 'SID for item_2 group international (WGI)',
	ITEM_GRP_INT_MSTR_SID					INTEGER		 																COMMENT 'SID for item_2 group international (WGI) (MSTR formatted)',
	ITEM_GRP_INT_SRC_CD						VARCHAR 																	COMMENT 'Code for international group from source system.',
	ITEM_GRP_INT_NAME						VARCHAR 																	COMMENT 'International group name.',
	ITEM_GRP_INT_DESCR						VARCHAR 																	COMMENT 'International group description (local).',
	ITEM_GRP_INT_INT_DESCR					VARCHAR 																	COMMENT 'International group description (international).',

	BRAND_SID								INTEGER		 																COMMENT 'Sid for brand_2 of item.',
	BRAND_NAME								VARCHAR 																	COMMENT 'Brand_2 name.',
	BRAND_TYPE_CD							VARCHAR 																	COMMENT 'Brand_2 type.',

	BUYING_LIST_TYPE_ID						INTEGER		 																COMMENT 'ID for buying list type. Only on Country_2 Level – no regionalization.',
	BUYING_LIST_TYPE_DESCR					VARCHAR 																	COMMENT 'Buying list type description (local).',
	BUYING_LIST_TYPE_INT_DESCR				VARCHAR 																	COMMENT 'Buying list type description (international).',

	SUPPLIER_LIST_DESCR						VARCHAR 																	COMMENT 'Future use: Comma separated list of suppliers / Vendors of this article. Descriptive Information only.',

	ADV_PERIOD_ID							INTEGER			NOT NULL 													COMMENT 'Unique identifier of Adv. Period',
	ADV_PERIOD_MSTR_ID						INTEGER		 																COMMENT 'Needed for MSTR Reporting',
	ADV_PERIOD_START_DT						DATE 																		COMMENT 'Start Date of the Adv.Period',
	ADV_PERIOD_END_DT						DATE 																		COMMENT 'End Date of the Adv.Period',
	ADV_PERIOD_START_DAY_ID					SMALLINT	 																COMMENT 'Day Number of the Adv.Period Start Day (nach ISO)',
	ADV_PERIOD_START_DT_DESCR				VARCHAR 																	COMMENT 'Start Date of the Adv.Period in German format for the frontend',
	ADV_PERIOD_END_DT_DESCR					VARCHAR 																	COMMENT 'End Date of the Adv.Period in German format for the frontend',
	ADV_PERIOD_END_DAY_ID					SMALLINT	 																COMMENT 'Day Number of the Adv.Period End Day',
	ADV_PERIOD_START_DAY_SDESCR				VARCHAR 																	COMMENT 'German short description of the week day, when this period starts',
	ADV_PERIOD_END_DAY_SDESCR				VARCHAR 																	COMMENT 'German short description of the week day, when this period ends',
	ADV_PERIOD_START_DAY_DESCR				VARCHAR 																	COMMENT 'German description of the week day, when this period starts',
	ADV_PERIOD_END_DAY_DESCR				VARCHAR 																	COMMENT 'German description of the week day, when this period ends',
	ADV_PERIOD_LENGTH_IN_DAYS				SMALLINT	 																COMMENT 'Length of the Adv.Period',
	ADV_PERIOD_CNT							NUMBER(38,0)																COMMENT 'Number of unique store-level (start and end dates) periods.',

	OVERLAP_PERIOD_FG						SMALLINT	 																COMMENT 'Flag Indicates is True (1) if period extend into next calendar_2 week',
	OVERLAP_ADV_PERIOD_START_DT				DATE 																		COMMENT 'Start Date of the overlapping  Adv.Period. (Start_dt – overlap_end Dt) (overlap_start_dt – end_dt)',
	OVERLAP_ADV_PERIOD_END_DT				DATE 																		COMMENT 'End Date of the overlapping Adv.Period',
	OVERLAP_ADV_WEEK_ID						INTEGER		 																COMMENT 'Adv. Week ID of overlapping Periods. ',

	ADV_PERIOD_DESCR						VARCHAR 																	COMMENT 'Adv. Period Description',
	ADV_PERIOD_LDESCR						VARCHAR 																	COMMENT 'Adv.Period Long Description',

	CURRENT_ADV_PERIOD_FG					SMALLINT	 																COMMENT 'Flag / indicator current Adv.Period = 1',

	ACTION_TYPE_ID							INTEGER			NOT NULL 													COMMENT 'Action type id. -2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.',
	ACTION_TYPE_SORT_VAL					INTEGER		 																COMMENT 'Sort information for reporting purposes.',
	ACTION_TYPE_NAME						VARCHAR 																	COMMENT '(short) name in local LANGUAGE',
	ACTION_TYPE_DESCR						VARCHAR 																	COMMENT '(long)  description in local LANGUAGE (may be unavailable)',
	-- ACTION_TYPE_ID_FE_LST					VARCHAR																		COMMENT '',
	PV_ON_PV_DESCR							VARCHAR																		COMMENT 'Ursprungs-Werbe-PV: Shows if item_2 has already a Werbe-PV applied f.e. when LP-Werbe-PV on WaWi-Werbe-PV we display WaWi-Werbe-PV',

	THEME_GRP_INT_SID						INTEGER		 	NOT NULL	DEFAULT -1000									COMMENT 'Unique system ID, sid, for the theme int group.',
	THEME_GRP_INT_MSTR_SID					INTEGER																		COMMENT 'Unique system ID, sid, for the theme int group + Client_ID, as MSTR Key',
	THEME_GRP_INT_NAME						VARCHAR 																	COMMENT 'Theme int group name.',
	THEME_GRP_INT_SORT_VAL					INTEGER		 																COMMENT 'internal sorting value for the int theme (ordered by Theme group Name)',

	THEME_GRP_NAT_SID						INTEGER		 	NOT NULL	DEFAULT -1000									COMMENT 'Unique system ID, sid, for the theme nat group.',
	THEME_GRP_NAT_MSTR_SID					INTEGER																		COMMENT 'Unique system ID, sid, for the theme nat group + Client_ID, as MSTR Key',
	THEME_GRP_NAT_NAME						VARCHAR 																	COMMENT 'Theme nat group name.',
	THEME_GRP_NAT_SORT_VAL					INTEGER		 																COMMENT 'internal sorting value for the nat theme (ordered by Theme group Name)',

	THEME_GRP_NAT_CAT_SID					INTEGER		 	NOT NULL	DEFAULT -1000									COMMENT 'Unique system ID, sid, for the theme nat group category.',
	THEME_GRP_NAT_CAT_MSTR_SID				INTEGER																		COMMENT 'Unique system ID, sid, for the theme nat group category + Client_ID, as MSTR Key',
	THEME_GRP_NAT_CAT_NAME					VARCHAR 																	COMMENT 'Theme nat group category name.',
	THEME_GRP_NAT_CAT_SORT_VAL				INTEGER		 																COMMENT 'Internal sorting value for the nat theme category (ordered by Theme group Name)',

	MEDIUM_AGG_LIST_DESCR					VARCHAR 																	COMMENT 'Comma-separated list of all advertising media (of all media groups), in which this item_2 has been advertised during this period.',
	MEDIUM_GRP_AGG_LIST_DESCR				VARCHAR																		COMMENT '',
--	MEDIUM_ITEM_DISP_FG						NUMBER(38,0)																COMMENT '',
--	MEDIUM_GRP_DRILLDOWN_DISP_FG			NUMBER(38,0)																COMMENT '',
	MEDIUM_MSTR_SID_LST						VARCHAR																		COMMENT '',
--	MEDIUM_IGNORE_FG						NUMBER(38,0)																COMMENT 'Indicator / Flag Medium Ignore (hide the row for this medium in frontend)',
	MEDIUM_GRP_MSTR_SID_LST					VARCHAR																		COMMENT '',
--	MEDIUM_GRP_LIDLPLUS_FG					NUMBER(38,0)																COMMENT 'Indicator / Flag Medium Grouping on Lidl Plus',
	COUPON_AGG_LIST_DESCR					VARCHAR																		COMMENT 'LP Coupons Description',

--	PV_TYPE_ID								NUMBER(38,0)																COMMENT 'Type of PV (List of PV Types: Wawi PV ::= 1 | LP ::= 2 | NPPS ::= 3 | -1 ::= N/A | -2 ::= Total PV)',
	SORT_ORDER_VAL							VARCHAR 																	COMMENT 'Default sorting order for the report',

	--    Fakten / Measures / KPIs
	ADD_RECEIPT_CNT							NUMBER(38,0) 																COMMENT '[Zusatzbons (Anz.)] Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_RECEIPT_PER_STORE_CNT				NUMBER(38,0) 																COMMENT '[Zusatzbons / Filiale] Additional number of receipts, caused by the advertised PV item_2 per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_VAL					NUMBER(38,5) 																COMMENT '[Zusatzumsatz] Additional Turnover, caused by the advertised PV item. Calculated by turnover of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_PER_STORE_VAL			NUMBER(38,5) 																COMMENT '[Zusatzumsatz / Filiale] Additional Turnover, caused by the advertised PV item_2, per store (where the PV item_2 was sold). Calculated by turnover of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_QTY						NUMBER(38,0) 																COMMENT '[Zusatzmenge (Stk/kg)] Additional turnover qantity, caused by the advertised PV item. Calculated by number of soled item_2 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_PER_STORE_QTY				NUMBER(38,0) 																COMMENT '[Zusatzmenge / Filiale] Additional turnover qantity, caused by the advertised PV item_2 per store. Calculated by number of soled item_2 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_REVENUE_NET_VAL			NUMBER(38,5) 																COMMENT '[Zusatzertrag] Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADV_ITEM_PER_RECEIPT_CNT				NUMBER(38,5) 																COMMENT '[ø-Artikel_2 / Bon (Anz.)] Average number (pieces) of the advertised item_2 per receipt, which contains this item_2, during the advertising period.',
	ADD_TURNOVER_REVENUE_NET_PER_STORE_VAL	NUMBER(38,5) 																COMMENT '[Zusatzertrag / Filiale] Additional Revenue, caused by the advertised PV item_2 per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADV_RECEIPT_ADV_TURNOVER_NET_VAL		NUMBER(38,5) 																COMMENT '[Umsatz Aktionsbons Aktionsartikel] Total action net turnover (only the advertised items), of receipts that contain the specific advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.',
	ADV_RECEIPT_NP_TURNOVER_NET_VAL			NUMBER(38,5) 																COMMENT '[Aktivierter NP-Umsatz] Normal price net turnover of receipts: Sum of the net turnover of all other non-advertised items of receipts containing the advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnover of all advertised items (including the specific advertised item_2) is excluded. See descriptions of the detailed formula components.',
	ADV_RECEIPT_TOTAL_TURNOVER_NET_VAL		NUMBER(38,5) 																COMMENT '[Umsatz Aktionsbons Gesamt] Total net turnover of receipts (promotion, non-promotion items), that contain the specific advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.',
	BASE_RECEIPT_CNT						NUMBER(38,0) 																COMMENT '[Bons Baseline (Anz.)] | [Bons Baseline Gesamt (Anz.)] Expected/estimated number of receipts with specific item_2 / items of a specific group within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item_2 was not in PV). Calculated only for PV items.',
	BASE_RESTBON_TURNOVER_NET_VAL			NUMBER(38,5) 																COMMENT '[Ø-Restbon Baseline] Expected baseline value for Turnover of Receipt Rest (Avg.) from the last 6 advertising weeks (median over the same weekday, when this item_2 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_NET_VAL					NUMBER(38,5) 																COMMENT '[Umsatz Baseline] | [Umsatz brutto Baseline] | [Umsatz Baseline Gesamt] Expected/estimated turnover of specific item_2 / items of a specific group within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item_2 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_QTY						NUMBER(38,5) 																COMMENT '[Abverkauf Baseline (Stk/kg)] Expected / estimated sold quantity of the action item_2 within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item_2 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_REVENUE_NET_VAL			NUMBER(38,5) 																COMMENT '[Abverkaufsertrag Baseline] Expected / estimated generated revenue of the action item_2 within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item_2 was not in PV). Calculated only for PV items.',
	CHEAPER_MAX_PCT							NUMBER(38,5) 																COMMENT '[Billiger % bis] Maximum price reduction in % for the advertised PV item_2, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_2 type on advertising period level. ',
	CHEAPER_MIN_PCT							NUMBER(38,5) 																COMMENT '[Billiger % von] Minimum price reduction in % for the advertised PV item_2, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_2 type on advertising period level. ',
	CHEAPER_RANGE 							VARCHAR		 																COMMENT '[Billiger (%) WAWI PV] | [Billiger (%)  LP] Price reduction in % for the advertised PV item. Calculated only for PV item_2 type on advertising period level. Price reductions could be different for each store, so it is displayed as a range from the minimum to the maximum reduction, which occured in a store.',
	CHEAPER_WEIGHTED_AVG_IN_PCT				NUMBER(38,5) 																COMMENT '[Gewichteter Mittelwert Billiger] Weighted avarage price reduction in % for the advertised PV item_2, which occured in a store (Price reductions could be different for each store). Calculated only for PV item_2 type on advertising period level. ',
	CHERRY_PICKER_RECEIPT_CNT				NUMBER(38,0) 																COMMENT '[Cherry Picker (Anz.)] Number of \"cherry picker\" receipts, that contain the PV item_2 and the net turnover sum of all PV items on this receipt is at least 70% of the total receipt turnover. Only calculated for PV items. Return receipts are ignored. Not trivially aggregatable.',
	CHERRY_PICKER_RECEIPT_CNT_PCT			NUMBER(38,5) 																COMMENT '[Cherry Picker (%)] Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	DELIV_QTY								NUMBER(38,5) 																COMMENT '[Anliefermenge Filiale (Stk/kg)] Delivered Quantity (pc/kg) of the advertised NF/FA item. This is the sum of the deliveries (5 days before the period start date, up to 13 days after the period start date) and the stock on the 6th day before the period start date. Only for NF/FA items.',
	EXCLUSIVE_BUYER_RECEIPT_CNT				NUMBER(38,0) 																COMMENT '[Exklusiv-Käufer (Anz.)] number of the \"exclusive buyer\" receipts, that contain only one PV item_2 (multiple pieces of this item_2 are possible), and no other items on this receipt. Only calculated for PV items.',
	EXCLUSIVE_BUYER_RECEIPT_CNT_PCT			NUMBER(38,5) 																COMMENT '[Exklusiv-Käufer (%)] Exclusive Buyer Quote in %: number of Exclusive Buyer Receipts vs. number of Receipts having this advertised item. See other metrics as part of the formula.',
	HEAVY_BUYER_RECEIPT_CNT					NUMBER(38,0) 																COMMENT '[Cherry Picker (Anz.)] Number of \"heavy buyer\" receipts, which contain the advertised item_2 (any type PV / NF / FA) and whose net turnover sum of all advertised items (any type PV / NF / FA) on this receipt is at least 70% of the total receipts turnover, and the sales_2 quantity sum of all these advertised items on this receipt is at least 70% of the total receipts sales_2 quantity. Return receipts are ignored. Not trivially aggregatable.',
	HEAVY_BUYER_RECEIPT_CNT_PCT				NUMBER(38,5) 																COMMENT '[Cherry Picker (%)] Heavy Buyer Quote in %: Number of Heavy Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	PRICE_BUY_NET							NUMBER(38,5) 																COMMENT '[EK] Net buying price of the advertised item. Calculated as average of the delivered net value sum, divided by the delivered quantity from the warehouse receivings. ',
	PRICE_RETAIL_NEW_GROSS_RANGE 			VARCHAR		 																COMMENT '[VK_2 (neu) (brutto)] Price Retail New (Gross): Gross retail price (sales_2 price) for the advertised item. Prices could be different for each store, so it is displayed as a range from the minimum to the maximum price, which occured in a store. Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the \"new\" price, which is reduced from the old price.',
	PRICE_RETAIL_NEW_MAX_GROSS				NUMBER(38,5) 																COMMENT '[VK_2 (neu) (brutto) bis] Price Retail New Max. (Gross): Maximum new gross price (sales_2 price) for the advertised item_2, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the \"new\" price, which is reduced from the old price.',
	PRICE_RETAIL_NEW_MIN_GROSS				NUMBER(38,5) 																COMMENT '[VK_2 (neu) (brutto) von] Price Retail New Min. (Gross): Minimum new gross price (sales_2 price) for the advertised PV item_2, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the \"new\" price, which is reduced from the old price.',
	PRICE_RETAIL_OLD_GROSS_RANGE 			VARCHAR 	 																COMMENT '[VK_2 (alt) (brutto)] Price Retail Old (Gross): Old gross retail price (sales_2 price) for the advertised PV item. Calculated only for PV item_2 type on advertising period level. Old prices could be different for each store, so it is displayed as a range from the minimum to the maximum old price, which occured in a store.',
	PRICE_RETAIL_OLD_MAX_GROSS				NUMBER(38,5) 																COMMENT '[VK_2 (alt) (brutto) bis] Source, logic will be decided by CO! Price Retail Old Max. (Gross): Maximum old gross price (sales_2 price) for the advertised PV item_2, which occured in a store (old prices could be different for each store). Calculated only for PV item_2 type on advertising period level. ',
	PRICE_RETAIL_OLD_MIN_GROSS				NUMBER(38,5) 																COMMENT '[VK_2 (alt) (brutto) von] Source, logic will be decided by CO! Price Retail Old Min. (Gross): Minimum old gross price (sales_2 price) for the advertised PV item_2, which occured in a store (old prices could be different for each store). Calculated only for PV item_2 type on advertising period level. ',
	PRICE_RETAIL_OLD_WEIGHTED_AVG_GROSS		NUMBER(38,5) 																COMMENT '[Gewichteter Mittelwert VK_2 (alt) (brutto)]  Weighted avarage price Retail Old (Gross): Weighted avarage old gross price (sales_2 price) for the advertised item_2, which occured in a store (prices could be different for each store).',
	PRICE_RETAIL_NEW_WEIGHTED_AVG_GROSS		NUMBER(38,5) 																COMMENT '[Gewichteter Mittelwert VK_2 (neu) (brutto)]  Weighted avarage price Retail New (Gross): Weighted avarage new gross price (sales_2 price) for the advertised item_2, which occured in a store (prices could be different for each store). Calculated for PV, NF, FA items on advertising period level. For PV it is meant to be the \"new\" price, which is reduced from the old price.',
	PV_EFFIC_REVENUE_FACTOR					NUMBER(38,5) 																COMMENT '[PV-Effizienz Ertrag] Additional Revenue vs. Additional Turnover as a factor, caused by the advertised PV item. Indirectly uses the baseline values for revenue, turnover from the last 6 weeks. Only for PV.',
	PV_EFFIC_TURNOVER_FACTOR				NUMBER(38,5) 																COMMENT '[PV-Effizienz Umsatz] (Additional Turnover minus Costs for the Price Reduction) vs. Costs for the Price Reduction, for the advertised PV item.',
	PV_NET_VAL								NUMBER(38,5) 																COMMENT '[Werbe-PV (Basis Abverkauf) Gesamt] Absolute Advertising PV value in local currency. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.',
	PV_NET_VAL_SHARE_PCT					NUMBER(38,5) 																COMMENT '[Werbe-PV (Basis Abverkauf) Gesamt (%)] Advertising PV as percentage of absolute advertising PV vs. total turnover of all items (promo, non-promo).',
	PV_LP_NET_VAL							NUMBER(38,5) 																COMMENT '[Werbe-PV (Basis Abverkauf) Lidl Plus] Absolute Advertising PV value in local currency for LP action type. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.',
	PV_LP_NET_VAL_SHARE_PCT					NUMBER(38,5) 																COMMENT '[Werbe-PV (Basis Abverkauf) Lidl Plus (%)] Advertising PV as percentage of absolute advertising PV LP vs. total turnover of all items (promo, non-promo).',
	PV_NPPS_NET_VAL							NUMBER(38,5) 																COMMENT '[Werbe-PV (Basis Abverkauf) PromoDesigner] Absolute Advertising PV value in local currency for NPPS action type. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.',
	PV_NPPS_NET_VAL_SHARE_PCT				NUMBER(38,5) 																COMMENT '[Werbe-PV (Basis Abverkauf) PromoDesigner (%)] Advertising PV as percentage of absolute advertising PV NPPS vs. total turnover of all items (promo, non-promo).',
	PV_WAWI_NET_VAL							NUMBER(38,5) 																COMMENT '[Werbe-PV (Basis Abverkauf) WaWi] Absolute Advertising PV value in local currency for WAWI action type. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.',
	PV_WAWI_NET_VAL_SHARE_PCT				NUMBER(38,5) 																COMMENT '[Werbe-PV (Basis Abverkauf) WaWi (%)] Advertising PV as percentage of absolute advertising PV WAWI vs. total turnover of all items (promo, non-promo).',
	PV_RECEIPT_CNT_FACTOR					NUMBER(38,5) 																COMMENT '[Faktor Bons PV] Factor of the number of Receipts having this advertised PV item_2 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.',
	PV_TURNOVER_NET_VAL_FACTOR				NUMBER(38,5) 																COMMENT '[Faktor Umsatz PV] Factor of the Turnover of this advertised PV item_2 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.',
	PV_TURNOVER_QTY_FACTOR					NUMBER(38,5) 																COMMENT '[Faktor Menge PV] Factor of the Sales_2 Quantity of this advertised PV item_2 (during the adv period) vs. its expected baseline value from the last 6 weeks. Only for PV items. See other metrics as part of the formula.',
	RECEIPT_CNT								NUMBER(38,0) 																COMMENT '[Bons (Anz.)] Number of advertised items receipts for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_2 and possibly other items. The advertised item_2 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_2 was bought, independently of the sold quantity.',
	RECEIPT_CNT_SHARE_PCT					NUMBER(38,5) 																COMMENT '[Bon Penetration (%)] Share of All Total Receipts in %: Share of the receipts that contain this advertised item_2, of the total number of receipts (containing promotion and / or non-promotion items), of a country_2 for the specific timeframe (advertising period / advertising week).',
	RECEIPT_PER_STORE_CNT					NUMBER(38,5) 																COMMENT '[Bons / Filiale (Anz.)] Number of advertised items receipts per store for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_2 and possibly other items. The advertised item_2 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_2 was bought, independently of the sold quantity.',
	RESTBON_EFFECT_PCT						NUMBER(38,5) 																COMMENT '[Ø-Restbon Promotion vs. Ø-Restbon NP] Turnover of the rest of the receipt vs. its baseline in %, caused by the advertised PV item. Calculated by comparing the rest of the receipt during this promotion vs. the baseline value from the last 6 weeks. Only for PV. Only for these stores, which had this PV item_2 in promotion in the current advertising week.',
	RESTBON_NP_TURNOVER_NET_VAL				NUMBER(38,5) 																COMMENT '[Ø-Restbon NP] Rest of the receipt having a normal price: Average sum of the net turnover of all other non-advertised items of receipts containing the advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnover of all advertised items (including the specific advertised item_2) is excluded. See descriptions of the detailed formula components.',
	RESTBON_TURNOVER_NET_VAL				NUMBER(38,5) 																COMMENT '[Ø-Restbon] Rest of the receipt: Average sum of the net turnover of all other items (incl. other advertised items) of receipts containing the advertised item_2, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnover of the advertised item_2 is excluded. See descriptions of the detailed formula components.',
	RESTBON_TURNOVER_REVENUE_NET_VAL		NUMBER(38,5) 																COMMENT '[Ø-Kalkulation (Basis Abverkauf) (in %)Restbon] The generated revenue (turnover minus buying price volume) of all items (promotion, non-promotion items) of the rest of the receipts (excluding the action item_2), which contain the advertised item. For the specific timeframe (advertising period / advertising week), in local currency.',
	STORE_CNT								NUMBER(38,0) 																COMMENT '[Filialen (Basis Abverkauf) (Anz.)] Number of stores that sold the action item_2 in the specific timeframe (advertising period / advertising week), in the region. For NF/FA items, additional 5 days prior advertising period are considered. No trivial aggregation, because each store might have multiple different items advertised.',
	TOTAL_RECEIPT_CNT						NUMBER(38,0) 																COMMENT '[Bons Gesamt (Anz.)] Total number of all receipts (containing promotion and / or non-promotion items) of a country_2 for the specific timeframe (advertising period / advertising week).',
	TOTAL_TURNOVER_NET_VAL					NUMBER(38,5) 																COMMENT '[Umsatz Gesamt] Total net turnover of all items (promotion, non-promotion items) of a country_2 for the specific timeframe (advertising period / advertising week), in local currency. Returns are ignored. Especially on advertising week level: only the 7 days of the advertising week are considered.',
	TURNOVER_1D_PCT							NUMBER(38,5) 																COMMENT '[Abverkauf 1T (%)] Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only) of the first day of the advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_1D_PER_STORE_QTY				NUMBER(38,5) 																COMMENT '[Abverkauf / Filiale 1T (Stk/kg)] Sold quantity (returns are considered) per store of advertised items (NF / FA / PV) of the first day of the advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_1D_QTY							NUMBER(38,5) 																COMMENT '[Abverkauf 1T (Stk/kg)] Sold quantity (returns are considered) of advertised items (NF / FA / PV) of the first day of the advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_3D_PCT							NUMBER(38,5) 																COMMENT '[Abverkauf 3T (%)] Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_3D_PER_STORE_QTY				NUMBER(38,5) 																COMMENT '[Abverkauf / Filiale 3T (Stk/kg)] Sold quantity (returns are considered) per store of advertised items (NF / FA / PV): The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_3D_QTY							NUMBER(38,5) 																COMMENT '[Abverkauf 3T (Stk/kg)] The metric will use the number of sold items always for 3 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_7D_PCT							NUMBER(38,5) 																COMMENT '[Abverkauf 7T (%)] Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_7D_PER_STORE_QTY				NUMBER(38,5) 																COMMENT '[Abverkauf / Filiale 7T (Stk/kg)] Sold quantity (returns are considered) per store of advertised items (NF / FA / PV): The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_7D_QTY							NUMBER(38,5) 																COMMENT '[Abverkauf 7T (Stk/kg)] The metric will use the number of sold items always for 7 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_42D_PCT						NUMBER(38,5) 																COMMENT '[Abverkauf 42T (%)] Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only): The metric will use the number of sold items always for 42 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_42D_PER_STORE_QTY				NUMBER(38,0) 																COMMENT '[Abverkauf / Filiale 42T (Stk/kg)] Sold quantity (returns are considered) per store of advertised items (NF / FA / PV): The metric will use the number of sold items always for 42 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_42D_QTY						NUMBER(38,0) 																COMMENT '[Abverkauf 42T (Stk/kg)] The metric will use the number of sold items always for 42 days starting from the period start date (no matter how long the actual period is), and for NF, FA items including 5 days before the period start date.',
	TURNOVER_MARGIN_PCT						NUMBER(38,5) 																COMMENT '[Kalkulation (Basis Abverkauf) (in %)] Revenue generated (turnover minus buying price volume) with this sold action item_2 vs. Turnover in %.',
	TURNOVER_NET_PER_STORE_VAL				NUMBER(38,5) 																COMMENT '[Umsatz / Filiale] Net turnover of the advertised item_2 per store, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_VAL						NUMBER(38,5) 																COMMENT '[Umsatz] | [Umsatz Gesamt Aktionen] Net turnover of the advertised item_2, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_VAL_SHARE_PCT				NUMBER(38,5) 																COMMENT '[UA (%)] Total Turnover Share in %: Turnover of this advertised item_2 vs. the total turnover of all items (promo, non-promo) of the country_2, for the specific timeframe (advertising period / advertising week).',
	TURNOVER_PCT							NUMBER(38,5) 																COMMENT '[Abverkauf (Werbeperiode) (%)] Sold quantity (returns are considered) vs. delivered quantity in % of advertised items (NF / FA only) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_PER_STORE_QTY					NUMBER(38,5) 																COMMENT '[Abverkauf / Filiale (Werbeperiode) (Stk/kg)] Sold quantity (returns are considered) per store of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_QTY							NUMBER(38,5) 																COMMENT '[Abverkauf (Werbeperiode) (Stk/kg)] Sold quantity (returns are considered) of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_REVENUE_NET_VAL				NUMBER(38,5) 																COMMENT '[Abverkaufsertrag] Revenue generated with this sold action item. Absolute value of turnover minus buying price volume.',
	TURNOVER_REVENUE_NET_STORE_VAL			NUMBER(38,5) 																COMMENT '[Abverkaufsertrag / Filiale] Absolute revenue in local currency per store.',
	VOLUME_BUY_NET_VAL						NUMBER(38,5) 																COMMENT '[EK-Volumen Basis Abverkauf (LW)] Buying Volume based on sales_2 in local currency. Calculated as the net buying price, multiplied by the sales_2 quantity of this advertised item_2 during the period.',

--    Technical fields
	REJECT_FG								SMALLINT		NOT NULL	DEFAULT 0 										COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID						INTEGER			NOT NULL	DEFAULT -1 										COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_LDESCR							VARCHAR 							 										COMMENT 'Detailed description of the rejection reason',
	SOURCE_SYSTEM_ID						INTEGER			NOT NULL	DEFAULT 0 										COMMENT 'Manual/Static',
	DELETED_FG								SMALLINT		NOT NULL	DEFAULT 0 										COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP		 															COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID									INTEGER			NOT NULL	DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, WAREHOUSE_SID, ADV_WEEK_ID, ADV_PERIOD_ID, ACTION_TYPE_ID, ORIG_ITEM_NR, DELETED_FG)
)	COMMENT='Frontend MSTR Aggregate Table at the NAN (orig_item_nr) level aggregated on Country_2 / Region_2 (WH), AdvWeek, AdvPeriod, ActionType. Information included for UWG, WGI.'
;