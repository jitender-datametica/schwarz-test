create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_HGA_SALES (
	HGA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
	SALE_DT DATE NOT NULL COMMENT 'The calendar date of the hot beverage sales ',
	PAYMENT_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for the payment type for a hot beverage',
	HGA_PRODUCT_CAT_ID NUMBER(38,0) NOT NULL COMMENT 'The code for a hot beverage product',
	CURR_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying the currency according to ISO-4217.',
	MUG_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for a chosen mug type',
	SALE_TM TIME(9) NOT NULL COMMENT 'The time for the hot beverage sale',
	SALE_PRICE NUMBER(38,5) NOT NULL COMMENT 'The price for a hot beverage product in national currency',
	SALE_EUR_PRICE NUMBER(38,5) NOT NULL COMMENT 'The price for a hot beverage product in euro',
	LID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing if the customer choose a lid or not',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_HGA_SALES primary key (HGA_SID, SALE_DT, SALE_TM)
)COMMENT='Transactional facts capturing hot beverage product sales of hot beverage machines located in stores'
;