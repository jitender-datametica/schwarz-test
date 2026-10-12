/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_A_ADV_WEEK_THEME_NAT_2
#-------------------------------------------------------------------------------
# Description: Create DDL for Aggregation Table on REGION_2 (Warehouse), Theme NAT and Adv.-Week  
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-09-06 Andreas Kurz 	Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									Initial Version 
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1  2024-11-18 Nikolai Toknov	Add PV-columns 
#-------------------------------------------------------------------------------
*/

/*
VC:
ADV_WEEK_MSTR_ID
THEME_GRP_NAT_CAT_MSTR_SID

*/
CREATE TABLE P_LEW_MART_PIT.T_A_ADV_WEEK_THEME_NAT_CAT_2 CLUSTER BY (CLIENT_ID, A_LEVEL_ID)(
	CLIENT_ID								INTEGER				NOT NULL	DEFAULT -1 						COMMENT 'Client ID e.g, AT:==1',
	COUNTRY_ISO_CD							VARCHAR(3) 														COMMENT 'Country_2 ISO Code = WAWI Country_2 ',
	COUNTRY_DESCR							VARCHAR 														COMMENT 'Country_2 Name',
	ADV_WEEK_ID								INTEGER				NOT NULL	DEFAULT 888853 					COMMENT 'Advertising Week',
--	ADV_WEEK_MSTR_ID						INTEGER															COMMENT 'Advertising Week - Frontend Join',
	WAREHOUSE_SID							INTEGER				NOT NULL	DEFAULT -2000 					COMMENT 'Warehouse Surrogate ID L2',
	ORIG_WH_NR								INTEGER															COMMENT 'Original Wahrehouse Number  / code from Wawi',
	THEME_GRP_NAT_CAT_SID						INTEGER				NOT NULL	DEFAULT -1000 					COMMENT 'FK to Theme Group INT',
--	THEME_GRP_NAT_CAT_MSTR_SID					INTEGER															COMMENT '[VC] MSTR surrogate Key : Theme Group INT',
	ACTION_TYPE_ID							INTEGER		 		NOT NULL	DEFAULT -1000 					COMMENT 'Action Type 1-::NP and 2::NF | 3::FA | 1 ::PV',
	A_LEVEL_ID								INTEGER				NOT NULL	DEFAULT -1 						COMMENT 'Aggregation Level of the KPI',

	ADD_RECEIPT_CNT							NUMBER(38,0) 													COMMENT 'Additional number of receipts, caused by the advertised PV item. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_RECEIPT_PER_STORE_CNT				NUMBER(38,0)													COMMENT 'Additional number of receipts, caused by the advertised PV item_2 per store. Calculated by number of receipts of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_VAL					NUMBER(38,5) 													COMMENT 'Additional TurnOVER, caused by the advertised PV item. Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_NET_PER_STORE_VAL			NUMBER(38,5)													COMMENT 'Additional TurnOVER, caused by the advertised PV item_2, per store (where the PV item_2 was sold). Calculated by turnOVER of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_QTY						NUMBER(38,0)													COMMENT 'Additional turnover qantity, caused by the advertised PV item. Calculated by number of soled item_2 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_PER_STORE_QTY				NUMBER(38,0)													COMMENT 'Additional turnover qantity, caused by the advertised PV item_2 per store. Calculated by number of soled item_2 qty of current week, minus ist baseline value from the last 6 weeks. Only PV.',
	ADD_TURNOVER_REVENUE_NET_VAL			NUMBER(38,5) 													COMMENT 'Additional Revenue, caused by the advertised PV item. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',
	ADD_TURNOVER_REVENUE_NET_PER_STORE_VAL	NUMBER(38,5)													COMMENT 'Additional Revenue, caused by the advertised PV item_2 per store. Calculated by revenue of the current week, minus its baseline value from the last 6 weeks. Only for PV.',

	ADV_ITEM_CNT							NUMBER(38,0)					DEFAULT 0 						COMMENT 'PIT KPI-Id:18|Aktionsartikel (Anz.)',
	ADV_ITEM_FA_CNT							NUMBER(38,0)					DEFAULT 0 						COMMENT 'PIT KPI-Id:19|Aktionsartikel FA (Anz.)',
	ADV_ITEM_NF_CNT							NUMBER(38,0)					DEFAULT 0 						COMMENT 'PIT KPI-Id:20|Aktionsartikel NF (Anz.)',
	ADV_ITEM_PV_CNT							NUMBER(38,0)					DEFAULT 0 						COMMENT 'PIT KPI-Id:21|Aktionsartikel PV (Anz.)',
	ADV_ITEM_PV_LP_CNT						NUMBER(38,0)													COMMENT 'Number of action items that have been sold as action_type LP during an advertising period, in the region_2 of a chosen related advertising week.',
	ADV_ITEM_PV_NPPS_CNT					NUMBER(38,0)													COMMENT 'Number of action items that have been sold as action_type PD_2 during an advertising period, in the region_2 of a chosen related advertising week.',
	ADV_ITEM_PV_WAWI_CNT					NUMBER(38,0)													COMMENT 'Number of action items that have been sold as action_type WAWI during an advertising period, in the region_2 of a chosen related advertising week.',
	ADV_RECEIPT_ADV_TURNOVER_NET_VAL		NUMBER(38,5)													COMMENT 'PIT KPI-Id:56|Umsatz Aktionsbons Aktionsartikel',
	ADV_RECEIPT_NP_TURNOVER_NET_VAL			NUMBER(38,5)													COMMENT 'PIT KPI-Id:22|Aktivierter NP-Umsatz',
	ADV_RECEIPT_TOTAL_TURNOVER_NET_VAL		NUMBER(38,5)													COMMENT 'PIT KPI-Id:57|Umsatz Aktionsbons Gesamt',
	BASE_RECEIPT_CNT						NUMBER(38,0) 													COMMENT 'Expected/estimated number of receipts with specific item_2 / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_NET_VAL					NUMBER(38,5) 													COMMENT 'Expected/estimated turnOVER of specific item_2 / items of a specific group within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_QTY						NUMBER(38,5) 													COMMENT 'Expected / estimated sold quantity of the action item_2 within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.',
	BASE_TURNOVER_REVENUE_NET_VAL			NUMBER(38,5) 													COMMENT 'Expected / estimated generated revenue of the action item_2 within its advertising period, from the last 6 advertising weeks (median OVER the same weekday, when this item_2 was not in PV). Calculated only for PV items.',
	CHERRY_PICKER_RECEIPT_CNT				NUMBER(38,0) 													COMMENT 'Number of \"cherry picker\" receipts, that contain the PV item_2 and the net turnOVER sum of all PV items on this receipt is at least 70% of the total receipt turnOVER. Only calculated for PV items. Return receipts are ignored. Not trivially aggregatable.',
	CHERRY_PICKER_RECEIPT_CNT_PCT			NUMBER(38,5) 													COMMENT 'Cherry Picker Quote in %: Number of Cherry Picker Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	HEAVY_BUYER_RECEIPT_CNT					NUMBER(38,0) 													COMMENT 'Number of \"heavy buyer\" receipts, which contain the advertised item_2 (any type PV / NF / FA) and whose net turnOVER sum of all advertised items (any type PV / NF / FA) on this receipt is at least 70% of the total receipts turnOVER, and the sales_2 quantity sum of all these advertised items on this receipt is at least 70% of the total receipts sales_2 quantity. Return receipts are ignored. Not trivially aggregatable.',
	HEAVY_BUYER_RECEIPT_CNT_PCT				NUMBER(38,5) 													COMMENT 'Heavy Buyer Quote in %: Number of Heavy Buyer Receipts vs. Number of Receipts having this advertised item. See other metrics as part of the formula.',
	PV_EFFIC_REVENUE_FACTOR					NUMBER(38,5)													COMMENT 'Additional Revenue vs. Additional TurnOVER as a factor, caused by the advertised PV item. Indirectly uses the baseline values for revenue, turnOVER from the last 6 weeks. Only for PV.',
	PV_EFFIC_TURNOVER_FACTOR				NUMBER(38,5)													COMMENT '(Additional TurnOVER minus Costs for the Price Reduction) vs. Costs for the Price Reduction, for the advertised PV item.',
	PV_NET_VAL								NUMBER(38,5)													COMMENT 'Absolute Advertising PV value in local currency. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.',
	PV_NET_VAL_SHARE_PCT					NUMBER(38,5)													COMMENT 'Advertising PV as percentage of absolute advertising PV vs. total turnOVER of all items (promo, non-promo).',
	PV_LP_NET_VAL							NUMBER(38,5)													COMMENT 'Absolute Advertising PV value in local currency for LP action type. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.',
	PV_LP_NET_VAL_SHARE_PCT					NUMBER(38,5)													COMMENT 'Advertising PV as percentage of absolute advertising PV LP vs. total turnOVER of all items (promo, non-promo).',
	PV_NPPS_NET_VAL							NUMBER(38,5)													COMMENT 'Absolute Advertising PV value in local currency for PD_2 action type. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.',
	PV_NPPS_NET_VAL_SHARE_PCT				NUMBER(38,5)													COMMENT 'Advertising PV as percentage of absolute advertising PV PD_2 vs. total turnOVER of all items (promo, non-promo).',
	PV_WAWI_NET_VAL							NUMBER(38,5)													COMMENT 'Absolute Advertising PV value in local currency for WAWI action type. Calculated already on store level per item_2 as (difference of the old retail price minus new retail price) multiplied by the sales_2 quantity during the advertising period / advertising week.',
	PV_WAWI_NET_VAL_SHARE_PCT				NUMBER(38,5)													COMMENT 'Advertising PV as percentage of absolute advertising PV WAWI vs. total turnOVER of all items (promo, non-promo).',
	RECEIPT_CNT								NUMBER(38,0)					DEFAULT 0 						COMMENT 'PIT KPI-Id:29|Bons Aktionsartikel (Anz.) ',
	RECEIPT_CNT_SHARE_PCT					NUMBER(38,5)													COMMENT 'PIT KPI-Id:28|Bon Penetration (%)',
	RECEIPT_PER_STORE_CNT					NUMBER(38,0)					DEFAULT 0 						COMMENT 'PIT KPI-Id:30|Bons Aktionsartikel / Filiale (Anz.) ',
	RESTBON_NP_TURNOVER_NET_VAL				NUMBER(38,5)													COMMENT 'PIT KPI-Id:50|Ø-Restbon NP',
	RESTBON_TURNOVER_NET_VAL				NUMBER(38,5)													COMMENT 'PIT KPI-Id:48|Ø-Restbon',
	RESTBON_TURNOVER_REVENUE_NET_VAL		NUMBER(38,5) 													COMMENT 'The generated revenue (turnOVER minus buying price volume) of all items (promotion, non-promotion items) of the rest of the receipts (excluding the action item_2), which contain the advertised item. For the specific timeframe (advertising period / advertising week), in local currency.',
	STORE_CNT								NUMBER(38,0)					DEFAULT 0 						COMMENT 'PIT KPI-Id:24|Anz. Filialen Abverkauf',
	TOTAL_RECEIPT_CNT						NUMBER(38,0)					DEFAULT 0 						COMMENT 'PIT KPI-Id:32|Bons Gesamt (Anz.)',
	TOTAL_TURNOVER_NET_VAL					NUMBER(38,5)													COMMENT 'PIT KPI-Id:60|Umsatz Gesamt WW / KW',
	TURNOVER_MARGIN_PCT						NUMBER(38,5)													COMMENT 'PIT KPI-Id:17|Abverkaufs-Kalkulation (%)',
	TURNOVER_NET_PER_STORE_VAL				NUMBER(38,5)													COMMENT 'PIT KPI-Id:55|Umsatz / Filiale',
	TURNOVER_NET_VAL						NUMBER(38,5)													COMMENT 'PIT KPI-Id:54|Umsatz',
	TURNOVER_NET_VAL_SHARE_PCT				NUMBER(38,5)													COMMENT 'PIT KPI-Id:62|UA (%)',
	TURNOVER_QTY							NUMBER(38,0)					DEFAULT 0 						COMMENT 'PIT KPI-Id:10|Abverkauf (Werbeperiode) (Stk/kg)',
	TURNOVER_REVENUE_NET_VAL				NUMBER(38,5)													COMMENT 'PIT KPI-Id:15|Abverkaufsertrag',
	TURNOVER_REVENUE_NET_STORE_VAL			NUMBER(38,5)													COMMENT 'Absolute revenue in local currency per store.',
	VOLUME_BUY_NET_VAL						NUMBER(38,5)													COMMENT 'PIT KPI-Id:41|EK-Volumen Basis Abverkauf (LW)',
	REJECT_FG								SMALLINT			NOT NULL	DEFAULT 0 						COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID						INTEGER				NOT NULL	DEFAULT -1 						COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID						INTEGER				NOT NULL	DEFAULT 0 						COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG								SMALLINT			NOT NULL	DEFAULT 0 						COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP			NOT NULL	DEFAULT CURRENT_TIMESTAMP() 	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP		 												COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID									INTEGER				NOT NULL	DEFAULT 0 						COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, ADV_WEEK_ID, WAREHOUSE_SID, THEME_GRP_NAT_CAT_SID, DELETED_FG)
)	COMMENT='Aggregation Table on REGION_2 (Warehouse), Theme NAT_CAT and Adv.-Week'
;