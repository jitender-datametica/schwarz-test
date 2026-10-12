/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_DIM_SOURCE_SYSTEM_1
#-------------------------------------------------------------------------------
# Description: Create DDL for Source System Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-16 Dirk Hering     Fixes, formatting
#  1.2  2021-08-23 Mike Davis      Checks, formatting, FK support (now removed)
#-------------------------------------------------------------------------------
*/
/*
---------------------------------------------------------------------
0. Create DIM Table in T_CNTL_DIM_SOURCE_SYSTEM_1
------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_MART_PIT.T_CNTL_DIM_SOURCE_SYSTEM_1 (
	SOURCE_SYSTEM_ID 		INTEGER		 		NOT NULL 		DEFAULT -1 											COMMENT 'Unique Identifier of SOURCE System',
	SOURCE_SYSTEM_NAME 		VARCHAR 			NOT NULL 		DEFAULT 'N/A' 										COMMENT 'Source System Name',
	SOURCE_SYSTEM_DESCR 	VARCHAR 			NOT NULL 		DEFAULT 'N/A' 										COMMENT 'Source System Annotation further Description',
	VALID_FROM_DT 			DATE 				NOT NULL 		DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_1-DD') 		COMMENT 'Technical field Data Historization Valid from ',
	VALID_TO_DT 			DATE 				NOT NULL 		DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_1-DD') 		COMMENT 'Technical field Data Historization Valid to',
	VERSION_NR 				INTEGER		 		NOT NULL 		DEFAULT 0 											COMMENT 'Technical Field: Version Number of record ; Sequence starting from 0',
	CURRENT_FG 				SMALLINT	 		NOT NULL 		DEFAULT 1 											COMMENT 'Technical Field 1 indicates the current record in case of several version',
	REJECT_FG 				SMALLINT	 		NOT NULL 		DEFAULT 0 											COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID 		INTEGER		 		NOT NULL 		DEFAULT -1 											COMMENT 'Link to DQ Reject Reason Codes',
	DELETED_FG 				SMALLINT	 		NOT NULL 		DEFAULT 0 											COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS 			TIMESTAMP		 	NOT NULL 		DEFAULT CURRENT_TIMESTAMP() 						COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS 			TIMESTAMP		 																		COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID 				INTEGER		 		NOT NULL 		DEFAULT 0 											COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (SOURCE_SYSTEM_ID, VALID_FROM_DT, DELETED_FG)
)COMMENT='Control Table - Lookup PIT Source System'
;