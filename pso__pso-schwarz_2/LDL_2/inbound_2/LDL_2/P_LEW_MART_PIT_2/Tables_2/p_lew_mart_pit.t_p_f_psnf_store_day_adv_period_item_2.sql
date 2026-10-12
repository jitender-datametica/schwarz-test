/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_P_F_PSNF_STORE_DAY_ADV_PERIOD_ITEM_2
#-------------------------------------------------------------------------------
# Describtion: 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#	1.0  2023-07-12 Nikolai Toknov		Initial version
#-------------------------------------------------------------------------------
*/
/*
DROP TABLE P_LEW_MART_PIT.T_P_F_PSNF_STORE_DAY_ADV_PERIOD_ITEM_2;
*/
CREATE TABLE P_LEW_MART_PIT.T_P_F_PSNF_STORE_DAY_ADV_PERIOD_ITEM_2 CLUSTER BY (CLIENT_ID, DAY_DT)(
	CLIENT_ID								INTEGER			/*NOT NULL*/	DEFAULT -1 									COMMENT 'Client ID e.g, AT:==1',
			
	COUNTRY_ISO_CD							VARCHAR(3) 																COMMENT 'Country_2 ISO Code = WAWI Country_2 ',
	COUNTRY_DESCR							VARCHAR 																COMMENT 'Country_2 Name',
			
	ITEM_SID								INTEGER			/*NOT NULL*/	DEFAULT -1 									COMMENT 'Item_2 Variant (Case Size)',
	ORIG_ITEM_NR							INTEGER		 															COMMENT 'Item_2 NaN (National Artikel_2 Nummer) Link to Item_2 History',
--	ORIG_ITEM_MSTR_NR						INTEGER		 AS (
--												(ORIG_ITEM_NR * 100) + CLIENT_ID
--															)			DEFAULT -1,
--			
--	SUB_ITEM_GRP_SID						INTEGER						DEFAULT -1,
--	ITEM_GRP_INT_SID						INTEGER						DEFAULT -1,

	DAY_DT									DATE			/*NOT NULL*/	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'Day of Sales_2',
					
	ADV_WEEK_ID								INTEGER			/*NOT NULL*/	DEFAULT 888853 								COMMENT 'Advertising Week',
--	ADV_WEEK_MSTR_ID						INTEGER			/*NOT NULL*/	DEFAULT -1,

	ADV_PERIOD_START_DAY_DT					DATE			/*NOT NULL*/	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'Start day of Advertisement Period',
	ADV_PERIOD_END_DAY_DT					DATE			/*NOT NULL*/	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'End day of Advertisement Period',

	REPORTING_ADV_PERIOD_START_DAY_DT		DATE			/*NOT NULL*/	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
	REPORTING_ADV_PERIOD_END_DAY_DT			DATE			/*NOT NULL*/	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),

--	STORE_SID								INTEGER			/*NOT NULL*/	DEFAULT -1 									COMMENT 'Unique key Region_2 surrogate key',
--	STORE_NAME								VARCHAR 																COMMENT 'Store Name',
--	ORIG_STORE_NR							INTEGER		 															COMMENT 'Orig Store NUMBER',
				

--	ACTION_TYPE_ID							INTEGER						DEFAULT -1,
--	ITEM_FA_FG								SMALLINT					DEFAULT 0,
--	ITEM_NF_FG								SMALLINT					DEFAULT 0,
--	ITEM_PV_FG								SMALLINT					DEFAULT 0,
--	ITEM_NP_FG								SMALLINT					DEFAULT 0,

	
	OVERLAP_FG								SMALLINT					DEFAULT 0 COMMENT 'If periods overlap and starts periods differ by equal or less than 7 days (set for the whole period)',
	CUT_DAY_FG								SMALLINT					DEFAULT 0 COMMENT 'Days are marked for periods whose start date difference is greater than 7 days and which have an overlap',
	-- aku debugging purposes
	CAMPAIGN_ELEM_SID 						INTEGER						DEFAULT -1,
	ADP_CAMPAIGN_ELEM_START_DT				DATE,
	ADP_REAL_CAMPAIGN_ELEM_END_DT			DATE,
--	PROMOTION_START_DT						DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
--	REAL_PROMOTION_END_DT					DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
--	PROMOTION_END_DT						DATE						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD'),
--	CALC_PROMOTION_END_DT_FG				SMALLINT					DEFAULT -1,
	REJECT_COMMENTS							VARCHAR,
    -- Technical fields	
	REJECT_REASON_ID						INTEGER			/*NOT NULL*/	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG								SMALLINT		/*NOT NULL*/	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID						INTEGER			/*NOT NULL*/	DEFAULT 0 									COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG								SMALLINT		/*NOT NULL*/	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP		/*NOT NULL*/	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID									INTEGER			/*NOT NULL*/	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID' --,
	--PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ITEM_SID, ADV_PERIOD_ID, DELETED_FG)
)	COMMENT='Basis Pre Fact Table on Store Day Item_2'
;