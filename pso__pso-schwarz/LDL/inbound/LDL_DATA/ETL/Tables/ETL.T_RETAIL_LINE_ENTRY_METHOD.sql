CREATE TABLE ETL.T_RETAIL_LINE_ENTRY_METHOD (
	RETAIL_LINE_ENTRY_METHOD_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way, how a retail line is entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	RETAIL_LINE_ENTRY_METHOD_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the way, how a retail line is entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.',
	CONSTRAINT PK_T_RETAIL_LINE_ENTRY_METHOD PRIMARY KEY (RETAIL_LINE_ENTRY_METHOD_CD, LANG_CD)
);
