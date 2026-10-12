CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_cntl_dll_result_tmp_1 (
sf_schema STRING(16777216) NOT NULL OPTIONS(description='SF Schema'),
name_schema STRING(16777216) NOT NULL OPTIONS(description='Concat schema + . + objectname'),
table_type STRING(16777216) NOT NULL OPTIONS(description='SF object Table, View, Sequence, Procedure, Function'),
sf_name STRING(16777216) OPTIONS(description='SF Object Name'),
sql_getddl STRING(16777216) OPTIONS(description='GETDDL SQL Stmt.'),
sql_describe STRING(16777216) OPTIONS(description='Describe SQL Stmt.'),
sql_drop STRING(16777216) OPTIONS(description='Drop SQL Stmt.'),
recnbr STRING(16777216) OPTIONS(description='Row Count if available '),
owner STRING(16777216) OPTIONS(description='Owner Role of SF object'),
description STRING(16777216) OPTIONS(description='Further Description ::= Comment on object if available'),
annotation STRING(16777216)
OPTIONS(description='Annotation of object with further details extracted from information schema'),
created_ts STRING(16777216) OPTIONS(description='Cretaed TS of object'),
sql_result STRING(16777216) OPTIONS(description='Result of the GET DDL SQL Execution'),
reject_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Logical Deleted Flag; indicates if the record was logically deleted'),
deleted_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / AB>Initio Process ID'),
PRIMARY KEY (sf_schema, name_schema, table_type, deleted_fg) NOT ENFORCED
) OPTIONS(description='Temporary Result Table to secure the DDLs (backup into table)');