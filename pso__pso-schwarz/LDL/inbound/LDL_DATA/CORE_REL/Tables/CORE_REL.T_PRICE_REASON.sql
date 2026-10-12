    CREATE TABLE CORE_REL.T_PRICE_REASON (
	PRICE_REASON_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the reason why a price was defined for a product. E.g. permanent price change, promotional price, etc.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PRICE_REASON_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the reason why a price was defined for a product. E.g. permanent price change, promotional price, etc.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	CONSTRAINT PK_T_PRICE_REASON PRIMARY KEY (PRICE_REASON_CD, LANG_CD)
)COMMENT='This minor entity defines the reason why a price was defined for a product. E.g. permanent price change, promotional price, etc.'
;