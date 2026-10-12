create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_FACT_DEPOSIT_REJECT_PER_DAY_1 (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	REJECT_DT DATE NOT NULL COMMENT 'The date when the deposit item_1 was rejected.',
	DEPOSIT_ITEM_CAT_CD VARCHAR(50) NOT NULL COMMENT 'The category of the deposit item_1 i.e. refillable, non-refillable',
	REJECT_CNT NUMBER(38,0) NOT NULL COMMENT 'The number for the item_1 rejections.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_DEPOSIT_REJECT_PER_D primary key (RVM_SID, REJECT_DT, DEPOSIT_ITEM_CAT_CD)
);