create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PAYMENT_LINE_TYPE_1 (
	PAYM_LINE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the subtype discriminator for payment lines. It distinguishes between incoming and outgoing payments, i.e. payments made by the customer and payments made to the customer.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PAYM_LINE_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the subtype discriminator for payment lines.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PAYMENT_LINE_TYPE primary key (PAYM_LINE_TYPE_CD, LANG_CD)
)COMMENT='This minor entity defines the subtye discriminators for payment lines. It distinguishes between incoming and outgoing payments, i.e. payments made by the customer and payments made to the customer.'
;