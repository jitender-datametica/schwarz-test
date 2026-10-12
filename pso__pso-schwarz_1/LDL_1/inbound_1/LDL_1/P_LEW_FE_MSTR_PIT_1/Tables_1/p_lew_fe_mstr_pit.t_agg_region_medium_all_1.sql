/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for AGG_REGION_MEDIUM_ALL
#-------------------------------------------------------------------------------
# Description:  Create DDL for frontend MSTR Aggregate Table on Country_1 / Region_1 (WH), AdvWeek,
#               Related AdvWeek (up to 53 weeks in the past), Medium / MediumGroup.
#               Aggregation levels distinguished by Reporting Line:
#               - Advertising Medium Total
#               - Advertising Medium Group Total
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-09   Mike Davis    	Initial version
#                                  	Keeps defaults, virtuals and nullability (for reference).
#  1.1  2021-08-13   Mike Davis    	Checks, AKU-Formatting
#                                  	Defaults, virtuals and nullability removed where
#                                  	this is specified at a lower (previous) level.
#                                  	Nullability kept for PRIMARY KEY.
#  1.2	2021-09-13 Massimo Morelli 	Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was Join
#  2.2  2023-01-25 Andreas Kurz		Adding ACTION_TYPE_ID Column Default -1000 n/A
#									ACTION_TYPE_SORT_VAL
#									ACTION_TYPE_NAME
#									ACTION_TYPE_DESCR
#  3.0  2024-02-13 Prasanna Ranjan	Added new columns for PIT Increment 2 (PV)
#  4.0  2024-03-25 Nikolai Toknov	Task 530802. (Architecture) Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1  2024-09-05 Nikolai Toknov	Adjustments of comments.
#  4.2  2024-09-24 Nikolai Toknov	Add ADV_ITEM_RLTD_CNT
#  4.3  2024-09-24 Prasanna Ranjan	Adjustment Increment 2.1 (PV)
#  4.4  2025-02-10 Nikolai Toknov	Add REJECT_LDESCR
#-------------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_FE_MSTR_PIT.T_AGG_REGION_MEDIUM_ALL_1 CLUSTER BY (CLIENT_ID, ADV_WEEK_ID)(
	CLIENT_ID								INTEGER			NOT NULL	DEFAULT -1 					COMMENT 'Client id',
	COUNTRY_ISO_CD							VARCHAR(3) 												COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR							VARCHAR 												COMMENT 'Country_1 Name',
	WAREHOUSE_SID							INTEGER			NOT NULL 								COMMENT 'Warehouse Surrogate ID',
	WAREHOUSE_MSTR_SID						INTEGER		 											COMMENT 'Warehouse Surrogate ID',

	-- GID
	WAREHOUSE_GID							INTEGER		 				DEFAULT -1000				COMMENT 'Warehouse Surrogate GID - As-Was Join key for Frontend',
	WAREHOUSE_MSTR_GID 						INTEGER 												COMMENT 'Technical Field: MSTR GID',
	WAREHOUSE_NAME							VARCHAR 												COMMENT 'Warehouse Name',
	ORIG_WH_NR								INTEGER		 											COMMENT 'Original Warehouse Number  / code from Wawi',
	ADV_WEEK_ID								INTEGER			NOT NULL 								COMMENT 'Advertising week BK',
	ADV_WEEK_MSTR_ID						INTEGER		 											COMMENT 'Advertising week MSTR Key. (AdvWeek No. concatenated with 2-digit client ID)',
	NEAREST_RLTD_ADV_WEEK_FG				SMALLINT	 											COMMENT '1: Flag indicates, that the related adv week is the previous of the adv week; 0: any other related adv week',
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
	LAST_CLOSED_ADV_WEEK_FG					SMALLINT					DEFAULT 0					COMMENT 'Flag / indicator last closed Adv.Week = 1',
	MOV_ADV_WEEK_START_FROM_CURRENT			INTEGER		 											COMMENT 'Current Adv.-Week is ::0 , pervious Adv.-Week is -1 Next Adv. Week is +1',
	MAX_ADV_PERIOD_END_DT					DATE 													COMMENT 'maximum assigned Adv. Period End Date, in case of overlapping period. Needed for Reporting Information Window.',
	RLTD_ADV_WEEK_ID						INTEGER			NOT NULL 								COMMENT 'Related Adv week BK. The adv week for comparison.',
	RLTD_ADV_WEEK_MSTR_ID					INTEGER		 											COMMENT 'Related Adv week MSTR Key (AdvWeek No. concatenated with 2-digit client ID). The adv week for comparison.',
	RLTD_ADV_WEEK_SDESCR					VARCHAR 												COMMENT 'Related Adv. Week Short Description',
	RLTD_ADV_WEEK_DESCR						VARCHAR 												COMMENT 'Related Adv.Week Description',
	RLTD_ADV_WEEK_LDESCR					VARCHAR 												COMMENT 'Related Adv. Week Long Description incl. dates',
	RLTD_ADV_WEEK_START_DT					DATE 													COMMENT 'Start Date of Related Adv-Week',
	RLTD_ADV_WEEK_END_DT					DATE 													COMMENT 'End Date of Related Adv.-Week',
	REPORTING_LINE_SID						INTEGER			NOT NULL 								COMMENT 'Hierarchy_1 level number to identify the individual reporting line (row) of e.g. a precalculated summary line.',
	REPORTING_LINE_DESCR					VARCHAR 												COMMENT 'Description of the Reporting Line',
	MEDIUM_SID								INTEGER			NOT NULL 								COMMENT 'Advertising Medium SID',
	MEDIUM_MSTR_SID							INTEGER		 											COMMENT 'Advertising Medium SID (MicroStrategy Formatted)',
	MEDIUM_NAME								VARCHAR 												COMMENT '(short) medium name in local LANGUAGE',
	MEDIUM_DESCR							VARCHAR 												COMMENT '(long) medium description in local LANGUAGE (may be unavailable)',
	MEDIUM_NAME_LDESCR						VARCHAR 												COMMENT 'Concatenate medium name + medium code in local language: for debugging purposes',
	MEDIUM_INT_DESCR						VARCHAR 												COMMENT '(long) medium description in international LANGUAGE of centre (Deutsch) (may be unavailable)',
	MEDIUM_SORT_VAL							INTEGER		 											COMMENT 'internal sorting value for the medium',
	MEDIUM_IGNORE_FG						SMALLINT	 											COMMENT 'Indicator / Flag Medium Ignore (hide the row for this medium in frontend)',
	MEDIUM_GRP_SID							INTEGER		 											COMMENT 'Advertising Medium Group SID',
	MEDIUM_GRP_MSTR_SID						INTEGER		 											COMMENT 'Advertising Medium Group SID (MicroStrategy Formatted)',
	MEDIUM_GRP_NAME							VARCHAR 												COMMENT 'Medium group name.',
	MEDIUM_GRP_INT_NAME						VARCHAR 												COMMENT 'medium Group name International',
	MEDIUM_GRP_DESCR						VARCHAR 												COMMENT 'Medium group description (local). (may be unavailable)',
	MEDIUM_GRP_INT_DESCR					VARCHAR 												COMMENT 'Medium group description (international). (may be unavailable)',
	MEDIUM_GRP_SORT_VAL						INTEGER		 											COMMENT 'internal sorting value for the medium group',
	MEDIUM_GRP_LIDLPLUS_FG					SMALLINT	 											COMMENT 'Indicator / Flag Medium Grouping on Lidl Plus',
	SORT_ORDER_VAL							VARCHAR 												COMMENT 'Default sorting order for the report',

	-- AKU 2023-01-24 ACTION_TYPE_ID INTEGER
	ACTION_TYPE_ID 							INTEGER			NOT NULL DEFAULT -1000					COMMENT 'Action type id. -2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.',
	ACTION_TYPE_SORT_VAL					INTEGER		 											COMMENT 'Sort information for reporting purposes.',
	ACTION_TYPE_NAME						VARCHAR 												COMMENT '(short) name in local LANGUAGE',
	ACTION_TYPE_DESCR						VARCHAR 												COMMENT '(long)  description in local LANGUAGE (may be unavailable)',

   -- Facts /KPIs
	ADD_RECEIPT_CNT 						NUMBER(38,0) 											COMMENT '[Zusatzbons (Anz.)] Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_RECEIPT_PER_STORE_CNT 				NUMBER(38,0) 											COMMENT '[Zusatzbons / Filiale] Additional number of receipts, caused by the advertised PV item_1 per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_VAL 					NUMBER(38,5) 											COMMENT '[Zusatzumsatz] Additional Turnover, caused by the advertised PV item. Calculated by turnover of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_PER_STORE_VAL 			NUMBER(38,5) 											COMMENT '[Zusatzumsatz / Filiale] Additional Turnover, caused by the advertised PV item_1, per store (where the PV item_1 was sold). Calculated by turnover of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_QTY 						NUMBER(38,0) 											COMMENT '[Zusatzmenge (Stk/kg)] Additional turnover qantity, caused by the advertised PV item. Calculated by number of soled item_1 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_PER_STORE_QTY 				NUMBER(38,0) 											COMMENT '[Zusatzmenge / Filiale] Additional turnover qantity, caused by the advertised PV item_1 per store. Calculated by number of soled item_1 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_REVENUE_NET_VAL 			NUMBER(38,5) 											COMMENT '[Zusatzertrag] Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_REVENUE_NET_PER_STORE_VAL 	NUMBER(38,5) 											COMMENT '[Zusatzertrag / Filiale] Additional Revenue, caused by the advertised PV item_1 per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADV_ITEM_CNT 							NUMBER(38,0) 											COMMENT '[Aktionsartikel (Anz.)] Number of action items that have been sold in any action_type (PV / NF / FA) during an advertising period.',
	ADV_ITEM_FA_CNT 						NUMBER(38,0) 											COMMENT '[Aktionsartikel FA (Anz.)] Number of FA action items that have been sold during an advertising period.',
	ADV_ITEM_NF_CNT 						NUMBER(38,0) 											COMMENT '[Aktionsartikel NF (Anz.)] Number of NF action items that have been sold during an advertising period.',
	ADV_ITEM_PV_CNT 						NUMBER(38,0) 											COMMENT '[Aktionsartikel Werbe-PV Gesamt (Anz.)] Number of PV action items that have been sold during an advertising period.',
	ADV_ITEM_PV_LP_CNT 						NUMBER(38,0) 											COMMENT '[Aktionsartikel Werbe-PV Lidl Plus (Anz.)] Number of action items that have been sold as action_type LP during an advertising period, in the region_1 of a chosen related advertising week.',
	ADV_ITEM_PV_NPPS_CNT 					NUMBER(38,0) 											COMMENT '[Aktionsartikel Werbe-PV PromoDesigner (Anz.)] Number of action items that have been sold as action_type NPPS during an advertising period, in the region_1 of a chosen related advertising week.',
	ADV_ITEM_PV_WAWI_CNT 					NUMBER(38,0) 											COMMENT '[Aktionsartikel Werbe-PV (Anz.)] Number of action items that have been sold as action_type WAWI during an advertising period, in the region_1 of a chosen related advertising week.',
	ADV_ITEM_RLTD_CNT 						NUMBER(38,0) 											COMMENT '[Aktionsartikel Vergleich (Anz.)] Number of action items that have been sold in any action_type (PV / NF / FA) during related advertising period.',
	ADV_ITEM_FA_RLTD_CNT					NUMBER(38,0) 											COMMENT '[FA (Anz.)] Number of action items that have been sold in action_type FA during related advertising period.',
	ADV_ITEM_NF_RLTD_CNT					NUMBER(38,0) 											COMMENT '[NF (Anz.)] Number of action items that have been sold in action_type NF during related advertising period.',
	ADV_ITEM_PV_LP_RLTD_CNT					NUMBER(38,0) 											COMMENT '[LP-Werbe-PV (Anz.)] Number of action items that have been sold in action_type LP-Werbe-PV during related advertising period.',
	ADV_ITEM_PV_NPPS_RLTD_CNT				NUMBER(38,0) 											COMMENT '[NPPS-Werbe-PV (Anz.)] Number of action items that have been sold in action_type NPPS-Werbe-PV during related advertising period.',
	ADV_ITEM_PV_WAWI_RLTD_CNT				NUMBER(38,0) 											COMMENT '[WaWi-Werbe-PV (Anz.)] Number of action items that have been sold in action_type WaWi-Werbe-PV during related advertising period.',
	ADV_ITEM_DELTA_RLTD_CNT 				NUMBER(38,0) 											COMMENT '[Δ Artikel_1 (Anz.)  oder  Δ Aktionsartikel (Anz.)] (Delta) Number of action items that have been sold in any action_type (PV / NF / FA) during an advertising period, in the region_1 of a chosen related advertising week.',
	ADV_ITEM_FA_DELTA_RLTD_CNT				NUMBER(38,0) 											COMMENT '[Δ FA (Anz.)] (Delta) Number of action items that have been sold in any action_type FA during an advertising period, in the region_1 of a chosen related advertising week.',
	ADV_ITEM_NF_DELTA_RLTD_CNT				NUMBER(38,0) 											COMMENT '[Δ NF (Anz.)] (Delta) Number of action items that have been sold in any action_type NF during an advertising period, in the region_1 of a chosen related advertising week.',
	ADV_ITEM_PV_LP_DELTA_RLTD_CNT			NUMBER(38,0) 											COMMENT '[Δ LP-Werbe-PV (Anz.)] (Delta) Number of action items that have been sold in action_type LP-Werbe-PV (Anz.) during an advertising period, in the region_1 of a chosen related advertising week.',
	ADV_ITEM_PV_NPPS_DELTA_RLTD_CNT			NUMBER(38,0) 											COMMENT '[Δ NPPS-Werbe-PV (Anz.)] (Delta) Number of action items that have been sold in  action_type NPPS-Werbe-PV (Anz.) during an advertising period, in the region_1 of a chosen related advertising week.',
	ADV_ITEM_PV_WAWI_DELTA_RLTD_CNT			NUMBER(38,0) 											COMMENT '[Δ WaWi-Werbe-PV (Anz.)] (Delta) Number of action items that have been sold in action_type WaWi-Werbe-PV (Anz.) during an advertising period, in the region_1 of a chosen related advertising week.',
	BASE_RECEIPT_CNT 						NUMBER(38,0) 											COMMENT '[Bons Baseline (Anz.)] | [Bons Baseline Gesamt (Anz.)] Expected/estimated number of receipts with specific item_1 / items of a specific group within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_NET_VAL 					NUMBER(38,5) 											COMMENT '[Umsatz Baseline] | [Umsatz brutto Baseline] | [Umsatz Baseline Gesamt] Expected/estimated turnover of specific item_1 / items of a specific group within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_QTY 						NUMBER(38,5) 											COMMENT '[Abverkauf Baseline (Stk/kg)] Expected / estimated sold quantity of the action item_1 within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_REVENUE_NET_VAL 			NUMBER(38,5) 											COMMENT '[Abverkaufsertrag Baseline] Expected / estimated generated revenue of the action item_1 within its advertising period, from the last 6 advertising weeks (median over the same weekday, when this item_1 was not in PV). Calculated only for PV items.',
	CHERRY_PICKER_RECEIPT_CNT 				NUMBER(38,0) 											COMMENT '[Cherry Picker (Anz.)] Number of \"cherry picker\" receipts, that contain the PV item_1 and the net turnover sum of all PV items on this receipt is at least 70% of the total receipt turnover. Only calculated for PV items. Return receipts are ignored. Not trivially aggregatable.',
	CHERRY_PICKER_RECEIPT_CNT_PCT 			NUMBER(38,5) 											COMMENT '[Cherry Picker (%)] Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	PV_EFFIC_REVENUE_FACTOR 				NUMBER(38,5) 											COMMENT '[PV-Effizienz Ertrag] Additional Revenue vs. Additional Turnover as a factor, caused by the advertised PV item. Indirectly uses the baseline values for revenue, turnover from the last 6 weeks. Only for PV.',
	PV_EFFIC_TURNOVER_FACTOR 				NUMBER(38,5) 											COMMENT '[PV-Effizienz Umsatz] (Additional Turnover minus Costs for the Price Reduction) vs. Costs for the Price Reduction, for the advertised PV item.',
	PV_NET_VAL 								NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) Gesamt] Absolute Advertising PV value in local currency. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.',
	PV_NET_VAL_SHARE_PCT 					NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) Gesamt (%)] Advertising PV as percentage of absolute advertising PV vs. total turnover of all items (promo, non-promo).',
	PV_LP_NET_VAL 							NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) Lidl Plus] Absolute Advertising PV value in local currency for LP action type. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.',
	PV_LP_NET_VAL_SHARE_PCT 				NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) Lidl Plus (%)] Advertising PV as percentage of absolute advertising PV LP vs. total turnover of all items (promo, non-promo).',
	PV_NPPS_NET_VAL 						NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) PromoDesigner] Absolute Advertising PV value in local currency for NPPS action type. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.',
	PV_NPPS_NET_VAL_SHARE_PCT 				NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) PromoDesigner (%)] Advertising PV as percentage of absolute advertising PV NPPS vs. total turnover of all items (promo, non-promo).',
	PV_WAWI_NET_VAL 						NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) WaWi] Absolute Advertising PV value in local currency for WAWI action type. Calculated already on store level per item_1 as (difference of the old retail price minus new retail price) multiplied by the sales_1 quantity during the advertising period / advertising week.',
	PV_WAWI_NET_VAL_SHARE_PCT 				NUMBER(38,5) 											COMMENT '[Werbe-PV (Basis Abverkauf) WaWi (%)] Advertising PV as percentage of absolute advertising PV WAWI vs. total turnover of all items (promo, non-promo).',
											
	RECEIPT_CNT 							NUMBER(38,0) 											COMMENT '[Bons (Anz.)] Number of advertised items receipts for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_1 and possibly other items. The advertised item_1 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_1 was bought, independently of the sold quantity.',
	RECEIPT_CNT_SHARE_PCT 					NUMBER(38,5) 											COMMENT '[Bon Penetration (%)] Share of All Total Receipts in %: Share of the receipts that contain this advertised item_1, of the total number of receipts (containing promotion and / or non-promotion items), of a country_1 for the specific timeframe (advertising period / advertising week).',
	RECEIPT_DELTA_RLTD_CNT 					NUMBER(38,0) 											COMMENT '[Δ Bons (Anz.)] Absolute delta of the number of advertising receipts (which contain the advertising item_1) between the current advertising week and the related advertising week.',
	RECEIPT_DELTA_RLTD_CNT_PCT 				NUMBER(38,5) 											COMMENT '[Δ Bons (%)] Percentage delta of the number of advertising receipts (which contain the advertising item_1) between the current advertising week and the related advertising week.',
	RECEIPT_PER_STORE_CNT 					NUMBER(38,5) 											COMMENT '[Bons / Filiale (Anz.)] Number of advertised items receipts per store for the specific timeframe (advertising period / advertising week). These are receipts that contain the specific advertised item_1 and possibly other items. The advertised item_1 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_1 was bought, independently of the sold quantity.',
	RECEIPT_RLTD_CNT 						NUMBER(38,0) 											COMMENT '[Bons Vergleich (Anz.)] Number of advertised items receipts of a chosen related advertising week. These are receipts that contain the specific advertised item_1 and possibly other items. The advertised item_1 can belong to any action type (PV / NF / FA) and advertising period. Return receipts are ignored. For NF/FA items, additional 5 days prior advertising period are considered. This KPI is not additive, because different advertised items can be on the same receipt. This KPI shows, by how many customers the item_1 was bought, independently of the sold quantity.',
	STORE_CNT 								NUMBER(38,0) 											COMMENT '[Filialen (Basis Abverkauf) (Anz.)] Number of stores that sold the action item_1 in the specific timeframe (advertising period / advertising week), in the region. For NF/FA items, additional 5 days prior advertising period are considered. No trivial aggregation, because each store might have multiple different items advertised.',
	TOTAL_RECEIPT_CNT 						NUMBER(38,0) 											COMMENT '[Bons Gesamt (Anz.)] Total number of all receipts (containing promotion and / or non-promotion items) of a country_1 for the specific timeframe (advertising period / advertising week).',
	TOTAL_RECEIPT_RLTD_CNT 					NUMBER(38,0) 											COMMENT '[Bons Gesamt Vergleich (Anz.)] Total number of all receipts (containing promotion and / or non-promotion items) of a country_1 for the specific timeframe (advertising period / advertising week) of a chosen related advertising week.',
	TOTAL_TURNOVER_NET_VAL 					NUMBER(38,5) 											COMMENT '[Umsatz Gesamt] Total net turnover of all items (promotion, non-promotion items) of a country_1 for the specific timeframe (advertising period / advertising week), in local currency. Returns are ignored. Especially on advertising week level: only the 7 days of the advertising week are considered.',
	TURNOVER_MARGIN_PCT 					NUMBER(38,5) 											COMMENT '[Kalkulation (Basis Abverkauf) (in %)] Revenue generated (turnover minus buying price volume) with this sold action item_1 vs. Turnover in %.',
	TURNOVER_NET_DELTA_RLTD_VAL 			NUMBER(38,5) 											COMMENT '[Δ Umsatz] Absolute delta of the turnover of the advertising items between the current advertising week and the related advertising week.',
	TURNOVER_NET_DELTA_RLTD_VAL_PCT 		NUMBER(38,5) 											COMMENT '[Δ Umsatz (%)] Percentage delta of the turnover of the advertising items between the current advertising week and the related advertising week.',
	TURNOVER_NET_PER_STORE_VAL 				NUMBER(38,5) 											COMMENT '[Umsatz / Filiale] Net turnover of the advertised item_1 per store, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_RLTD_VAL 					NUMBER(38,5) 											COMMENT '[Umsatz Vergleich] Net turnover of the advertised item_1, for the specific timeframe (advertising period / advertising week) of the chosen related advertising week, returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_VAL 						NUMBER(38,5) 											COMMENT '[Umsatz] | [Umsatz Gesamt Aktionen] Net turnover of the advertised item_1, for the specific timeframe (advertising period / advertising week), returns are considered, in local currency. For NF/FA items, additional 5 days prior advertising period are considered.',
	TURNOVER_NET_VAL_SHARE_PCT 				NUMBER(38,5) 											COMMENT '[UA (%)] Total Turnover Share in %: Turnover of this advertised item_1 vs. the total turnover of all items (promo, non-promo) of the country_1, for the specific timeframe (advertising period / advertising week).',
	TURNOVER_QTY 							NUMBER(38,5) 											COMMENT '[Abverkauf (Werbeperiode) (Stk/kg)] Sold quantity (returns are considered) of advertised items (NF / FA / PV) during their advertising period. For NF/FA items, additioal 5 days prior advertising period are considered.',
	TURNOVER_REVENUE_NET_VAL 				NUMBER(38,5) 											COMMENT '[Abverkaufsertrag] Revenue generated with this sold action item. Absolute value of turnover minus buying price volume.',
	TURNOVER_REVENUE_NET_STORE_VAL 			NUMBER(38,5) 											COMMENT '[Abverkaufsertrag / Filiale] Absolute revenue in local currency per store.',
	VOLUME_BUY_NET_VAL 						NUMBER(38,5) 											COMMENT '[EK-Volumen Basis Abverkauf (LW)] Buying Volume based on sales_1 in local currency. Calculated as the net buying price, multiplied by the sales_1 quantity of this advertised item_1 during the period.',
	-- Technical fields
	REJECT_FG								SMALLINT		NOT NULL	DEFAULT 0 					COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID						INTEGER			NOT NULL	DEFAULT -1 					COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_LDESCR							VARCHAR 							 					COMMENT 'Detailed description of the rejection reason',
	SOURCE_SYSTEM_ID						INTEGER			NOT NULL	DEFAULT 0 					COMMENT 'Manual/Static',
	DELETED_FG								SMALLINT		NOT NULL	DEFAULT 0 					COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP		 										COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID									INTEGER			NOT NULL	DEFAULT 0 					COMMENT 'Technical Field ELT / ABInitio Process ID'
)	COMMENT='Frontend MSTR Aggregate Table on Country_1 / Region_1 (WH), AdvWeek, Related AdvWeek (up to 53 weeks in the past), Medium / MediumGroup. Aggregation levels distinguished by Reporting Line: Advertising Medium Total, Advertising Medium Group Total'
;