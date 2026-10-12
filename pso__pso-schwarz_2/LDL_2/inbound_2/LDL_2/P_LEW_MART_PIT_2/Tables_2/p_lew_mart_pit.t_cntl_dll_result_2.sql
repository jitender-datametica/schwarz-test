/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDLs for T_CNTL_DLL_RESULT_TMP_2 structures.
#-------------------------------------------------------------------------------
# Description: 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-11-06 Andreas Kurz    	Initial version
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_PIT.T_CNTL_DLL_RESULT_2 (
	SF_SCHEMA			VARCHAR		NOT NULL 										COMMENT 'SF Schema',
	NAME_SCHEMA			VARCHAR		NOT NULL 										COMMENT 'Concat schema + . + objectname',
	TABLE_TYPE			VARCHAR		NOT NULL 										COMMENT 'SF object Table, View, Sequence, Procedure, Function',
	SF_NAME				VARCHAR 													COMMENT 'SF Object Name',

	SQL_GETDDL			VARCHAR 													COMMENT 'GETDDL SQL Stmt.',
	SQL_DESCRIBE		VARCHAR 													COMMENT 'Describe SQL Stmt.',
	SQL_DROP			VARCHAR 													COMMENT 'Drop SQL Stmt.',

	RECNBR				VARCHAR 													COMMENT 'Row Count if available ',

	OWNER				VARCHAR 													COMMENT 'Owner Role of SF object',

	DESCRIPTION			VARCHAR 													COMMENT 'Further Description ::= COMMENT on object if available',
	ANNOTATION			VARCHAR 													COMMENT 'Annotation of object with further details extracted from information schema',
	CREATED_TS			VARCHAR 													COMMENT 'Cretaed TS of object',

	SQL_RESULT			VARCHAR 													COMMENT 'Result of the GET DDL SQL Execution',
	
	-- Technical fields
	REJECT_FG			SMALLINT		NOT NULL 	DEFAULT 0 						COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID	INTEGER			NOT NULL 	DEFAULT -1 						COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID	INTEGER			NOT NULL 	DEFAULT 0 						COMMENT 'Technical Field: Logical Deleted Flag; indicates if the record was logically deleted',
	DELETED_FG			SMALLINT		NOT NULL 	DEFAULT 0 						COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS		TIMESTAMP		NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 	COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS		TIMESTAMP		 											COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID				INTEGER			NOT NULL 	DEFAULT 0 						COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (SF_SCHEMA, NAME_SCHEMA, TABLE_TYPE, DELETED_FG)
)	COMMENT='Temporary Result TABLE P_LEW_MART_PIT.To secure the DDLs (backup into table)'
;