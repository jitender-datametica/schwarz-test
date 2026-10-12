create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_HGA_SALES_PER_HOUR_2 (
	HGA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
	HGA_PRODUCT_CAT_ID NUMBER(38,0) NOT NULL COMMENT 'The code for a hot beverage product',
	SALE_HOUR NUMBER(38,0) NOT NULL COMMENT 'The hour for a hot beverage product sale',
	SALE_DT DATE NOT NULL COMMENT 'The calendar_2 date of the hot beverage sales_2 ',
	PRODUCT_SALE_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of hot beverage product sales_2 per hour',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_HGA_SALES_PER_HOUR primary key (HGA_SID, SALE_HOUR, SALE_DT, HGA_PRODUCT_CAT_ID)
)COMMENT='Aggregated facts capturing Hot beverage product sales_2 per hour of hot beverage machines located in stores'
;