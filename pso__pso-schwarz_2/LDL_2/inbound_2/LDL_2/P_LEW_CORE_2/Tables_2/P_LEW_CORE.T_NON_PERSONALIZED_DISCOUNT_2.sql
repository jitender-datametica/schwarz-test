create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice.',
	NP_DISCOUNT_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key of the non personalized discount.',
	LOCAL_NP_DISCOUNT_NR VARCHAR(100) NOT NULL COMMENT 'Unique identifier of  a non personalized discount within the country_2/ tenant.',
	NP_DISCOUNT_NR NUMBER(38,0) NOT NULL COMMENT 'Global unique identifier of  a non personalized discount.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_NON_PERSONALIZED_DISCOUNT primary key (NP_DISCOUNT_SID)
)COMMENT='Non-personalized discount, excluding Lidl Plus.'
;
