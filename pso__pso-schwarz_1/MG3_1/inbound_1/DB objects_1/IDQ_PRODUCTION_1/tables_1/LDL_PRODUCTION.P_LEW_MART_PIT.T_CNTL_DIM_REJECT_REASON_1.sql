CREATE TABLE IF NOT EXISTS LDL_PRODUCTION.P_LEW_MART_PIT.T_CNTL_DIM_REJECT_REASON_1 (
    REJECT_REASON_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Unique Identifier of Reject Reason',
    REJECT_REASON_DESCR VARCHAR(1500) NOT NULL DEFAULT 'N/A' COMMENT 'Reject Reason Annotation further description',
    VALID_FROM_DT DATE NOT NULL DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_1-DD') COMMENT 'Technical field Data Historization Valid from ',
    VALID_TO_DT DATE NOT NULL DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_1-DD') COMMENT 'Technical field Data Historization Valid to',
    VERSION_NR NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Technical Field: Version Number of record ; Sequence starting from 0',
    CURRENT_FG NUMBER(38,0) NOT NULL DEFAULT 1 COMMENT 'Technical Field 1 indicates the current record in case of several version',
    SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Source System EJR / WAWI / Delivery',
    DELETED_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
    DWH_CREATED_TS TIMESTAMP_NTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when record was created',
    DWH_UPDATED_TS TIMESTAMP_NTZ(9) COMMENT 'Technical field timestamp when record was updated',
    LOAD_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Technical Field ELT / AB>Initio Process ID',
    constraint T_CNTL_DIM_REJECT_REASON_PK primary key (REJECT_REASON_ID, VALID_FROM_DT, DELETED_FG)
)COMMENT='Control Table - Lookup PIT Reject Reason - holding the reject reasons during the ETL Process'
;