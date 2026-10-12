CREATE TABLE CORE.T_DIM_MATERIAL_DOCUMENT_CONSUMPTION_TYPE (
	MATERIAL_DOC_CONSUM_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'A code to identify if the goods movement is a consumtion, no consumtion, asset, sales order etc.',
	MATERIAL_DOC_COMSUM_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A description to identify if the goods movement is a consumtion, no consumtion, asset, sales order etc.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_MATERIAL_DOCUMENT_CONSUMPTION_TYPE PRIMARY KEY (MATERIAL_DOC_CONSUM_TYPE_CD)
)COMMENT='The Consumption Posting is containing single letter codes to identify if the goods movement is a consumtion, no consumtion, asset, sales order etc.'
;