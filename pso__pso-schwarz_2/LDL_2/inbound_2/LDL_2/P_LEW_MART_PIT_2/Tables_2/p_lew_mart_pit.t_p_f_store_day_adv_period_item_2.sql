/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_P_F_STORE_DAY_ADV_PERIOD_ITEM_2
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate Fact Table Delivery to WH
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#	1.0  2021-10-20 Aparna Rayanki		Initial version
#	1.1  2021-10-25 Aparna Rayanki		Removed MSTR related columns and descriptions
#	1.2  2022-01-21 Andreas Kurz		Reworked the structure
#	1.3  2022-04-24	Nikolai Toknov		Add columns REPORT_ADV_PERIOD_START_DAY_DT,REPORT_ADV_PERIOD_END_DAY_DT
#	1.4  2022-04-27 Nikolai Toknov		Rename columns: REPORT_ADV_PERIOD_ -> REPORTING_ADV_PERIOD_
#	1.5  2022-04-27 Nikolai Toknov		Add REPORTING_ADV_PERIOD_FG
#	1.6	 2022-07-06 Nikolai Toknov		Change column ADV_THEME_NATIONAL_SID,ADV_THEME_INTERNATIONAL_SID -> THEME_GID,THEME_GRP_SID 
#   1.7	 2023-03-16 Nikolai Toknov		INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#   1.8  2023-09-05 Andreas Kurz		Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#   4.0  2023-11-06 Nikolai Toknov		Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#	4.1  2024-12-21 Andreas Kurz		Removed ACTION_SUBTPYE_ID
#-------------------------------------------------------------------------------
*/

/*
VC:
ORIG_ITEM_MSTR_NR
ADV_WEEK_MSTR_ID
ADV_PERIOD_MSTR_ID
THEME_GRP_NAT_MSTR_SID
THEME_GRP_NAT_CAT_MSTR_SID
THEME_GRP_INT_MSTR_SID
REPORTING_ADV_PERIOD_FG

ALTER TABLE P_LEW_MART_PIT.T_P_F_STORE_DAY_ADV_PERIOD_ITEM_2 ADD ACTION_SUBTYPE_ID INTEGER DEFAULT -1;
UPDATE P_LEW_MART_PIT.T_P_F_STORE_DAY_ADV_PERIOD_ITEM_2
SET ACTION_SUBTYPE_ID = ACTION_TYPE_ID 
WHERE DELETED_FG = 0 AND REJECT_FG = 0
*/

CREATE TABLE P_LEW_MART_PIT.T_P_F_STORE_DAY_ADV_PERIOD_ITEM_2 CLUSTER BY (CLIENT_ID, DAY_DT)(
	CLIENT_ID								INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g, AT:==1',
			
	COUNTRY_ISO_CD							VARCHAR(3) 																COMMENT 'Country_2 ISO Code = WAWI Country_2 ',
	COUNTRY_DESCR							VARCHAR 																COMMENT 'Country_2 Name',
			
	ITEM_SID								INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Item_2 Variant (Case Size)',
	ORIG_ITEM_NR							INTEGER		 															COMMENT 'Item_2 NaN (National Artikel_2 Nummer) Link to Item_2 History',
		
	SUB_ITEM_GRP_SID						INTEGER						DEFAULT -1,
	ITEM_GRP_INT_SID						INTEGER						DEFAULT -1,

	DAY_DT									DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'Day of Sales_2',
					
	ADV_WEEK_ID								INTEGER			NOT NULL	DEFAULT 888853 								COMMENT 'Advertising Week',
	ADV_PERIOD_ID							INTEGER			NOT NULL	DEFAULT -1,

	ADV_PERIOD_START_DAY_DT					DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'Start day of Advertisement Period',
	ADV_PERIOD_END_DAY_DT					DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'End day of Advertisement Period',

	REPORTING_ADV_PERIOD_START_DAY_DT		DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
	REPORTING_ADV_PERIOD_END_DAY_DT			DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
--	REPORTING_ADV_PERIOD_FG					SMALLINT	 AS (
--												IFF((DAY_DT >= REPORTING_ADV_PERIOD_START_DAY_DT) AND (DAY_DT <= REPORTING_ADV_PERIOD_END_DAY_DT), 1, 0)
--															),

	STORE_SID								INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Unique key Region_2 surrogate key',
	STORE_NAME								VARCHAR 																COMMENT 'Store Name',
	ORIG_STORE_NR							INTEGER		 															COMMENT 'Orig Store NUMBER',
				
	WAREHOUSE_SID							INTEGER						DEFAULT -1 									COMMENT 'Warehouse Surrogate ID L2',
	WAREHOUSE_NAME							VARCHAR 																COMMENT 'Warehouse Name',
	ORIG_WH_NR								INTEGER		 															COMMENT 'Original Wahrehouse NUMBER  / code from Wawi',
																	
	THEME_GRP_NAT_SID						INTEGER		 															COMMENT 'FK to Theme Group NAT',
--	THEME_GRP_NAT_MSTR_SID					INTEGER		 															COMMENT '[VC] MSTR surrogate Key : Theme Group NAT',
											
	THEME_GRP_INT_SID						INTEGER		 															COMMENT 'FK to Theme Group INT',
--	THEME_GRP_INT_MSTR_SID					INTEGER		 															COMMENT '[VC] MSTR surrogate Key : Theme Group INT',

	THEME_GRP_NAT_CAT_SID					INTEGER		 				DEFAULT -1000								COMMENT 'FK to Theme Group NAT Category',
--	THEME_GRP_NAT_CAT_MSTR_SID				INTEGER		 															COMMENT 'MSTR surrogate Key : Theme Group NAT Category',
	

	ACTION_TYPE_ID							INTEGER						DEFAULT -1,
	
	ITEM_FA_FG								SMALLINT					DEFAULT 0,
	ITEM_NF_FG								SMALLINT					DEFAULT 0,
	ITEM_PV_FG								SMALLINT					DEFAULT 0,
	ITEM_NP_FG								SMALLINT					DEFAULT 0,
	
	-- aku debugging purposes
	ITEM_GRP_INT_NAME						VARCHAR,
	WAWI_DAT_ADV							DATE,
	ADP_CAMPAIGN_ELEM_START_DT				DATE,
	ADP_REAL_CAMPAIGN_ELEM_END_DT			DATE,
	PROMOTION_START_DT						DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
	REAL_PROMOTION_END_DT					DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
	PROMOTION_END_DT						DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
	CALC_PROMOTION_END_DT_FG				SMALLINT					DEFAULT -1,
	PRICE_ACTIVE_FROM_DT					DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
	REAL_PRICE_ACTIVE_TO_DT					DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
	PRICE_ACTIVE_TO_DT						DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
	CALC_PRICE_ACTIVE_TO_DT_FG				SMALLINT					DEFAULT -1,

    -- Technical fields	
	REJECT_REASON_ID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG								SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID						INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG								SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID									INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ITEM_SID, ADV_PERIOD_ID, DELETED_FG)
)	COMMENT='Basis Pre Fact Table on Store Day Item_2'
;