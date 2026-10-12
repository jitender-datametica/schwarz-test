create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_REF_COUPON_CONSUMPTION_TYPE_2 (
	COUPON_CONSUMPTION_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'Code for the coupon''s usage of a non-personalized discount.',
	COUPON_CONSUMPTION_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'Name for coupon''s usage of a non.personalized discount.',
	COUPON_CONSUMPTION_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'Description for coupon''s usage of a non-personalized discount.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_REF_COUPON_CONSUMPTION_TYPE primary key (COUPON_CONSUMPTION_TYPE_CD)
)COMMENT='This table contains the different coupon''s usage of a non-personalized discount.'
;
