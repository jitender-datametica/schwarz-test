CREATE TABLE P_LEW_MART_PIT_ONPREM.T_CNTL_DLL_RESULT_TMP_2 (
	SF_SCHEMA VARCHAR(16777216) NOT NULL COMMENT 'SF Schema',
	NAME_SCHEMA VARCHAR(16777216) NOT NULL COMMENT 'Concat schema + . + objectname',
	TABLE_TYPE VARCHAR(16777216) NOT NULL COMMENT 'SF object Table, View, Sequence, Procedure, Function',
	SF_NAME VARCHAR(16777216) COMMENT 'SF Object Name',
	SQL_GETDDL VARCHAR(16777216) COMMENT 'GETDDL SQL Stmt.',
	SQL_DESCRIBE VARCHAR(16777216) COMMENT 'Describe SQL Stmt.',
	SQL_DROP VARCHAR(16777216) COMMENT 'Drop SQL Stmt.',
	RECNBR VARCHAR(16777216) COMMENT 'Row Count if available ',
	OWNER VARCHAR(16777216) COMMENT 'Owner Role of SF object',
	DESCRIPTION VARCHAR(16777216) COMMENT 'Further Description ::= Comment on object if available',
	ANNOTATION VARCHAR(16777216) COMMENT 'Annotation of object with further details extracted from information schema',
	CREATED_TS VARCHAR(16777216) COMMENT 'Cretaed TS of object',
	SQL_RESULT VARCHAR(16777216) COMMENT 'Result of the GET DDL SQL Execution',
	REJECT_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Technical Field: Logical Deleted Flag; indicates if the record was logically deleted',
	DELETED_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS TIMESTAMP_NTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS TIMESTAMP_NTZ(9) COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Technical Field ELT / AB>Initio Process ID',
	PRIMARY KEY (SF_SCHEMA, NAME_SCHEMA, TABLE_TYPE, DELETED_FG)
)COMMENT='Temporary Result Table to secure the DDLs (backup into table)'
;