CREATE TABLE CORE.T_DIM_MATERIAL_DOCUMENT_SPECIAL_STOCK_TYPE (
	MATERIAL_DOC_SPECIAL_STOCK_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'A code for type of special stock such as Customer Stock, Project Stock, Stock in Transit ',
	MATERIAL_DOC_SPECIAL_STOCK_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A description for type of special stock such as Customer Stock, Project Stock, Stock in Transit ',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_MATERIAL_DOCUMENT_SPECIAL_STOCK_TYPE PRIMARY KEY (MATERIAL_DOC_SPECIAL_STOCK_TYPE_CD)
)COMMENT='The Special Stock Indicator is containing single letter codes to identify the allocation of the articles to the different stock types, such as Customer Stock, Project Stock, Stock in Transit '
;