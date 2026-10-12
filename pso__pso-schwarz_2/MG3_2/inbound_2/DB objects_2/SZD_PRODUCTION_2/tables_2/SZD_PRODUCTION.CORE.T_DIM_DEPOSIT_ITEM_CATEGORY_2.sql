create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_DEPOSIT_ITEM_CATEGORY_2 (
	DEPOSIT_ITEM_CAT_CD VARCHAR(50) NOT NULL COMMENT 'The category of the deposit item_2 i.e. refillable, non-refillable',
	DEPOSIT_ITEM_CAT_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual default description for the deposit item_2 category in German',
	DEPOSIT_ITEM_CAT_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'A textual description for the deposit item_2 category in German',
	DEPOSIT_ITEM_CAT_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'A textua description for the deposit item_2 category in English',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_DIM_DEPOSIT_ITEM_CATEGORY primary key (DEPOSIT_ITEM_CAT_CD)
)COMMENT='This minor dimension defines the deposit items category i.e. refillable, non-refillable'
;