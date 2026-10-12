create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_SUPPLIER_1 (
	PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the supplier_1',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	SUPPLIER_NAME VARCHAR(100) NOT NULL COMMENT 'Natural Key/Business Key - The name of the supplier_1',
	SOURCE_SUPPLIER_NAME_ADDRESS_CITY_TXT VARCHAR(1000) NOT NULL COMMENT 'Descriptive Attribute - the name of the supplier_1 directly from source. Source: VMT',
	EMAIL_TXT VARCHAR(1000) COMMENT 'Descriptive Attribute - Email of the company',
	STATUS_CD VARCHAR(50) NOT NULL COMMENT 'The status_1 code for the company',
	SUPPLIER_NR VARCHAR(50) COMMENT 'Supplier_1 identifier from buying department system',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SORT_TXT VARCHAR(1000) COMMENT 'Descriptive attribute - A simple short text used for sorting',
	constraint PK_DIM_SUPPLIER primary key (PARTY_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Dimension - A company which delivers products to Lidl. The supplier_1 is not necessarily identical with the manufacturer. It could also be a wholesaler who also sources the products from somewhere. Lidl dictates to the supplier_1 which items he needs ( for example bUTTERFLY / OWIM, Lidl Asia / OWIM). - Source - VMT'
;