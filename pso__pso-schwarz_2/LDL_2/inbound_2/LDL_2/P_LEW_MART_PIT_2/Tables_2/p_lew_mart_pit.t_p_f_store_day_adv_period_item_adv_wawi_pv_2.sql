/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_P_F_STORE_DAY_ADV_PERIOD_ITEM_ADV_WAWI_PV_2
#-------------------------------------------------------------------------------
# Describtion: Create DDL for periods
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-08-05 Andreas Kurz		Initial version
#  1.1  2024-11-14 Andreas Kurz		Rework Structrue based on Technisches Concept 
#									S2T_Mapping_Increment_2.1_20241028
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_2XL;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_2;	
*/

CREATE TABLE P_LEW_MART_PIT.T_P_F_STORE_DAY_ADV_PERIOD_ITEM_ADV_WAWI_PV_2 CLUSTER BY (CLIENT_ID, DAY_DT)(
	CLIENT_ID 								INTEGER 		NOT NULL 	DEFAULT -1 									COMMENT 'Client ID e.g, AT:==1',
	COUNTRY_ISO_CD							VARCHAR(3) 																COMMENT 'Country_2 ISO Code = WAWI Country_2 ',
	COUNTRY_DESCR							VARCHAR 																COMMENT 'Country_2 Name',
	DAY_DT 									DATE 			NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'Day of Sales_2',
	STORE_SID 								INTEGER 		NOT NULL 												COMMENT 'Unique key Region_2 surrogate key',
	STORE_NAME 								VARCHAR 																COMMENT 'Store Name',
	ORIG_STORE_NR 							INTEGER 																COMMENT 'Orig Store NUMBER',
	WAREHOUSE_SID 							INTEGER 																COMMENT 'Warehouse Surrogate ID L2',
	WAREHOUSE_NAME 							VARCHAR 																COMMENT 'Warehouse Name',
	ORIG_WH_NR 								INTEGER 																COMMENT 'Original Wahrehouse Number  / code from Wawi',
	ADV_WEEK_ID 							INTEGER 		NOT NULL 												COMMENT 'Advertising Week',


	ADV_PERIOD_ID 							INTEGER 		NOT NULL 												COMMENT 'WaWi-Werbe-PV Period on Country_2 Level. Advertising Period. Min/Max Rule applied. Long Period Spliiting Applied',
	ADV_PERIOD_START_DAY_DT 				DATE 						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'WaWi-Werbe-PV Period on Country_2 Level. Start DATE of the Adv.Period. Min/Max Rule applied. Long Period Spliiting Applied',
	ADV_PERIOD_END_DAY_DT 					DATE 						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'WaWi-Werbe-PV Period on Country_2 Level. End DATE of the Adv.Period. Min/Max Rule applied. Long Period Spliiting Applied',
	ADV_LENGTH_OF_PERIOD					INTEGER 																COMMENT 'WaWi-Werbe-PV Period on Country_2 Level. Length Advertisement Period in Days. Min/Max Rule applied. Long Period Spliiting Applied',

	REPORTING_ADV_PERIOD_START_DAY_DT 		DATE 			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'Start day of Advertisement Period',
	REPORTING_ADV_PERIOD_END_DAY_DT 		DATE 			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'End day of Advertisement Period',
	REPORTING_ADV_PERIOD_FG 				INTEGER 					DEFAULT 1                                  	COMMENT 'Indicator [0,1] If day between periods start / end then 1',
	
	PCH_PERIOD_START_DT 					DATE 						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'WaWi-Werbe-PV Period on Store Level. Start day of PriceChange Period, GAP Parameter Applied',
	PCH_PERIOD_END_DT 						DATE 						DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD') COMMENT 'WaWi-Werbe-PV Period on Store Level. End day of PriceChange Period, GAP Parameter Applied',                                       
	PCH_LENGTH_OF_PERIOD 					INTEGER 																COMMENT 'WaWi-Werbe-PV Period on Store Level. Length PriceChange Period in Days, GAP Parameter Applied',

	SPLIITTED_WAWI_PV_PERIOD_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Indicator if a WaWi-Werbe-PV Period was splitted due to an longer Period',
	
	ITEM_SID 								INTEGER 		NOT NULL	 											COMMENT 'Item_2 Variant (Case Size)',
	ORIG_ITEM_NR 							INTEGER 																COMMENT 'Item_2 NaN (National Artikel_2 Nummer) Link to Item_2 History',

	SUB_ITEM_GRP_SID						NUMBER(38,0)				DEFAULT	-1									COMMENT 'Additional Link to UWG Default values in case of missing UWGs',
	SUB_ITEM_GRP_SRC_CD						VARCHAR																	COMMENT 'UWG Src CD',
	ITEM_GRP_INT_SID						NUMBER(38,0)				DEFAULT -1									COMMENT 'Sid for item_2 international group. (WGI)',
	SUB_ITEM_GRP_INT_DESCR					VARCHAR																	COMMENT 'Item_2 sub group description (international).',
	ITEM_GRP_INT_SRC_CD						VARCHAR																	COMMENT 'Code for international group from source system.',
	ITEM_GRP_INT_DESCR						VARCHAR																	COMMENT 'International group description (local).',
	ITEM_NAME								VARCHAR																	COMMENT '(short) item_2 name in local LANGUAGE',

	--PCH_DAY_PRICEGROUP_FG					SMALLINT  																COMMENT 'PV Tag_2 Preisschienen',
	--PCH_BASELINE_FG 						SMALLINT																COMMENT 'Flag fuer Berechnung der Baseline (Tage mit signifikanter PV werden fuer Baselines dann ausgeschlossen)',

	ACTION_TYPE_ID 							INTEGER 		NOT NULL												COMMENT 'Action-Type_ID set to WaWi-Werbe-PV. Action Type 1-::NP and 2::NF | 3::FA | 11 ::WaWi-Werbe-PV | 12::LP-Werbe-PV | 13::NPPS',
	
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
	
	PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ITEM_SID, ADV_PERIOD_ID, DELETED_FG)
)	COMMENT='Basis Pre Fact Table on Store Day Item_2 and WaWi-Werbe_PV Periods (Store and Country_2) Level (WaWi-Werbe-PV)'
;