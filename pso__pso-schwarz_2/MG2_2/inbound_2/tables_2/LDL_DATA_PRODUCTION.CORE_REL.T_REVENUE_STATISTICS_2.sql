create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_REVENUE_STATISTICS_2 (
	STORE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the store, for which the revenue statistics are generated.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country_2 organization.',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the related business country. (The business country_2 is not identical to a political country.)',
	REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	STAT_DT DATE NOT NULL COMMENT 'The date when the revenue statistics were collected. ',
	BUS_DT DATE NOT NULL COMMENT 'The date for which the revenue is accrued.',
	CURR_STAT_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if this is the current record for the given key, i.e. the record with the latest statistics date. Filtering on this flag returns the statistics after any corrections.',
	CORRECTION_SEQ NUMBER(38,0) COMMENT 'In case multiple corrections apply to one base record, this is the sequence of the correction.',
	RECEIPT_NR NUMBER(38,0) NOT NULL COMMENT 'The number of the receipt which tracks the revenue statistics.',
	RECEIPT_LINE_NR NUMBER(38,0) NOT NULL COMMENT 'The number of the positon on the receipt which tracks the revenue statistics.',
	STAT_SRC_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the source or system which provided the statistics.',
	REVENUE_STAT_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for the subtype discriminator for revenue statisticss.',
	RECEIPT_CNT NUMBER(38,0) COMMENT 'The number of receipts generated on this day in this internal organization (store).',
	TURNOVER_NET_VAL NUMBER(38,5) COMMENT 'The net turnover amount in the currency indicated by the currency code for this day and this internal organization (store). The net turnover is calclated based on the average VAT rate in this store and day.',
	TURNOVER_GROSS_VAL NUMBER(38,5) COMMENT 'The gross turnover amount in the currency indicated by the currency code for this day and this internal organization (store).',
	CURR_CD VARCHAR(3) COMMENT 'The code identifying the currency, according to ISO 4217.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_REVENUE_STATISTICS primary key (STORE_SID, BUS_DT, STAT_DT, RECEIPT_NR, RECEIPT_LINE_NR)
)COMMENT='The event of creating revenue statistics for a particular store and day.'
;