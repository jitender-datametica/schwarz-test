create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_HGA_MUG_TYPE_1 (
	MUG_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for a chosen mug type',
	MUG_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'The default textual description for the mug type',
	MUG_TYPE_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'The textual description for the mug type in German.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	MUG_TYPE_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'The textual description for the mug type in English.',
	constraint PK_T_DIM_HGA_MUG_TYPE primary key (MUG_TYPE_ID)
)COMMENT='This minor dimension defines the mug types for hot beverage products'
;