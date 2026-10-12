create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_REF_NON_PERSONALIZED_DISCOUNT_BOOKING_TYPE_1 (
	NP_DISCOUNT_BOOKING_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'Code for the price change reason of  the non personalized discount.',
	NP_DISCOUNT_BOOKING_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'Name for the price change reason of the non personalized discount.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_REF_NON_PERSONALIZED_DISCOUNT_BOOKING_TYPE primary key (NP_DISCOUNT_BOOKING_TYPE_ID)
)COMMENT='This table contains the different booking type of a non personalized discount.'
;
