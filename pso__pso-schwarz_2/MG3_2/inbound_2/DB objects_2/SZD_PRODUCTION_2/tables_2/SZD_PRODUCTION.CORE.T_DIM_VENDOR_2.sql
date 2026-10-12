create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_VENDOR_2 (
	PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the vendor',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	VENDOR_NAME VARCHAR(100) NOT NULL COMMENT 'Natural Key/Business Key - The name of the vendor',
	SOURCE_VENDOR_NAME_ADDRESS_CITY_TXT VARCHAR(1000) NOT NULL COMMENT 'Descriptive Attribute - the name of the vendor directly from source. Source: VMT',
	EMAIL_TXT VARCHAR(1000) COMMENT 'Descriptive Attribute - Email of the company',
	STATUS_CD VARCHAR(50) NOT NULL COMMENT 'The status_2 code for the company',
	SUPPLIER_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the supplier_2',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_DIM_VENDOR primary key (PARTY_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Dimension - A company which delivers products to Lidl , combing products of several producers. - Source - VMT'
;