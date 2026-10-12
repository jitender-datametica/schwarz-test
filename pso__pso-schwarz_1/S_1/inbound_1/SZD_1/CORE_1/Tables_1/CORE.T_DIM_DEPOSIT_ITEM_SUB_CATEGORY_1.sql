CREATE TABLE CORE.T_DIM_DEPOSIT_ITEM_SUB_CATEGORY_1 (
	DEPOSIT_ITEM_SUB_CAT_ID NUMBER(38,0) NOT NULL COMMENT 'The code for the item_1 return type of deposits.',
	DEPOSIT_ITEM_CAT_CD VARCHAR(50) NOT NULL COMMENT 'The category of the deposit item_1 i.e. refillable, non-refillable',
	DEPOSIT_ITEM_SUB_CAT_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual default description for the item_1 return type in Germand',
	DEPOSIT_ITEM_SUB_CAT_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'A textual description for the item_1 return type in Germand',
	DEPOSIT_ITEM_SUB_CAT_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'A textual description for the item_1 return type in English',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_DEPOSIT_ITEM_SUB_CATEGORY PRIMARY KEY (DEPOSIT_ITEM_SUB_CAT_ID)
)COMMENT='This minor dimension defines the class of deposit items'
;