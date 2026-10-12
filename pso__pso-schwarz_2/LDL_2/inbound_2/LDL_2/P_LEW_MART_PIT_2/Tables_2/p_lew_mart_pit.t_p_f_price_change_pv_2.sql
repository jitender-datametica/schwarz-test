/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_P_F_PRICE_CHANGE_PV_2
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate Fact Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2024-01-31 Andreas Kurz	Initial version
# 1.1 2024-11-04 Implement Name Changes on DDL
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_2; 

--DESC TABLE P_LEW_MART_PIT.T_T_P_F_PRICE_CHANGE_PV
*/

CREATE TABLE P_LEW_MART_PIT.T_P_F_PRICE_CHANGE_PV_2 CLUSTER BY (CLIENT_ID, DAY_DT )(
	CLIENT_ID							INTEGER				NOT NULL DEFAULT -1 										COMMENT 'Client ID e.g AT=1',
	DAY_DT								DATE				NOT NULL DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_2-DD')		COMMENT 'Day of Sales_2',
	STORE_SID							INTEGER				NOT NULL DEFAULT -1 										COMMENT 'Unique key Region_2 surrogate key',

	ORIG_ITEM_NR						INTEGER																			COMMENT '',
	ITEM_SID							INTEGER                                                                         COMMENT '',
	PCWO_REASON_ID						INTEGER                                                                         COMMENT '',
	PCWO_REASON_DESC					VARCHAR                                                                         COMMENT '',
	PCH_DAY_PRICEGROUP_FG				INTEGER                                                                         COMMENT '',
	DISCOUNT_VALUE_PROMODESIGNER		NUMBER(38,5)                                                                    COMMENT '',
	DISCOUNT_VALUE_LIDLPLUS				NUMBER(38,5)                                                                    COMMENT '',
	PCH_BASELINE_FG						INTEGER                                                                         COMMENT '',
							
	-- Technical fields 							
	REJECT_REASON_ID					INTEGER				NOT NULL	DEFAULT -1 										COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG							SMALLINT			NOT NULL	DEFAULT 0 										COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID					INTEGER				NOT NULL	DEFAULT 0 										COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG							SMALLINT			NOT NULL	DEFAULT 0 										COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS						TIMESTAMP			NOT NULL	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS						TIMESTAMP		 																COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID								INTEGER				NOT NULL	DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, DAY_DT, STORE_SID, ITEM_SID, DELETED_FG)
)	COMMENT='Intermediate Fact Table PC Price Change (PV)'
;