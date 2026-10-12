CREATE TABLE CORE.T_DIM_MATERIAL_DOCUMENT_STOCK_TYPE_2 (
	MATERIAL_DOC_STOCK_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'A code for type of stock used in material documents (3, F, S, etc..)',
	MATERIAL_DOC_STOCK_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A description for type of stock used in material documents (Blocked, Quality inspection, etc)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_MATERIAL_DOCUMENT_STOCK_TYPE PRIMARY KEY (MATERIAL_DOC_STOCK_TYPE_CD)
)COMMENT='The minor dimension with information of type of stock in quality inspection, unrestricted or blocked for material movements'
;