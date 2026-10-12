/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_LOADING
#-------------------------------------------------------------------------------
# Describtion: Create DDL for T_CNTL_LOADING 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#	1.0		2023-08-21 Nikolai Toknov		Initial version
#-------------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_MART_PIT.T_CNTL_EXPORT_LOADING CLUSTER BY (CLIENT_ID)(
	PROJECT_NAME						VARCHAR 																			COMMENT 'Name of the project',
	SCHEMA_NAME							VARCHAR 																			COMMENT 'Name of the schema in database',
	TABLE_NAME							VARCHAR 																			COMMENT 'Name of the table in database',
	CLIENT_ID							INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Client ID e.g, AT:==1',
	DAY_DT_MIN							DATE																				COMMENT 'Minimum reload date',
	DAY_DT_MAX							DATE																				COMMENT 'Maximum reload date',
	-- Technical fields
	REJECT_REASON_ID					INTEGER			NOT NULL	DEFAULT -1 												COMMENT 'Link to DQ Reject Reason Codes',
	REJECT_FG							SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	SOURCE_SYSTEM_ID					INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG							SMALLINT		NOT NULL	DEFAULT 0 												COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS						TIMESTAMP		NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 							COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS						TIMESTAMP		 																	COMMENT 'Technical field timestamp when record was updated',
--	EXTRACTION_TS 						TIMESTAMP																			COMMENT 'Technical field timestamp when data was exported',
	LOAD_ID								INTEGER			NOT NULL	DEFAULT 0 												COMMENT 'Technical Field ELT / ABInitio Process ID'
)	COMMENT='Information about promotional periods in stores'
;