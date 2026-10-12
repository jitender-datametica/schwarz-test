create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_STORE_GROUP_HIST_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice.',
	NP_DISCOUNT_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key of the non personalized discount.',
	STORE_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'surrogate key that uniquely identifies a store group',
	STORE_GRP_NR VARCHAR(100) NOT NULL COMMENT 'business identifier of the StoreGroup (known to the Business)',
	DELETED_FG NUMBER(38,0) NOT NULL COMMENT 'relation was not delivered by source system (anymore), if deleted_fg=1',
	DWH_VALID_FROM DATE NOT NULL COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
	DWH_VALID_TO DATE NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_NON_PERSONALIZED_DISCOUNT_STORE_GROUP_HIST primary key (NP_DISCOUNT_SID, STORE_GRP_SID, DWH_VALID_FROM)
)COMMENT='This tables contains the Store Group for which the non-personalized promotion is valid.(historised version).'
;
