CREATE TABLE CORE.T_DIM_ORDER_ITEM_CATEGORY_1 (
	ORDER_ITEM_CATEGORY_CD VARCHAR(5) NOT NULL COMMENT 'The code to uniquely identify the order item_1 categories',
	ORDER_ITEM_CATEGORY_DESCR VARCHAR(250) NOT NULL COMMENT 'The description for the categorization of sales_1 and delivery order items',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_ORDER_ITEM_CATEGORY PRIMARY KEY (ORDER_ITEM_CATEGORY_CD)
)COMMENT='This minor dimension defines categorization of sales_1 order and delivery order items'
;