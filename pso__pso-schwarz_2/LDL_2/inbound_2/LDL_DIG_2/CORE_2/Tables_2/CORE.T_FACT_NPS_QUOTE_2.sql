CREATE TABLE CORE.T_FACT_NPS_QUOTE_2 (
	WSHOP_CD VARCHAR(5) NOT NULL COMMENT 'The unique code for the Lidl webshop',
	CAL_DT DATE NOT NULL COMMENT 'Report date',
	PERSON_CNT_VAL NUMBER(38,5) COMMENT 'The number of persons that filled the survey',
	POSITIVE_CNT_VAL NUMBER(38,5) COMMENT 'The count of  positive surveys',
	NEGATIVE_CNT_VAL NUMBER(38,5) COMMENT 'The count of  negative surveys',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_FACT_NPS_QUOTE PRIMARY KEY (WSHOP_CD, CAL_DT)
);