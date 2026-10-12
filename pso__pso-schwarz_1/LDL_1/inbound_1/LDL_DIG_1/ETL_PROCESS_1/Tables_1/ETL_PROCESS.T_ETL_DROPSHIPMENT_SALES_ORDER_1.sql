CREATE TABLE ETL_PROCESS.T_ETL_DROPSHIPMENT_SALES_ORDER_1 (
	SUPPLIER_ORDER_NR VARCHAR(20) NOT NULL COMMENT 'Supplier_1 Account_1 Number present in the Purchase Order',
	SUPPLIER_ORDER_POS_NR NUMBER(38,0) NOT NULL COMMENT 'Product position number on purchase order',
	CUST_ORDER_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for customer order',
	CUST_ORDER_NR VARCHAR(20) COMMENT 'The original order number of the source system',
	CUST_ORDER_POS_NR NUMBER(38,0) COMMENT 'The particular position number of an item_1 in an order',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_ETL_DROPSHIPMENT_SALES_ORDER PRIMARY KEY (SUPPLIER_ORDER_NR, SUPPLIER_ORDER_POS_NR)
)COMMENT='The etl support table containing the dropshipment sales_1 order details'
;