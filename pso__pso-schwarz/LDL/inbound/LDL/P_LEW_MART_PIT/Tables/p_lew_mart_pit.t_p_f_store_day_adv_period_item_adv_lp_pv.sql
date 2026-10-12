/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_P_F_STORE_DAY_ADV_PERIOD_ITEM_ADV_LP_PV
#-------------------------------------------------------------------------------
# Describtion: Create DDL for periods
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-11-05 Nikolai Toknov		Initial version
#  1.1  2024-11-07 Nikolai Toknov		Drop cilumns REPORTING_ADV_PERIOD_FG, DISCOUNT_VALUE
#  1.2  2024-11-14 Nikolai Toknov		Add SUB_ITEM_GRP_SID,SUB_ITEM_GRP_SRC_CD,ITEM_GRP_INT_SID,SUB_ITEM_GRP_INT_DESCR,ITEM_GRP_INT_SRC_CD,ITEM_GRP_INT_DESCR,ITEM_NAME,COUNTRY_ISO_CD,COUNTRY_DESCR
#  1.3  2024-11-14 Nikolai Toknov		Rename column ADV_PERIOD_END/START_DT to ADV_PERIOD_END/START_DAY_DT
#  1.4  2024-12-22 Nikolai Toknov		Rename ADV_LENGTH_OF_PERIOD -> ADV_PERIOD_LENGTH_IN_DAYS
#-------------------------------------------------------------------------------
*/

/*
DROP TABLE P_LEW_MART_PIT.T_P_F_STORE_DAY_ADV_PERIOD_ITEM_ADV_LP_PV
ALTER TABLE T_P_F_STORE_DAY_ADV_PERIOD_ITEM_ADV_LP_PV ADD 
	ADV_WEEK_ID 							INTEGER 													COMMENT '',
	ADV_PERIOD_ID 						INTEGER 		 												COMMENT '';
UPDATE 	T_P_F_STORE_DAY_ADV_PERIOD_ITEM_ADV_LP_PV
set ADV_WEEK_ID=ADV_WEEK_PV_ID,
	ADV_PERIOD_ID=ADV_PERIOD_PV_ID;

	
*/
CREATE TABLE P_LEW_MART_PIT.T_P_F_STORE_DAY_ADV_PERIOD_ITEM_ADV_LP_PV CLUSTER BY (CLIENT_ID, DAY_DT)(
	CLIENT_ID 								INTEGER 		NOT NULL 	DEFAULT -1 									COMMENT 'Client ID e.g, AT:==1',
	COUNTRY_ISO_CD							VARCHAR(3) 																COMMENT 'Country ISO Code = WAWI Country ',
	COUNTRY_DESCR							VARCHAR 																COMMENT 'Country Name',
	DAY_DT 									DATE 			NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Day of Sales',
	STORE_SID 								INTEGER 		NOT NULL 												COMMENT 'Unique key Region surrogate key',
	STORE_NAME 								VARCHAR 																COMMENT 'Store Name',
	ORIG_STORE_NR 							INTEGER 																COMMENT 'Orig Store NUMBER',
	WAREHOUSE_SID 							INTEGER 																COMMENT 'Warehouse Surrogate ID L2',
	WAREHOUSE_NAME 							VARCHAR 																COMMENT 'Warehouse Name',
	ORIG_WH_NR 								INTEGER 																COMMENT 'Original Wahrehouse Number  / code from Wawi',
	ADV_WEEK_ID 							INTEGER 		NOT NULL 												COMMENT 'Advertising Week',
	ADV_PERIOD_ID 							INTEGER 		NOT NULL 												COMMENT 'Advertising Period',
	ADV_PERIOD_START_DAY_DT 				DATE 						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Start DATE of the Adv.Period',
	ADV_PERIOD_END_DAY_DT 					DATE 						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'End DATE of the Adv.Period',
	ADV_PERIOD_LENGTH_IN_DAYS				INTEGER 																COMMENT 'Length Advertisement Period in Days',
	REPORTING_ADV_PERIOD_START_DAY_DT 		DATE 			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Start day of Advertisement Period',
	REPORTING_ADV_PERIOD_END_DAY_DT 		DATE 			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'End day of Advertisement Period',
--	REPORTING_ADV_PERIOD_FG 				INTEGER 					DEFAULT 1                                  	COMMENT 'Indicator [0,1] If day between periods start / end then 1',
--	PCH_PERIOD_START_DT 					DATE 						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Start day of PriceChange Period',
--	PCH_PERIOD_END_DT 						DATE 						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'End day of PriceChange Period',                                       
--	PCH_LENGTH_OF_PERIOD 					INTEGER 																COMMENT 'Length PriceChange Period in Days',
	ITEM_SID 								INTEGER 		NOT NULL	 											COMMENT 'Item Variant (Case Size)',
	ORIG_ITEM_NR 							INTEGER 																COMMENT 'Item NaN (National Artikel Nummer) Link to Item History',

	SUB_ITEM_GRP_SID						INTEGER						DEFAULT -1 									COMMENT 'Additional Link to UWG Default values in case of missing UWGs',
	SUB_ITEM_GRP_SRC_CD						VARCHAR																	COMMENT 'UWG Src CD',
	ITEM_GRP_INT_SID						INTEGER						DEFAULT -1 									COMMENT 'Sid for item international group. (WGI)',
	SUB_ITEM_GRP_INT_DESCR					VARCHAR																	COMMENT 'Item sub group description (international).',
	ITEM_GRP_INT_SRC_CD						VARCHAR                                                                 COMMENT 'Code for international group from source system.',
	ITEM_GRP_INT_DESCR						VARCHAR                                                                 COMMENT 'International group description (local).',
	ITEM_NAME								VARCHAR                                                                 COMMENT '(short) item name in local LANGUAGE',


--	PCH_DAY_PRICEGROUP_FG					SMALLINT  																COMMENT 'PV Tag Preisschienen',
	DISCOUNT_VALUE 							NUMBER(38,5)  															COMMENT 'Absolute value of discount',
--	PCH_BASELINE_FG 						SMALLINT																COMMENT 'Flag fuer Berechnung der Baseline (Tage mit signifikanter PV werden fuer Baselines dann ausgeschlossen)',
	ACTION_TYPE_ID 							INTEGER 		NOT NULL												COMMENT 'Action Type 1-::NP and 2::NF | 3::FA | 11 ::WaWi-Werbe-PV | 12::LP-Werbe-PV | 13::NPPS',
	THEME_GRP_NAT_SID 						INTEGER 		NOT NULL 	DEFAULT -1 									COMMENT 'FK to Theme Group NAT',
	THEME_GRP_INT_SID 						INTEGER 		NOT NULL 	DEFAULT -1 									COMMENT 'FK to Theme Group INT',
	THEME_GRP_NAT_CAT_SID 					INTEGER 		NOT NULL 	DEFAULT -1 									COMMENT 'FK to Theme Group NAT Category',
    -- Technical fields	
	REJECT_REASON_ID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG								SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID						INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG								SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID									INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	
	PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ITEM_SID, ADV_WEEK_ID, ADV_PERIOD_ID, ACTION_TYPE_ID)
)	COMMENT='Basis Pre Fact Table on Store Day Item PV (WAWI_PV, LP and NPPS)'
;