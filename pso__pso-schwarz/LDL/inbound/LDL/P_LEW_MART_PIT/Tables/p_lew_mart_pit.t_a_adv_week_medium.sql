/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_A_ADV_WEEK_MEDIUM
#-------------------------------------------------------------------------------
# Description: Create DDL for Aggregation Table on Adv.-Week and Medium  
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#
# Aggregation Levels:
# ===================
# Adv.Week,COUNTRY,Medium.Grp
# Adv.Week,WH,Medium.Grp
# Adv.Week,COUNTRY,Medium
# Adv.Week,WH,Medium
#
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz     Initial version
#  1.1  2021-08-11 Dirk Hering      Fixes, formatting
#  1.2  2021-08-27 Mike Davis       FK support
#  1.3  2022-01-24 Andreas Kurz     Reworked the structure after DM review
#  1.4	2022-06-24 Nikolai Toknov	Drop column PRICE_BUY_NET + changes NOT NULL as WA
#  1.5	2022-07-05 Nikolai Toknov	Adjusting columns types 
#  2.0  2022-09-27 Nikolai Toknov	Add A_LEVEL_ID to CLUSTER
#  2.1	2022-12-06 Nikolai Toknov	Drop column WAREHOUSE_NAME
#  2.2  2022-12-07 Nikolai Toknov	Change dafault values
#  2.3  2022-12-14 Nikolai Toknov	Add ACTION_TYPE_ID
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1  2024-11-18 Nikolai Toknov	Add PV-columns 
#-------------------------------------------------------------------------------
*/

/*
VC:
ADV_WEEK_MSTR_ID
MEDIUM_MSTR_SID
MEDIUM_GRP_MSTR_SID

*/
CREATE TABLE P_LEW_MART_PIT.T_A_ADV_WEEK_MEDIUM CLUSTER BY (CLIENT_ID, A_LEVEL_ID)(
	CLIENT_ID								INTEGER				NOT NULL	DEFAULT -1 						COMMENT 'Client ID e.g, AT:==1',
	COUNTRY_ISO_CD							VARCHAR(3) 														COMMENT 'Country ISO Code = WAWI Country ',
	COUNTRY_DESCR							VARCHAR 														COMMENT 'Country Name',
	ADV_WEEK_ID								INTEGER				NOT NULL	DEFAULT 888853 					COMMENT 'Advertising Week',
--	ADV_WEEK_MSTR_ID						INTEGER															COMMENT 'Advertising Week - Frontend Join',
	WAREHOUSE_SID							INTEGER				NOT NULL	DEFAULT -2000 					COMMENT 'Warehouse Surrogate ID L2',
	ORIG_WH_NR								INTEGER															COMMENT 'Original Wahrehouse Number  / code from Wawi',
	MEDIUM_SID								INTEGER				NOT NULL	DEFAULT -2000 					COMMENT 'Advertising Media, ',
--	MEDIUM_MSTR_SID							INTEGER															COMMENT 'Advertising Media - Frontend Join',
	MEDIUM_GRP_SID							INTEGER				NOT NULL	DEFAULT -2000 					COMMENT 'Advertising Media, ',
--	MEDIUM_GRP_MSTR_SID						INTEGER															COMMENT 'Advertising Media - Frontend Join',
	ACTION_TYPE_ID							INTEGER		 		NOT NULL	DEFAULT -1000 					COMMENT 'Action Type 1-::NP and 2::NF | 3::FA | 1 ::PV',
	A_LEVEL_ID								INTEGER				NOT NULL	DEFAULT -1 						COMMENT 'Aggregation Level of the KPI',

	ADD_RECEIPT_CNT							NUMBER(38,0) 													COMMENT 'Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_RECEIPT_PER_STORE_CNT				NUMBER(38,0)													COMMENT 'Additional number of receipts, caused by the advertised PV item per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_VAL					NUMBER(38,5) 													COMMENT 'Additional TurnOVER, caused by the advertised PV item. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_PER_STORE_VAL			NUMBER(38,5)													COMMENT 'Additional TurnOVER, caused by the advertised PV item, per store (where the PV item was sold). Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_QTY						NUMBER(38,0)													COMMENT 'Additional turnover qantity, caused by the advertised PV item. Calculated by number of soled item qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_PER_STORE_QTY				NUMBER(38,0)													COMMENT 'Additional turnover qantity, caused by the advertised PV item per store. Calculated by number of soled item qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_REVENUE_NET_VAL			NUMBER(38,5) 													COMMENT 'Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_REVENUE_NET_PER_STORE_VAL	NUMBER(38,5)													COMMENT 'Additional Revenue, caused by the advertised PV item per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADV_ITEM_CNT							NUMBER(38,0)					DEFAULT 0						COMMENT 'Number of action items that have been sold in any action_type (PV / NF / FA) during an advertising period.',
	ADV_ITEM_FA_CNT							NUMBER(38,0)					DEFAULT 0 						COMMENT 'Number of FA action items that have been sold during an advertising period.',
	ADV_ITEM_NF_CNT							NUMBER(38,0)					DEFAULT 0 						COMMENT 'Number of NF action items that have been sold during an advertising period.',
	ADV_ITEM_PV_CNT							NUMBER(38,0)					DEFAULT 0 						COMMENT 'Number of PV action items that have been sold during an advertising period.',
	ADV_ITEM_PV_LP_CNT						NUMBER(38,0)					DEFAULT 0 						COMMENT 'Number of action items that have been sold as action_type LP during an advertising period, in the region of a chosen related advertising week.',
	ADV_ITEM_PV_NPPS_CNT					NUMBER(38,0)					DEFAULT 0 						COMMENT 'Number of action items that have been sold as action_type PD during an advertising period, in the region of a chosen related advertising week.',
	ADV_ITEM_PV_WAWI_CNT					NUMBER(38,0)					DEFAULT 0 						COMMENT 'Number of action items that have been sold as action_type WAWI during an advertising period, in the region of a chosen related advertising week.',

	BASE_RECEIPT_CNT						NUMBER(38,0) 													COMMENT 'Expected/estimated number of receipts with specific item / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_NET_VAL					NUMBER(38,5) 													COMMENT 'Expected/estimated turnOVER of specific item / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_QTY						NUMBER(38,5) 													COMMENT 'Expected / estimated sold quantity of the action item within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_REVENUE_NET_VAL			NUMBER(38,5) 													COMMENT 'Expected / estimated generated revenue of the action item within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item was not in PV). Calculated only for PV items.',

	CHERRY_PICKER_RECEIPT_CNT				NUMBER(38,0)					DEFAULT 0 						COMMENT 'Number of \"cherry picker\" receipts, that contain the PV item and the net turnOVER sum of all PV items on this receipt is at least 70% of the total receipt turnOVER. Only calculated for PV items. Return receipts are ignored. Not trivially aggregable.',
	CHERRY_PICKER_RECEIPT_CNT_PCT			NUMBER(38,5)													COMMENT 'Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',


	
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


	TURNOVER_NET_VAL						NUMBER(38,5)													COMMENT 'PIT KPI-Id:54|Umsatz',
	TURNOVER_QTY							NUMBER(38,5)													COMMENT 'PIT KPI-Id:10|Abverkauf (Werbeperiode) (Stk/kg)',
	RECEIPT_CNT								NUMBER(38,0)					DEFAULT 0 						COMMENT 'PIT KPI-Id:29|Bons Aktionsartikel (Anz.) ',
	TOTAL_RECEIPT_CNT						NUMBER(38,0)					DEFAULT 0 						COMMENT 'PIT KPI-Id:32|Bons Gesamt (Anz.)',
	STORE_CNT								NUMBER(38,0)					DEFAULT 0 						COMMENT 'PIT KPI-Id:24|Anz. Filialen Abverkauf',
	TOTAL_TURNOVER_NET_VAL					NUMBER(38,5)													COMMENT 'PIT KPI-Id:60|Umsatz Gesamt WW / KW',
	RECEIPT_CNT_SHARE_PCT					NUMBER(38,5)													COMMENT 'PIT KPI-Id:28|Bon Penetration (%)',
	RECEIPT_PER_STORE_CNT					NUMBER(38,5)													COMMENT 'PIT KPI-Id:30|Bons Aktionsartikel / Filiale (Anz.) ',
	VOLUME_BUY_NET_VAL						NUMBER(38,5)													COMMENT 'PIT KPI-Id:41|EK-Volumen Basis Abverkauf (LW)',
	TURNOVER_MARGIN_PCT						NUMBER(38,5)													COMMENT 'PIT KPI-Id:17|Abverkaufs-Kalkulation (%)',
	TURNOVER_NET_PER_STORE_VAL				NUMBER(38,5)													COMMENT 'PIT KPI-Id:55|Umsatz / Filiale',
	TURNOVER_NET_VAL_SHARE_PCT				NUMBER(38,5)													COMMENT 'PIT KPI-Id:62|UA (%)',
	TURNOVER_REVENUE_NET_VAL				NUMBER(38,5)													COMMENT 'PIT KPI-Id:15|Abverkaufsertrag',
	TURNOVER_REVENUE_NET_STORE_VAL			NUMBER(38,5)													COMMENT 'Absolute revenue in local currency per store.',

	REJECT_FG								SMALLINT			NOT NULL	DEFAULT 0 						COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID						INTEGER				NOT NULL	DEFAULT -1 						COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID						INTEGER				NOT NULL	DEFAULT 0 						COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG								SMALLINT			NOT NULL	DEFAULT 0 						COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP			NOT NULL	DEFAULT CURRENT_TIMESTAMP() 	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP		 												COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID									INTEGER				NOT NULL	DEFAULT 0 						COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, ADV_WEEK_ID, WAREHOUSE_SID, MEDIUM_SID, MEDIUM_GRP_SID, DELETED_FG)
)	COMMENT='Aggregation Table on Adv.-Week and Medium'
;