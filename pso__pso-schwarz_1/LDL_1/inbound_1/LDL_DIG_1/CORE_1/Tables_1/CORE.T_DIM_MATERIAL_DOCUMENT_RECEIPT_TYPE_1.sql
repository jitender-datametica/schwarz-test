CREATE TABLE CORE.T_DIM_MATERIAL_DOCUMENT_RECEIPT_TYPE_1 (
	MATERIAL_DOC_RECEIPT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'A code to identify if the warehouse movement is a normal receipt, stock transport order or Tied empties.',
	MATERIAL_DOC_RECEIPT_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A description to identify if the warehouse movement is a normal receipt, stock transport order or Tied empties.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_MATERIAL_DOCUMENT_RECEIPT_TYPE PRIMARY KEY (MATERIAL_DOC_RECEIPT_TYPE_CD)
)COMMENT='The Receipt Indicator is containing single letter codes to identify if the warehouse movement is a normal receipt, stock transport order or Tied empties.'
;