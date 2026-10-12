CREATE TABLE FE_MSTR_BCBI.TS_WAWI_MANUAL_EXTRACTION (
    CLIENT_ID NUMBER(38,0)				NOT NULL COMMENT 'Client-ID indicating country.',
	SYSTEM_KEY NUMBER(38,0)				NOT NULL COMMENT 'System key indicating source system.',
	WH_ID NUMBER(38,0)					NOT NULL COMMENT 'ID indicating warehouse.',
	DAYEND_DATE DATE					NOT NULL COMMENT 'Date indicating "dayend".',
	ENTRY_FROM VARCHAR(255)				NOT NULL COLLATE 'en-ci' COMMENT 'Text indicating creator of entry.',
	REASON VARCHAR(255)					NOT NULL COLLATE 'en-ci' COMMENT 'Text indicating reason for manual extraction.',
	EXTRACTED_FG NUMBER(38,0)			NOT NULL COMMENT 'Flag indicating if extraction has been processed.',
	CREATE_TIMESTAMP TIMESTAMP_NTZ(9)	NOT NULL COMMENT 'Timestamp when entry was created.',
	EXTRACT_TIMESTAMP TIMESTAMP_NTZ(9)  COMMENT 'Timestamp when extraction was triggered.'
);