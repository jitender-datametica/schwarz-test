create or replace TABLE LDL_DIG_PRODUCTION.CORE.T_DIM_SUPPLIER_2 (
	SUPPLIER_SID NUMBER(38,0) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'The unique identifier (surrogate key) for supplier_2',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'An indicator showing the current record in history.',
	SUPPLIER_NR VARCHAR(20) WITH MASKING POLICY #unknown_policy COMMENT 'Account_2 number of supplier_2/vendor from the sorce system',
	SUPPLIER_NAME VARCHAR(100) WITH MASKING POLICY #unknown_policy COMMENT 'Company name of the supplier_2/vendor.',
	ADDR_SID NUMBER(38,0) WITH MASKING POLICY #unknown_policy COMMENT 'Address_2 associated with the supplier_2 account.',
	ORIG_COUNTRY_CD VARCHAR(5) WITH MASKING POLICY #unknown_policy COMMENT 'Country_2 where the supplier_2 account_2 is based.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'The point in time when this record was extracted from the source.',
	SRC_TABLE_NAME VARCHAR(100) WITH MASKING POLICY #unknown_policy COMMENT 'The name of the source table',
	SUPPLIER_FULL_NAME VARCHAR(100) WITH MASKING POLICY #unknown_policy COMMENT 'Full company name of the supplier_2/vendor.',
	ZIP_CD VARCHAR(100) WITH MASKING POLICY #unknown_policy COMMENT 'A zip code of the address_2 associated with the supplier_2',
	CITY_NAME VARCHAR(100) WITH MASKING POLICY #unknown_policy COMMENT 'City name of the address_2 associated with the supplier_2',
	STREET_NAME VARCHAR(100) WITH MASKING POLICY #unknown_policy COMMENT 'The name of a street in the address_2 associated with the supplier_2',
	SUPPLIER_SRC_INSERT_DT DATE WITH MASKING POLICY #unknown_policy COMMENT 'Date when the supplier_2 was added to the ERP system.',
	constraint PK_T_DIM_SUPPLIER primary key (SUPPLIER_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Supplier_2 ( lieferant )'
;