/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ACTION_TYPE
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Action Type Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-20 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_PIT.T_DIM_ACTION_TYPE (
	ACTION_TYPE_ID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Unique ID.See COMMENTs below.',
	FE_MSTR_RELEVANT_FG		SMALLINT					DEFAULT 0 									COMMENT 'Flag indicates if used on FE_MSTR',
	ACTION_TYPE_SORT_VAL	INTEGER		 															COMMENT 'Sort information for reporting purposes.',
	ACTION_TYPE_NAME		VARCHAR 																COMMENT '(short) name in local LANGUAGE',
	ACTION_TYPE_DESCR		VARCHAR 																COMMENT '(long)  description in local LANGUAGE (may be unavailable)',
	-- Versioning
	VALID_FROM_DT			DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM-DD') COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT				DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM-DD') COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR				INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field: Version NUMBER of record ; Sequence starting from 0',
	CURRENT_FG				SMALLINT		NOT NULL	DEFAULT 1 									COMMENT 'Technical Field 1 indicates the current record in case of several version',
	-- Technical fields (note: no source_system_id)                                                  
	REJECT_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	DELETED_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS			TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID					INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (ACTION_TYPE_ID, VALID_FROM_DT, DELETED_FG)
)	COMMENT='Lookup table Action Type IDs'
;
