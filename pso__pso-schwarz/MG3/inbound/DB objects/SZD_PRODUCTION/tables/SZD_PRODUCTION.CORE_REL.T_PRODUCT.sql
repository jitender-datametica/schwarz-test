create or replace TABLE SZD_PRODUCTION.CORE_REL.T_PRODUCT (
	PRODUCT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	SALES_VARIANT_PRODUCT_GROUP_SID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Unique idenfier (surrogate key) of the product group this product belongs to.',
	PRODUCT_STATUS_CD VARCHAR(50) NOT NULL COMMENT 'The status code for the product',
	PRODUCT_DIVISION_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'Code for the type of product categorisation  ( TEX, HG )',
	IAN_NR NUMBER(38,0) NOT NULL COMMENT 'Natural/Business Key -The business identifier of the product. Usually this is the IAN (International Article Number).',
	PRODUCT_NAME VARCHAR(100) NOT NULL COMMENT 'Descriptive Attribute -The displayable name of the product. Cut at 100 characters if needed',
	PRODUCT_NAME_TXT VARCHAR(1000) NOT NULL COMMENT 'Descriptive attribute - Complete name of the product from the source',
	INCOTERM_NAME VARCHAR(100) COMMENT 'Descriptive attribute - Specific Incoterm that has been used and is also part of the contract of sale',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_PRODUCT primary key (PRODUCT_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Entity - The term \"Product\" describes goods and services which are offered by the enterprise. In the case of a retailer these are the goods the company trades with. The term \"product\" is not limited to the current assortment of goods and services., but may also include articles of competitors or articles which are currently not in the assortment. - Source - VMT, GTS, GS-Upload'
;