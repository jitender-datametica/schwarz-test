create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_RVM_REJECTION_REASON_2 (
	REJECT_REASON_ID NUMBER(38,0) NOT NULL COMMENT 'The code for the rejection reason of deposits.',
	DEPOSIT_ITEM_CAT_CD VARCHAR(50) NOT NULL COMMENT 'The category of the deposit item_2 i.e. refillable, non-refillable',
	REJECT_REASON_GROUP_ID NUMBER(38,0) NOT NULL COMMENT 'The rejections defined by the customer as groups of similar rejections',
	REJECT_REASON_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual default description for the rejection reason in German.',
	REJECT_REASON_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'A textual description for the rejection reason in English.',
	REJECT_REASON_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'A textual description for the rejection reason in German.',
	REJECT_REASON_SOURCE_NR VARCHAR(100) COMMENT 'A textual description for the rejection reason coming from the source.',
	REJECT_REASON_SOURCE_NAME VARCHAR(100) COMMENT 'A textual description for the rejection reason coming from the source.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_DIM_RVM_REJECTION_REASON primary key (REJECT_REASON_ID)
)COMMENT='This minor dimension defines the rejection reasons of items'
;