create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_DEPOSIT_REJECTLIST (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	REJECT_DT DATE NOT NULL COMMENT 'The date when the deposit item was rejected.',
	REJECT_TM TIME(9) NOT NULL COMMENT 'The time when the deposit item was rejected.',
	REJECT_REASON_GROUP_ID NUMBER(38,0) NOT NULL COMMENT 'The rejections defined by the customer as groups of similar rejections',
	DEPOSIT_ITEM_CAT_CD VARCHAR(50) NOT NULL COMMENT 'The category of the deposit item i.e. refillable, non-refillable',
	EAN VARCHAR(13) NOT NULL COMMENT 'AEuropean article number',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_DEPOSIT_REJECTLIST primary key (RVM_SID, REJECT_DT, REJECT_TM)
)COMMENT='Transactional facts capturing deposit machines rejecting items'
;