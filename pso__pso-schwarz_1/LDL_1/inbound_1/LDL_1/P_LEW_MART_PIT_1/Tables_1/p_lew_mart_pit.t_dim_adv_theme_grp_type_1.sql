/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_DIM_ADV_THEME_GRP_TYPE_1
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Action Type Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0	2023-06-26 Nikolai Toknov	INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#-------------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP_TYPE_1 (
	THEME_GRP_TYPE_ID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Unique ID.See COMMENTs below.',
	FE_MSTR_RELEVANT_FG		SMALLINT					DEFAULT 0 									COMMENT 'Flag indicates if used on FE_MSTR',
	THEME_GRP_TYPE_SORT_VAL	INTEGER		 															COMMENT 'Sort information for reporting purposes.',
	THEME_GRP_TYPE_NAME		VARCHAR 																COMMENT '(short) name in local LANGUAGE',
	THEME_GRP_TYPE_DESCR	VARCHAR 																COMMENT '(long)  description in local LANGUAGE (may be unavailable)',
	-- Versioning
	VALID_FROM_DT			DATE			NOT NULL	DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_1-DD') COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT				DATE			NOT NULL	DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_1-DD') COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR				INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field: Version NUMBER of record ; Sequence starting from 0',
	CURRENT_FG				SMALLINT		NOT NULL	DEFAULT 1 									COMMENT 'Technical Field 1 indicates the current record in case of several version',
	-- Technical fields (note: no source_system_id)                                                  
	REJECT_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	DELETED_FG				SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS			TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID					INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (THEME_GRP_TYPE_ID, VALID_FROM_DT, DELETED_FG)
)	COMMENT='Lookup table Action Type IDs'
;
