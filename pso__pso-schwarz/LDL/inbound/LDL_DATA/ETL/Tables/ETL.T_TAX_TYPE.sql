CREATE TABLE ETL.T_TAX_TYPE (
	TAX_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of tax. (E.g. VAT)',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	TAX_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the kind of tax.',
	CONSTRAINT PK_T_TAX_TYPE PRIMARY KEY (TAX_TYPE_CD, LANG_CD)
);
