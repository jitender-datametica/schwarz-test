/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_PP_PERIOD_ITEM_ADV_WAWI_PV_2
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Per-Intermediate Fact Table dectection of WAWI-PV Periods
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#	1.0  2024-10-30 Andreas Kurz		Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE            R_LDL_D_PIT_ETL;
USE WAREHOUSE       WH_LDL_D_PIT_ETL_S;
USE DATABASE 		LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA          P_LEW_MART_PIT_2;
*/

CREATE TABLE P_LEW_MART_PIT.T_PP_PERIOD_ITEM_ADV_WAWI_PV_2 CLUSTER BY (CLIENT_ID, ADV_WEEK_ID)(
	CLIENT_ID								INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g, AT:==1',
	ITEM_SID								INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Item_2 Variant (Case Size)',
					
	ADV_WEEK_ID								INTEGER			NOT NULL	DEFAULT 888853 								COMMENT 'Advertising Week, derived from the PC_START_DT and StartofAdvWeek Day of Client Settings',

	PCH_MIN_START_DT						DATE 			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD')	COMMENT 'Minimum Start Tage Ebene Filiale PC',
	PCH_MAX_END_DT							DATE 			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD')	COMMENT 'Maximum End Tage Ebene Filiale PC',
	PCH_LENGTH_OF_PERIOD					NUMBER(38,0)															COMMENT 'Länge der Periode auf Ebene Filiale',

	PV_PERIOD_LENGTH_MAX_FG					SMALLINT		NOT NULL	DEFAULT -1									COMMENT 'Indicator[0|1] 1::=if the detected PC-Period is > Param @[PV_PERIOD_LENGTH_MAX], otherwise 0',

    -- Technical fields	
	REJECT_REASON_ID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG								SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID						INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG								SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID									INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, ITEM_SID, ADV_WEEK_ID, PCH_MIN_START_DT, DELETED_FG)
)	COMMENT='PreIntermediate Table used for the WaWi-PV Period Detection Algorithm. Step 3. Periods detected on Client / Item_2 Level with Min/max logic'
;