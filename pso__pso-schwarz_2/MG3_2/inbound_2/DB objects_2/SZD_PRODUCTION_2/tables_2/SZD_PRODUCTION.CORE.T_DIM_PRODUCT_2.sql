create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_PRODUCT_2 (
	PRODUCT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the product.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	PRODUCT_STATUS_CD VARCHAR(50) NOT NULL COMMENT 'The status_2 code for the product',
	PRODUCT_DIVISION_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'Code for the type of product categorisation  ( TEX, HG )',
	IAN_NR NUMBER(38,0) NOT NULL COMMENT 'Natural Key/Business Key - The international article number (IAN) of the product.',
	PRODUCT_NAME VARCHAR(100) NOT NULL COMMENT 'Descriptive Attribute - The name of the product., cut at 100 characters if needed',
	PRODUCT_NAME_TXT VARCHAR(1000) NOT NULL COMMENT 'Descriptive Attribute - The complete name of the product from the source',
	INCOTERM_NAME VARCHAR(100) COMMENT 'Descriptive Attribute - Specific Incoterm that has been used and is also part of the contract of sale',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_DIM_PRODUCT primary key (PRODUCT_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Dimension - Contains the products on the IAN level. - Source - GS Upload, Broker Report, VMT'
;