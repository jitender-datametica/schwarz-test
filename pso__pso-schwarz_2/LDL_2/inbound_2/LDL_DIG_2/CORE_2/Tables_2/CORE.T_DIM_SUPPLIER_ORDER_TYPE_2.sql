CREATE TABLE CORE.T_DIM_SUPPLIER_ORDER_TYPE_2 (
	SUPPLIER_ORDER_TYPE_CD VARCHAR(5) NOT NULL COMMENT 'The unique code for the purchase order document  ',
	SUPPLIER_ORDER_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'The textual description for  the purchase order document   in group language',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_SUPPLIER_ORDER_TYPE PRIMARY KEY (SUPPLIER_ORDER_TYPE_CD)
)COMMENT='This minor dimension defines the document type of the purchase order document  (Standard Order, Replenishment Order, Promotion Order)'
;