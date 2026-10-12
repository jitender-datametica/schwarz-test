create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_HIST_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice',
	NP_DISCOUNT_SID NUMBER(38,0) NOT NULL COMMENT 'Foreign Key for t_non_personalized_discount_1',
	NP_DISCOUNT_STATUS_CD VARCHAR(100) NOT NULL COMMENT 'Status_1 of the non personalized discount.',
	NP_DISCOUNT_START_DT DATE NOT NULL COMMENT 'Start date of the non personalized discount.',
	NP_DISCOUNT_END_DT DATE NOT NULL COMMENT 'End date of the non personalized discount.',
	NP_DISCOUNT_BOOKING_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'Price change reason (analogous to ERP price change reasons) to be used for the discount.',
	NP_DISCOUNT_DESCR VARCHAR(250) NOT NULL COMMENT 'Description of the non personalized discount.',
	RECEIPT_NP_DISCOUNT_NAME VARCHAR(100) NOT NULL COMMENT 'Name to be displayed in the discount line on the receipt.',
	PREV_NP_DISCOUNT_SID NUMBER(38,0) COMMENT 'Surrogate Key of the predecessor of a non personalized discount.',
	DELETED_FG NUMBER(38,0) NOT NULL COMMENT 'relation was not delivered by source system (anymore), if deleted_fg=1',
	DWH_VALID_FROM DATE NOT NULL COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
	DWH_VALID_TO DATE NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_NON_PERSONALIZED_DISCOUNT_HIST primary key (NP_DISCOUNT_SID, DWH_VALID_FROM)
)COMMENT='This table contains the non personalised discount (historised version).'
;
