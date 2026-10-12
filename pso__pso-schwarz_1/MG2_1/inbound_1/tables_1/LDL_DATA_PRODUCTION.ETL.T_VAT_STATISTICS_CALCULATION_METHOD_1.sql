create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_VAT_STATISTICS_CALCULATION_METHOD_1 (
	VAT_STAT_CALC_METHOD_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way, how the VAT statistics have been calculated.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	VAT_STAT_CALC_METHOD_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the way, how the VAT statistics have been calculated.',
	constraint PK_T_VAT_STATISTICS_CALCULATION_METHOD primary key (VAT_STAT_CALC_METHOD_CD, LANG_CD)
);