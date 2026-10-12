CREATE TABLE P_LEW_PROCESS.T_MARKET_RESEARCH_BUSINESS_CALENDAR (
    PERIOD_NAME VARCHAR(100) NOT NULL,
    PERIODE_JAHR VARCHAR(100) NOT NULL,
    PERIOD_TYPE_CD VARCHAR(100) NOT NULL,
    PREV_YEAR_PERIOD_NAME VARCHAR(100) NOT NULL,
    DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
    DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
    DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',  
    CONSTRAINT PK_PERIOD_DIM_BUSINESS_CALENDAR PRIMARY KEY (PERIOD_TYPE_CD, PERIOD_NAME)
)COMMENT='Load table for XSIGHT Business Calendar';
