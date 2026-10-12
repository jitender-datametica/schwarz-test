CREATE TABLE CORE.T_DIM_CURRENCY_EXCHANGE_RATE_TYPE_2 (
	CURR_EXCHANGE_RATE_TYPE_CD VARCHAR(5) NOT NULL COMMENT 'The code identifying the way in which one currency can be converted into another.',
	CURR_EXCHANGE_RATE_TYPE_DESCR VARCHAR(100) NOT NULL COMMENT 'A textual description for the way in which one currency can be converted into another expressed in group language, i.e. in German.',
	IS_GENERAL_USED_FG BOOLEAN COMMENT 'If exchange rate is used in daily reportimg',
	IS_LIDL_HEADOFFICE_USED_FG BOOLEAN COMMENT 'If exchange rate is used in the report to lidl headquater',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
    DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_CURRENCY_EXCHANGE_RAT PRIMARY KEY(CURR_EXCHANGE_RATE_TYPE_CD)
)COMMENT='This minor dimension defines the the ways in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...'
;