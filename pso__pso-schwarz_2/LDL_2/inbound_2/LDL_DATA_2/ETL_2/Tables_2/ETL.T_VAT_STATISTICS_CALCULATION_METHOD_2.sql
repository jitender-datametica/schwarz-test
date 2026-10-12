CREATE TABLE ETL.T_VAT_STATISTICS_CALCULATION_METHOD_2 (
	VAT_STAT_CALC_METHOD_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way, how the VAT statistics have been calculated.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	VAT_STAT_CALC_METHOD_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the way, how the VAT statistics have been calculated.',
	CONSTRAINT PK_T_VAT_STATISTICS_CALCULATION_METHOD PRIMARY KEY (VAT_STAT_CALC_METHOD_CD, LANG_CD)
);
