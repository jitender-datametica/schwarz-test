/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_F_REL_MEDIUM_STORE_DAY_ITEM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Basis Fact Relationship Table Medium Day Item
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-25 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.2  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.3  2022-03-30 Andreas Kurz		Removed some NOT NULLs
#  1.4  2022-03-31 Mike Davis		Add in some item specific information
#  1.5  2022-04-01 Andreas Kurz     Add Real Promotion Action Type FGs etc.
#  1.6  2022-04-05 Mike Davis       Set real stuff to default -1 until figure out how to do this
#  1.7  2022-04-08 Mike Davis       Minor change: reject_fg before reject_reason_id
#  1.8	2022-06-24 Nikolai Toknov	Add CLUSTER BY (CLIENT_ID, DAY_DT)
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  6.0	2024-08-11 Andreas Kurz		Added ACTION_SUBTYPE_ID
#-------------------------------------------------------------------------------
*/
/*
VC:
ADV_WEEK_MSTR_ID
ADV_PERIOD_MSTR_ID
MEDIUM_MSTR_SID
MEDIUM_GRP_MSTR_SID
ORIG_ITEM_MSTR_NR
REPORTING_ADV_PERIOD_FG

ALTER TABLE P_LEW_MART_PIT.T_F_REL_MEDIUM_STORE_DAY_ITEM ADD ACTION_SUBTYPE_ID					INTEGER 					DEFAULT -1 									COMMENT 'Type of PV (List of PV Types: Wawi PV ::= 1 | LP ::= 2 | PD ::= 3 | -1 ::= N/A | -2 ::= Total PV)'
;
CREATE TABLE P_LEW_MART_PIT.T_F_REL_MEDIUM_STORE_DAY_ITEM_BCK AS CLONE P_LEW_MART_PIT.T_F_REL_MEDIUM_STORE_DAY_ITEM;
ALTER TABLE T_F_REL_MEDIUM_STORE_DAY_ITEM RENAME COLUMN  REAL_PROMOTION_NP_FG TO REAL_NP_FG;

*/

CREATE TABLE P_LEW_MART_PIT.T_F_REL_MEDIUM_STORE_DAY_ITEM CLUSTER BY (CLIENT_ID, DAY_DT)(
	CLIENT_ID							INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g. AT==1',
			
	COUNTRY_ISO_CD						VARCHAR(3) 																COMMENT 'Country ISO Code = WAWI Country ',
	COUNTRY_DESCR						VARCHAR 																COMMENT 'Country Name',

	DAY_DT								DATE			NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Day of Sales',
	WEEK_ID								INTEGER						DEFAULT 888853 								COMMENT 'Week (based on ISO) of Sales. Added to have better join options in agg_jobs',
	MONTH_ID							INTEGER						DEFAULT 888812 								COMMENT 'Month of Sales',
	YEAR_ID								INTEGER						DEFAULT 8888 								COMMENT 'Year (based on ISO) of Sales',

	ADV_WEEK_ID							INTEGER						DEFAULT 888853 								COMMENT 'Advertising Week',
--	ADV_WEEK_MSTR_ID					INTEGER						DEFAULT -1 									COMMENT 'Advertising Week - Frontend Join',
	
	-- AKU added Adv.Week Start and 		End Date
	ADV_WEEK_START_DT					DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'End Date of Adv.-Week',
	ADV_WEEK_END_DT						DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Start Date of Adv-Week',

	ADV_PERIOD_ID						INTEGER		 															COMMENT 'Advertising Period',
--	ADV_PERIOD_MSTR_ID					INTEGER						DEFAULT -1 									COMMENT 'Advertising Period - Frontend Join',
	ADV_PERIOD_START_DAY_DT				DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Start day of Advertisment Period',
	ADV_PERIOD_END_DAY_DT				DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'End day of Advertisment Period',

	REPORTING_ADV_PERIOD_START_DAY_DT	DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD')	COMMENT 'REPORTING_ADV_PERIOD_START_DAY_DT',
	REPORTING_ADV_PERIOD_END_DAY_DT		DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'End day of Advertisement Period',
--	REPORTING_ADV_PERIOD_FG				SMALLINT	 AS (
--												IFF((DAY_DT >= REPORTING_ADV_PERIOD_START_DAY_DT) AND (DAY_DT <= REPORTING_ADV_PERIOD_END_DAY_DT), 1, 0)
--														),

	MEDIUM_SID							INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Unique system ID, sid, for the medium (simply the channel_sid).',
--	MEDIUM_MSTR_SID						INTEGER						DEFAULT -1 									COMMENT 'Medium MSTR surrogate Key',

	MEDIUM_GRP_SID						INTEGER						DEFAULT -1									COMMENT 'Unique system ID, sid, for the medium group.',
--	MEDIUM_GRP_MSTR_SID					INTEGER						DEFAULT -1,

	STORE_SID							INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Surrogate ID for Store L1 ',
	STORE_NAME							VARCHAR 																COMMENT 'Store name',
	ORIG_STORE_NR						INTEGER		 															COMMENT 'Original Store Number / code from Wawi',

	WAREHOUSE_SID						INTEGER						DEFAULT -1 									COMMENT 'Warehouse Surrogate ID L2',
	WAREHOUSE_NAME						VARCHAR 																COMMENT 'Warehouse Name',
	ORIG_WH_NR							INTEGER		 															COMMENT 'Original Wahrehouse Number  / code from Wawi',

	ITEM_SID							INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Unique system ID, sid, for the item variant that is active (may include main item sids also).',
	ORIG_ITEM_NR						INTEGER		 															COMMENT 'Item business identifier. NaN := National Article Number CORE_AC.v_item: TRYCAST(Coalesce(itm.src_orig_item_nr, itm.config_item_cd, itm.src_matnr) AS DECIMAL(18,0))',
--	ORIG_ITEM_MSTR_NR					INTEGER		 															COMMENT 'Special MSTR Join criteria to have surrogate ORIG_ITEM_NR + CLIENT_ID',
	SUB_ITEM_GRP_SID					INTEGER						DEFAULT -1 									COMMENT 'Sid for item sub group. (UWG)',
	ITEM_GRP_INT_SID					INTEGER						DEFAULT -1 									COMMENT 'Sid for item international group. (WGI)',
							
	ACTION_TYPE_ID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.',
							
	ITEM_FA_FG							SMALLINT					DEFAULT 0 									COMMENT 'Flag / indicator telling Item is FA Food Action. iff(ACTION_TYPE_ID=3,1::SMALLINT,0::SMALLINT)',
	ITEM_NF_FG							SMALLINT					DEFAULT 0 									COMMENT 'Flag / indicator telling that item is NF None-Food. iff(ACTION_TYPE_ID=2,1::SMALLINT,0::SMALLINT)',
	ITEM_PV_WAWI_FG						SMALLINT		NOT NULL	DEFAULT -1 									COMMENT 'Flag / indicator telling item WaWi-PV',
	ITEM_PV_NPPS_FG						SMALLINT		NOT NULL	DEFAULT -1 									COMMENT 'Flag / indicator telling item Promotion Designer (NPPS)',
	ITEM_PV_LP_FG						SMALLINT		NOT NULL	DEFAULT -1 									COMMENT 'Flag / indicator telling item LidlPlus (LP)',	


	ITEM_NP_FG							SMALLINT					DEFAULT 0 									COMMENT 'Flag / indicator telling item is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::SMALLINT,0::SMALLINT)',

	-- AKU added 2022-04-01 added Real Promotion Action Type FGs
	REAL_ACTION_TYPE_ID					INTEGER						DEFAULT -1 									COMMENT 'Real (TBD) Action type id is derived from WaWi Article reference data. Undefined/No Action, PV, NF, FA respectively.',
	REAL_PROMOTION_FA_FG				SMALLINT					DEFAULT -1 									COMMENT 'Real (TBD) Flag / indicator telling Item is FA Food Action. iff(ACTION_TYPE_ID=3,1::SMALLINT,0::SMALLINT)',
	REAL_PROMOTION_NF_FG				SMALLINT					DEFAULT -1 									COMMENT 'Real (TBD) Flag / indicator telling that item is NF None-Food. iff(ACTION_TYPE_ID=2,1::SMALLINT,0::SMALLINT)',
	REAL_PROMOTION_PV_LP_FG				SMALLINT	 				DEFAULT 0									COMMENT '[Real] Flag / indicator: item is PV_LP',
	REAL_PROMOTION_PV_WAWI_FG			SMALLINT	 				DEFAULT 0									COMMENT '[Real] Flag / indicator: item is PV_WAWI',
	REAL_PROMOTION_PV_NPPS_FG			SMALLINT	 				DEFAULT 0									COMMENT '[Real] Flag / indicator: item is PV_NPPS',
	REAL_NP_FG							SMALLINT					DEFAULT -1 									COMMENT 'Real (TBD) Flag / indicator telling item is available at SFO (PV)Normalsortiment. iff(ACTION_TYPE_ID=-1 or ACTION_TYPE_ID is null,1::SMALLINT,0::SMALLINT)',

	-- AKU 2022-01-27 adding cnt-fg which could be used to apply sum agg function
	CNT_FG								SMALLINT					DEFAULT 1 									COMMENT 'Artfical column, which could be used to apply an sum agg function.',

	-- Technical fields
	REJECT_FG							SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID					INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID					INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG							SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS						TIMESTAMP		NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS						TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID								INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, DAY_DT, ITEM_SID, MEDIUM_SID, STORE_SID, ACTION_TYPE_ID, DELETED_FG)
)	COMMENT='Basis Fact Relationship Table Medium Store Item Day'
;