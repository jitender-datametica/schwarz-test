CREATE TABLE ETL.T_WAWI_PRECORE_T931_VAT_CONVERT_1 (
    CTRCODE VARCHAR(2) NOT NULL COLLATE 'en-ci',
    C931_STORENR NUMBER(38,10) NOT NULL,
    C931_VATCODE_WAWI NUMBER(38,10) NOT NULL,
    C931_VATCODE_CONVERTED NUMBER(38,10) NOT NULL,
    C931_COUNTRYCODE VARCHAR(3) NOT NULL,
    C931_MODDATE TIMESTAMP_NTZ(9),
    C931_MODUSER VARCHAR(8),
    C931_TYPE NUMBER(5,0) NOT NULL,
    SCN NUMBER(38,0) DEFAULT 0,
    EXTRACTION_TMSP TIMESTAMP_NTZ(9),
    DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
    DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
    DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
    DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
);