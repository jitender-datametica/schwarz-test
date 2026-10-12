CREATE TABLE CORE.T_REL_PRODUCT_VARIANT_BRICK_ATTRIBUTE_VALUE (
	PROD_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	ATTR_CD VARCHAR(50) NOT NULL COMMENT 'The code of the brickcode attribute. ',
	ATTR_DESCR VARCHAR(250) COMMENT 'Name of the brickcode attribute. Eg: Target Gender',
	VALUE_CD VARCHAR(50) NOT NULL COMMENT 'Code that identifies the brickcode attribute value',
	VALUE_DESCR VARCHAR(250) COMMENT 'Name of the brickcode attribute value - Possible example: Male',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
	PROD_BRICK_CD                       VARCHAR(40)     COMMENT 'The Brickcode is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. ',
	PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
	CONSTRAINT PK_T_REL_PRODUCT_VARIANT_BRICK_ATTRIBUTE_VALUE PRIMARY KEY (PROD_VARIANT_SID, DWH_VALID_FROM_TMSP, ATTR_CD, VALUE_CD)
)COMMENT='This minor dimension defines the list of additional attributes applicable directly to product variant'
;