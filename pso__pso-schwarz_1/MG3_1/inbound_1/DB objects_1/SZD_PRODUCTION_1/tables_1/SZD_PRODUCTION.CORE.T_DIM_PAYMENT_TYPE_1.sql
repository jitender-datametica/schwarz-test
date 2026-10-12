create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_PAYMENT_TYPE_1 (
	PAYMENT_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for a chosen payment type',
	PAYMENT_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'The default textual description for the payment type for a hot beverage.',
	PAYMENT_TYPE_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'The German description for the payment type for a hot beverage',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	PAYMENT_TYPE_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'The English description for the payment type for a hot beverage.',
	constraint PK_T_DIM_PAYMENT_TYPE primary key (PAYMENT_TYPE_ID)
)COMMENT='This minor dimension defines the payment types for hot beverage products'
;