/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_DIM_DQ_RULE
#-------------------------------------------------------------------------------
# Description: Create DDL for Control Dimension table for DQ (Data Quality) Rules
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-16 Dirk Hering     Fixes, formatting
#  1.2  2021-08-23 Mike Davis      Checks, formatting, FK support (removed)
#                                  ***Note***: there is a problem with the FK for
#                                  A_LEVEL_ID since this is generated using
#                                  IDENTITY(1, 1) in the corresponding cntl_dim
#                                  so there is no -1 value
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  2.1  2024-04-15 Nikolai Toknov  Fix issue DDLvsGIT
#-------------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_PIT.T_CNTL_DIM_DQ_RULE (
	/* Rules should be given an explicit ID in this static table (not IDENTITY),
    to keep it static for frontend DQ reporting, for later referencing, not changing when inserting new rules. */
	DQ_RULE_ID				INTEGER			NOT NULL 												COMMENT 'Autoincrement Identifier (-1,1)',
	DQ_RULE_DESCR			VARCHAR(500) 															COMMENT 'Rule Description (Extended)',
	DQ_RULE_FE_DESCR		VARCHAR(50) 															COMMENT 'Rule Description (short for Reporting Display)',
--	DQ_SEVERITY_LEVEL_ID	INTEGER		,
--	DQ_SEVERITY_LEVEL_DESCR	VARCHAR,

	-- Aggregation Level    
	A_LEVEL_ID				INTEGER			NOT NULL 	DEFAULT -1 									COMMENT 'Aggregation Level Identifier',
	
	-- Versioning
	VALID_FROM_DT			DATE			NOT NULL 	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM-DD') COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT				DATE			NOT NULL 	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM-DD') COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR				INTEGER			NOT NULL 	DEFAULT 0 									COMMENT 'Technical Field: Version			NUMBER of record ; Sequence starting from 0',
	CURRENT_FG				SMALLINT		NOT NULL 	DEFAULT 1 									COMMENT 'Technical Field 1 indicates the current record in case of several version',
	
	-- Technical fields     
	REJECT_FG				SMALLINT		NOT NULL 	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID		INTEGER			NOT NULL 	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID		INTEGER			NOT NULL 	DEFAULT 0 									COMMENT 'Source System EJR / WAWI / Delivery',
	DELETED_FG				SMALLINT		NOT NULL 	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS			TIMESTAMP		NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS			TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID					INTEGER			NOT NULL 	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (DQ_RULE_ID, VALID_FROM_DT, DELETED_FG)
)	COMMENT='Control Dimension table for DQ (Data Quality) Rules'
;