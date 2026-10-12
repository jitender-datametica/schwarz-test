CREATE TABLE CORE.T_DIM_BRICK_CODE_VALUE (
	VALUE_CD VARCHAR(50) NOT NULL COMMENT 'Code that identifies the brickcode attribute value',
	VALUE_DESCR VARCHAR(250) COMMENT 'Name of the brickcode attribute value - Possible example: Male',
	IS_CUSTOM_FG BOOLEAN COMMENT 'This flag shows if a brick_attribute and relative brick_attribute_value are custom (defined internally) or if they are derived from the GPC convention (defined externally).',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_BRICK_CODE_VALUE PRIMARY KEY (VALUE_CD)
)COMMENT='This minor dimension defines the list of additional attributes applicable to brickcode categories'
;