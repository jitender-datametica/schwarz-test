/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025 
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_REGION_THEME_ALL
#-------------------------------------------------------------------------------
# Description:  Create DDL for frontend MSTR Aggregate Table on Country / Region (WH), AdvWeek, Theme.
#               Aggregation levels distinguished by Reporting Line:
#               - Advertising Theme Total
#               - Advertising Theme Grand Total
#               - Total for items without a Theme (Kein Werbethema definiert)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-06 Massimo Morelli  Initial version
#  1.1  2021-08-16 Dirk Hering      Fixes, formatting
#  1.2	2021-09-13 Massimo Morelli 	Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.4  2022-06-02 Prasanna Ranjan	Replaced CURRENT_ADV_WEEK_FG
#  1.5  2022-07-07 Andreas Kurz		Reworked DDL - agg will be done on theme_grp (only)
#  2.0	2022-07-12 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was Join
#  2.2  2023-01-25 Andreas Kurz		Adding ACTION_TYPE_ID Column Default -1000 n/A
#									ACTION_TYPE_SORT_VAL
#									ACTION_TYPE_NAME
#									ACTION_TYPE_DESCR
#  3.0	2023-06-26 Nikolai Toknov	INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz)
#  3.1  2023-07-19 Nikolai Toknov	Change expr. for THEME_GRP_MAIN_MSTR_SID and not-null
#  3.2  2023-07-26 Nikolai Toknov	Remove NOT NULL for an improvement in the definition of REJECT_FG
#  3.3  2023-09-06 Andreas Kurz 	Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									Adding THEME_GRP_CAT and VC Columns
#  4.0  2024-02-13 Prasanna Ranjan	Added new columns for PIT Increment 2 (PV)
#  4.0  2024-03-25 Nikolai Toknov	Task 530802. (Architecture) Exclude using "virtual columns" that are not GA in database. Drop VC. 
#  4.1  2024-09-05 Nikolai Toknov	Adjustments of comments.
#  4.2  2024-09-24 Prasanna Ranjan	Adjustment Increment 2.1 (PV)
#  4.4  2025-02-10 Nikolai Toknov	Add REJECT_LDESCR
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;
*/

CREATE TABLE P_LEW_FE_MSTR_PIT.T_AGG_REGION_THEME_ALL CLUSTER BY (CLIENT_ID, ADV_WEEK_ID)(
	CLIENT_ID								INTEGER			NOT NULL 								COMMENT 'Client id',
	COUNTRY_ISO_CD							VARCHAR(3) 												COMMENT 'Country ISO Code = WAWI Country ',
	COUNTRY_DESCR							VARCHAR 												COMMENT 'Country Name',

	WAREHOUSE_SID							INTEGER			NOT NULL 								COMMENT 'Warehouse Surrogate ID',
	WAREHOUSE_MSTR_SID						INTEGER		 											COMMENT 'Warehouse Surrogate ID',
	-- GID
	WAREHOUSE_GID							INTEGER		 				DEFAULT -1000				COMMENT 'Warehouse Surrogate GID - As-Was Join key for Frontend',
	WAREHOUSE_MSTR_GID 						INTEGER 												COMMENT 'Technical Field: MSTR GID',
	WAREHOUSE_NAME							VARCHAR 												COMMENT 'Warehouse Name',
	ORIG_WH_NR								INTEGER		 											COMMENT 'Original Warehouse Number  / code from Wawi',

	ADV_WEEK_ID								INTEGER			NOT NULL 								COMMENT 'Advertising week BK',
	ADV_WEEK_MSTR_ID						INTEGER		 											COMMENT 'Advertising week MSTR Key. (AdvWeek No. concatenated with 2-digit client ID)',
	ADV_WEEK_START_DT						DATE 													COMMENT 'Start Date of Adv-Week',
	ADV_WEEK_END_DT							DATE 													COMMENT 'End Date of Adv.-Week',
	ADV_WEEK_START_DT_DESCR					VARCHAR 												COMMENT 'Start Date of the Adv. Week in German format for the frontend',
	ADV_WEEK_END_DT_DESCR					VARCHAR 												COMMENT 'End Date of the Adv. Week in German format for the frontend',
	ADV_WEEK_START_DAY_SDESCR				VARCHAR 												COMMENT 'German short description of the week day, when this adv week starts',
	ADV_WEEK_END_DAY_SDESCR					VARCHAR 												COMMENT 'German short description of the week day, when this adv week ends',
	ADV_WEEK_START_DAY_DESCR				VARCHAR 												COMMENT 'German description of the week day, when this adv week starts',
	ADV_WEEK_END_DAY_DESCR					VARCHAR 												COMMENT 'German description of the week day, when this adv week ends',
	LENGTH_OF_ADV_WEEK						SMALLINT	 											COMMENT 'Number of Days in Adv. Week',
	ADV_WEEK_YEAR_ID						INTEGER		 											COMMENT 'Year ID of the Adv.-Week. 202137 -> 2021. Needed for Reporting',
	ADV_WEEK_WEEK_NR						INTEGER		 											COMMENT 'Adv.Week Week Nbr. E.g. 202137 -> 37. Needed for Reporting',
	ADV_WEEK_SDESCR							VARCHAR 												COMMENT 'Adv. Week Short Description',
	ADV_WEEK_DESCR							VARCHAR 												COMMENT 'Adv.Week Description',
	ADV_WEEK_LDESCR							VARCHAR 												COMMENT 'Adv. Week Long Description incl. dates',
	ADV_WEEK_OVERLAP_LDESCR					VARCHAR 												COMMENT 'Adv.Week Long Description incl. dates and the maximum date of the overlapping range into the next adv week',

	PREV_1_ADV_WEEK_ID						INTEGER		 											COMMENT 'Previous 1 Adv.Week ID e.g. 202124 -> 202123',
	NEXT_1_ADV_WEEK_ID						INTEGER		 											COMMENT 'Next 1 Adv.Week ID e.g. 202124 -> 202125',
	PREV_1_YEAR_ADV_WEEK_ID					INTEGER		 											COMMENT 'Previous 1 Year Adv.Week ID e.g. 202124 -> 202024',
	LAST_ADV_WEEK_FG						SMALLINT					DEFAULT 0 					COMMENT 'Flag / indicator last Adv.Week = 1',
	LAST_CLOSED_ADV_WEEK_FG					SMALLINT					DEFAULT 0 					COMMENT 'Flag / indicator last closed Adv.Week = 1',
	MOV_ADV_WEEK_START_FROM_CURRENT			INTEGER		 											COMMENT 'Current Adv.-Week is ::0 , pervious Adv.-Week is -1 Next Adv. Week is +1',
	MAX_ADV_PERIOD_END_DT					DATE 													COMMENT 'maximum assigned Adv. Period End Date, in case of overlapping period. Needed for Reporting Information Window.',

	REPORTING_LINE_SID						INTEGER			NOT NULL 								COMMENT 'Hierarchy level number to identify the individual reporting line (row) of e.g. a precalculated summary line.',
	REPORTING_LINE_DESCR					VARCHAR 												COMMENT 'Description of the Reporting Line',

	THEME_GRP_TYPE_ID						INTEGER						DEFAULT -1 					COMMENT 'Unique ID.See COMMENTs below.',
--	FE_MSTR_RELEVANT_FG						SMALLINT					DEFAULT 0 					COMMENT 'Flag indicates if used on FE_MSTR',
	THEME_GRP_TYPE_SORT_VAL					INTEGER		 											COMMENT 'Sort information for reporting purposes.',
	THEME_GRP_TYPE_NAME						VARCHAR 												COMMENT '(short) name in local LANGUAGE',
	THEME_GRP_TYPE_DESCR					VARCHAR 												COMMENT '(long)  description in local LANGUAGE (may be unavailable)',

	THEME_GRP_INT_SID						INTEGER		 											COMMENT 'Unique system ID, sid, for the theme int group.',
	THEME_GRP_INT_MSTR_SID					INTEGER													COMMENT 'Unique system ID, sid, for the theme int group + Client_ID, as MSTR Key',
	THEME_GRP_INT_NAME						VARCHAR 												COMMENT 'Theme int group name.',
	THEME_GRP_INT_SORT_VAL					INTEGER		 											COMMENT 'internal sorting value for the int theme (ordered by Theme group Name)',

	THEME_GRP_NAT_SID						INTEGER		 											COMMENT 'Unique system ID, sid, for the theme nat group.',
	THEME_GRP_NAT_MSTR_SID					INTEGER													COMMENT 'Unique system ID, sid, for the theme nat group + Client_ID, as MSTR Key',
	THEME_GRP_NAT_NAME						VARCHAR 												COMMENT 'Theme nat group name.',
	THEME_GRP_NAT_SORT_VAL					INTEGER		 											COMMENT 'internal sorting value for the nat theme (ordered by Theme group Name)',

	THEME_GRP_NAT_CAT_SID					INTEGER		 											COMMENT 'Unique system ID, sid, for the theme nat group category.',
	THEME_GRP_NAT_CAT_MSTR_SID				INTEGER													COMMENT 'Unique system ID, sid, for the theme nat group category + Client_ID, as MSTR Key',
	THEME_GRP_NAT_CAT_NAME					VARCHAR 												COMMENT 'Theme nat group category name.',
	THEME_GRP_NAT_CAT_SORT_VAL				INTEGER		 											COMMENT 'Internal sorting value for the nat theme category (ordered by Theme group Name)',

	THEME_GRP_MAIN_MSTR_SID					INTEGER													COMMENT 'Unique system ID, sid, for the theme group + Client_ID, as MSTR Key used for Display purposes',
	THEME_GRP_MAIN_NAME						VARCHAR 												COMMENT 'Theme group name used for Display purposes.',

	SORT_ORDER_VAL							VARCHAR 												COMMENT 'Default sorting order for the report',

	ACTION_TYPE_ID 							INTEGER			NOT NULL DEFAULT -1000					COMMENT 'Action type id. -2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.',
	ACTION_TYPE_SORT_VAL					INTEGER		 											COMMENT 'Sort information for reporting purposes.',
	ACTION_TYPE_NAME						VARCHAR 												COMMENT '(short) name in local LANGUAGE',
	ACTION_TYPE_DESCR						VARCHAR 												COMMENT '(long)  description in local LANGUAGE (may be unavailable)',

	-- FAKTEN / MEASURES / KPIs
	ADD_RECEIPT_CNT 						NUMBER(38,0) 											COMMENT '[Zusatzbons (Anz.)] Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_RECEIPT_PER_STORE_CNT 				NUMBER(38,0) 											COMMENT '[Zusatzbons / Filiale] Additional number of receipts, caused by the advertised PV item per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_VAL 					NUMBER(38,5) 											COMMENT '[Zusatzumsatz] Additional Turnover, caused by the advertised PV item. Calculated by turnover of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_PER_STORE_VAL 			NUMBER(38,5) 											COMMENT '[Zusatzumsatz / Filiale] Additional Turnover, caused by the advertised PV item, per store (where the PV item was sold). Calculated by turnover of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_QTY 						NUMBER(38,0) 											COMMENT '[Zusatzmenge (Stk/kg)] Additional turnover qantity, caused by the advertised PV item. Calculated by number of soled item qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_PER_STORE_QTY 				NUMBER(38,0) 											COMMENT '[Zusatzmenge / Filiale] Additional turnover qantity, caused by the advertised PV item per store. Calculated by number of soled item qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_REVENUE_NET_VAL 			NUMBER(38,5) 											COMMENT '[Zusatzertrag] Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_REVENUE_NET_PER_STORE_VAL 	NUMBER(38,5) 											COMMENT '[Zusatzertrag / Filiale] Additional Revenue, caused by the advertised PV item per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADV_ITEM_CNT 							NUMBER(38,0) 											COMMENT '[Aktionsartikel (Anz.)] Number of action items that have been sold in any action_type (PV / NF / FA) during an advertising period.',
	ADV_ITEM_FA_CNT 						NUMBER(38,0) 											COMMENT '[Aktionsartikel FA (Anz.)] Number of FA action items that have been sold during an advertising period.',
	ADV_ITEM_NF_CNT 						NUMBER(38,0) 											COMMENT '[Aktionsartikel NF (Anz.)] Number of NF action items that have been sold during an advertising period.',
	ADV_ITEM_PV_CNT 						NUMBER(38,0) 											COMMENT '[Aktionsartikel Werbe-PV Gesamt (Anz.)] Number of PV action items that have been sold during an advertising period.',
	ADV_ITEM_PV_LP_CNT 						NUMBER(38,0) 											COMMENT '[LP-Werbe-PV (Anz.)] Number of action items that have been sold as action_type LP during an advertising period, in the region of a chosen related advertising week.',
	ADV_ITEM_PV_NPPS_CNT 					NUMBER(38,0) 											COMMENT '[NPPS-Werbe-PV (Anz.)] Number of action items that have been sold as action_type NPPS during an advertising period, in the region of a chosen related advertising week.',
	ADV_ITEM_PV_WAWI_CNT 					NUMBER(38,0) 											COMMENT '[WaWi-Werbe-PV (Anz.)] Number of action items that have been sold as action_type WAWI during an advertising period, in the region of a chosen related advertising week.',
	ADV_RECEIPT_ADV_TURNOVER_NET_VAL 		NUMBER(38,5) 											COMMENT '[Umsatz Aktionsbons Aktionsartikel] Total action net turnover (only the advertised items), of receipts that contain the specific advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.',
	ADV_RECEIPT_NP_TURNOVER_NET_VAL 		NUMBER(38,5) 											COMMENT '[Aktivierter NP-Umsatz] Normal price net turnover of receipts: Sum of the net turnover of all other non-advertised items of receipts containing the advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnover of all advertised items (including the specific advertised item) is excluded. See descriptions of the detailed formula components.',
	ADV_RECEIPT_TOTAL_TURNOVER_NET_VAL 		NUMBER(38,5) 											COMMENT '[Umsatz Aktionsbons Gesamt] Total net turnover of receipts (promotion, non-promotion items), that contain the specific advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive.',
	BASE_RECEIPT_CNT 						NUMBER(38,0) 											COMMENT '[Bons Baseline (Anz.)] | [Bons Baseline Gesamt (Anz.)] Expected/estimated number of receipts with specific item / items of a specific group within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_NET_VAL 					NUMBER(38,5) 											COMMENT '[Umsatz Baseline] | [Umsatz brutto Baseline] | [Umsatz Baseline Gesamt] Expected/estimated turnover of specific item / items of a specific group within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_QTY 						NUMBER(38,5) 											COMMENT '[Abverkauf Baseline (Stk/kg)] Expected / estimated sold quantity of the action item within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_REVENUE_NET_VAL 			NUMBER(38,5) 											COMMENT '[Abverkaufsertrag Baseline] Expected / estimated generated revenue of the action item within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item was not in PV). Calculated only for PV items.',
	CHERRY_PICKER_RECEIPT_CNT 				NUMBER(38,0) 											COMMENT '[Cherry Picker (Anz.)] Number of \"cherry picker\" receipts, that contain the PV item and the net turnover sum of all PV items on this receipt is at least 70% of the total receipt turnover. Only calculated for PV items. Return receipts are ignored. Not trivially aggregatable.',
	CHERRY_PICKER_RECEIPT_CNT_PCT 			NUMBER(38,5) 											COMMENT '[Cherry Picker (%)] Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	HEAVY_BUYER_RECEIPT_CNT 				NUMBER(38,0) 											COMMENT '[Cherry Picker (Anz.)] Number of \"heavy buyer\" receipts, which contain the advertised item (any type PV / NF / FA) and whose net turnover sum of all advertised items (any type PV / NF / FA) on this receipt is at least 70% of the total receipts turnover, and the sales quantity sum of all these advertised items on this receipt is at least 70% of the total receipts sales quantity. Return receipts are ignored. Not trivially aggregatable.',
	HEAVY_BUYER_RECEIPT_CNT_PCT 			NUMBER(38,5) 											COMMENT '[Cherry Picker (%)] Heavy Buyer Quote in %: Number of Heavy Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	PV_EFFIC_REVENUE_FACTOR 				NUMBER(38,5) 											COMMENT '[PV-Effizienz Ertrag] Additional Revenue vs. Additional Turnover as a factor, caused by the advertised PV item. Indirectly uses the baseline values for revenue, turnover from the last 6 weeks. Only for PV.',
	PV_EFFIC_TURNOVER_FACTOR 				NUMBER(38,5) 											COMMENT '[PV-Effizienz Umsatz] (Additional Turnover minus Costs for the Price Reduction) vs. Costs for the Price Reduction, for the advertised PV item.',
	PV_NET_VAL 								NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) Gesamt] Absolute Advertising PV value in local currency. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.',
	PV_NET_VAL_SHARE_PCT 					NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) Gesamt (%)] Advertising PV as percentage of absolute advertising PV vs. total turnover of all items (promo, non-promo).',
	PV_LP_NET_VAL 							NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) Lidl Plus] Absolute Advertising PV value in local currency for LP action type. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.',
	PV_LP_NET_VAL_SHARE_PCT 				NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) Lidl Plus (%)] Advertising PV as percentage of absolute advertising PV LP vs. total turnover of all items (promo, non-promo).',
	PV_NPPS_NET_VAL 						NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) PromoDesigner] Absolute Advertising PV value in local currency for NPPS action type. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.',
	PV_NPPS_NET_VAL_SHARE_PCT 				NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) PromoDesigner (%)] Advertising PV as percentage of absolute advertising PV NPPS vs. total turnover of all items (promo, non-promo).',
	PV_WAWI_NET_VAL 						NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) WaWi] Absolute Advertising PV value in local currency for WAWI action type. Calculated already on store level per item as (difference of the old retail price minus new retail price) multiplied by the sales quantity during the advertising period / advertising week.',
	PV_WAWI_NET_VAL_SHARE_PCT 				NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) WaWi (%)] Advertising PV as percentage of absolute advertising PV WAWI vs. total turnover of all items (promo, non-promo).',
	RECEIPT_CNT 							NUMBER(38,0) 											COMMENT '[Bons (Anz.)] Number of advertised items receipts for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item and possibly other items. The advertised item can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item was bought, independently of the sold quantity.',
	RECEIPT_CNT_SHARE_PCT 					NUMBER(38,5) 											COMMENT '[Bon Penetration (%)] Share of All Total Receipts in %: Share of the receipts that contain this advertised item, of the total number of receipts (containing promotion and / or non-promotion items), of a country for the specific timeframe (advertising period / advertising week).',
	RECEIPT_PER_STORE_CNT 					NUMBER(38,5) 											COMMENT '[Bons / Filiale (Anz.)] Number of advertised items receipts per store for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item and possibly other items. The advertised item can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item was bought, independently of the sold quantity.',
	RESTBON_NP_TURNOVER_NET_VAL 			NUMBER(38,5) 											COMMENT '[Ø-Restbon NP] Rest of the receipt having a normal price: Average sum of the net turnover of all other non-advertised items of receipts containing the advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnover of all advertised items (including the specific advertised item) is excluded. See descriptions of the detailed formula components.',
	RESTBON_TURNOVER_NET_VAL 				NUMBER(38,5) 											COMMENT '[Ø-Restbon] Rest of the receipt: Average sum of the net turnover of all other items (incl. other advertised items) of receipts containing the advertised item, for the specific timeframe (advertising period / advertising week), in local currency. Hence, the turnover of the advertised item is excluded. See descriptions of the detailed formula components.',
	RESTBON_TURNOVER_REVENUE_NET_VAL 		NUMBER(38,5) 											COMMENT '[Ø-Kalkulation (Basis Abverkauf) (in %)Restbon] The generated revenue (turnover minus buying price volume) of all items (promotion, non-promotion items) of the rest of the receipts (excluding the action item), which contain the advertised item. For the specific timeframe (advertising period / advertising week), in local currency.',
	STORE_CNT 								NUMBER(38,0) 											COMMENT '[Filialen (Basis Abverkauf) (Anz.)] Number of stores that sold the action item in the specific timeframe (advertising period / advertising week), in the region. For NF/FA items, additional 5 days prior advertising period are considered. No trivial aggregation, because each store might have multiple different items advertised.',
	TOTAL_RECEIPT_CNT 						NUMBER(38,0) 											COMMENT '[Bons Gesamt (Anz.)] Total number of all receipts (containing promotion and / or non-promotion items) of a country for the specific timeframe (advertising period / advertising week).',
	TOTAL_TURNOVER_NET_VAL 					NUMBER(38,5) 											COMMENT '[Umsatz Gesamt] Total net turnover of all items (promotion, non-promotion items) of a country for the specific timeframe (advertising period / advertising week), in local currency. Returns are ignored. Especially on advertising week level: only the 7 days of the advertising week are considered.',
	TURNOVER_MARGIN_PCT 					NUMBER(38,5) 											COMMENT '[Kalkulation (Basis Abverkauf) (in %)] Revenue generated (turnover minus buying price volume) with this sold action item vs. Turnover in %.',
	TURNOVER_NET_PER_STORE_VAL 				NUMBER(38,5) 											COMMENT '[Umsatz / Filiale] Net turnover of the advertised item per store, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_VAL 						NUMBER(38,5) 											COMMENT '[Umsatz] | [Umsatz Gesamt Aktionen] Net turnover of the advertised item, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_VAL_SHARE_PCT 				NUMBER(38,5) 											COMMENT '[UA (%)] Total Turnover Share in %: Turnover of this advertised item vs. the total turnover of all items (promo, non-promo) of the country, for the specific timeframe (advertising period / advertising week).',
	TURNOVER_QTY 							NUMBER(38,5) 											COMMENT '[Abverkauf (Werbeperiode) (Stk/kg)] Sold quantity (returns are considered) of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_REVENUE_NET_VAL 				NUMBER(38,5) 											COMMENT '[Abverkaufsertrag] Revenue generated with this sold action item. Absolute value of turnover minus buying price volume.',
	TURNOVER_REVENUE_NET_STORE_VAL 			NUMBER(38,5) 											COMMENT '[Abverkaufsertrag / Filiale] Absolute revenue in local currency per store.',
	VOLUME_BUY_NET_VAL 						NUMBER(38,5) 											COMMENT '[EK-Volumen Basis Abverkauf (LW)] Buying Volume based on sales in local currency. Calculated as the net buying price, multiplied by the sales quantity of this advertised item during the period.',
   -- Technical fields
	REJECT_FG								SMALLINT		NOT NULL	DEFAULT 0 					COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID						INTEGER			NOT NULL	DEFAULT -1 					COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_LDESCR							VARCHAR 							 					COMMENT 'Detailed description of the rejection reason',
	SOURCE_SYSTEM_ID						INTEGER			NOT NULL	DEFAULT 0 					COMMENT 'Manual/Static',
	DELETED_FG								SMALLINT		NOT NULL	DEFAULT 0 					COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP()	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP		 										COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID									INTEGER			NOT NULL	DEFAULT 0 					COMMENT 'Technical Field ELT / ABInitio Process ID'
)	COMMENT='Frontend MSTR Aggregate Table on Country / Region (WH), AdvWeek, Theme. Aggregation levels distinguished by Reporting Line: Advertising Theme Total, Advertising Theme Grand Total, Total for items without a Theme (Kein Werbethema definiert)'
;