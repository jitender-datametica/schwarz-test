create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_REF_RECEIPT_CALCULATION_METHOD (
	RECEIPT_CALC_METHOD_CD VARCHAR(100) NOT NULL COMMENT 'Code of receipt calculation method for a non personalized discount.',
	RECEIPT_CALC_METHOD_NAME VARCHAR(100) NOT NULL COMMENT 'Name of receipt calculation method for a non personalized discount.',
	RECEIPT_CALC_METHOD_DESCR VARCHAR(250) NOT NULL COMMENT 'Description of receipt calculation method for a non personalized discount.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_REF_RECEIPT_CALCULATION_METHOD primary key (RECEIPT_CALC_METHOD_CD)
)COMMENT='This table contains the different receipt calculation methodof a non personalized discount.'
;
