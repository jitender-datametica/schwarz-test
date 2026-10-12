create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_REF_NON_PERSONALIZED_DISCOUNT_STATUS (
	NP_DISCOUNT_STATUS_CD VARCHAR(100) NOT NULL COMMENT 'Code of the non personalized discount status.',
	NP_DISCOUNT_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'Description of the non personalized discount status.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_REF_NON_PERSONALIZED_DISCOUNT_STATUS primary key (NP_DISCOUNT_STATUS_CD)
)COMMENT='This table contains the different status of a non personalized discount.'
;
