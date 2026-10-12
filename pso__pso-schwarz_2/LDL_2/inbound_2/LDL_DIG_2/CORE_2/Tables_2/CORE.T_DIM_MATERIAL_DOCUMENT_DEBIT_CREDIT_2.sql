CREATE TABLE CORE.T_DIM_MATERIAL_DOCUMENT_DEBIT_CREDIT_2 (
	MATERIAL_DOC_DEBIT_CREDIT_CD VARCHAR(20) NOT NULL COMMENT 'A code for material goods debit credit indicator',
	MATERIAL_DOC_DEBIT_CREDIT_DESCR VARCHAR(250) NOT NULL COMMENT 'A description for material goods debit credit indicator',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_MATERIAL_DOCUMENT_DEBIT_CREDIT PRIMARY KEY (MATERIAL_DOC_DEBIT_CREDIT_CD)
)COMMENT='The minor dimension to store values of indicator of goods issue (''H'') or goods receipt (''S'') for material movements'
;