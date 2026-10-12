create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_CUSTOMS_CLEARANCE_REPORT_LINE_PER_DAY_1 (
	CLEARANCE_DT DATE NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	AUTHORITY_COUNTRY_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country_1 of the customs authority.',
	CONSIGNOR_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the consignor.',
	DECLARANT_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the declarant.',
	IMPORT_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the transhipment location.',
	CUSTOMS_DECLARATION_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'Natural Key/Business Key - The unique code of the type of the customs declaration',
	DISPATCH_COUNTRY_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_1 that dispatched the good.',
	TRANSPORT_COUNTRY_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the political country_1 that has made the transport of the goods.',
	ORIGIN_COUNTRY_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country_1 where the product comes from.',
	CUSTOMS_PRODUCT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the customs product.',
	CUSTOMS_PREFERENCE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the customs procedure code.',
	AGREEMENT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the free trade agreement.',
	CURR_CD VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'The currency code for the duty paid amount.',
	PRODUCT_CNT NUMBER(38,0) NOT NULL COMMENT 'Fact - additive - The count of distinct products.',
	DUTY_PAID_VAL NUMBER(38,5) NOT NULL COMMENT 'Fact - additive - The amount of duty that was paid.',
	NET_WEIGHT_MEAS NUMBER(38,5) NOT NULL COMMENT 'Fact - additive - The net weight measure of the item.',
	CUSTOMS_VAL NUMBER(38,5) NOT NULL COMMENT 'Fact - additive - The total value of the item_1 for the purposes of customs duty. In addition to the actual price of the goods this includes additional elements such as Freight Charges to the EU boundary. ',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) NOT NULL COMMENT 'Contains the fully qualified names of the source tables from the relational model.',
	constraint PK_FACT_CUSTOMS_CLEARANCE_RE primary key (CLEARANCE_DT, AUTHORITY_COUNTRY_LOCATION_SID, ORIGIN_COUNTRY_LOCATION_SID, CUSTOMS_PRODUCT_SID, IMPORT_LOCATION_SID, CUSTOMS_DECLARATION_TYPE_CD, DISPATCH_COUNTRY_LOCATION_SID, TRANSPORT_COUNTRY_LOCATION_SID, CONSIGNOR_PARTY_SID, DECLARANT_PARTY_SID, CUSTOMS_PREFERENCE_CD, AGREEMENT_SID, CURR_CD)
)COMMENT='Fact table - Analytical - Granularity - by day & authority country_1 & consignor stream & origin country_1 - Aggregate - Containts item_1 related facts from the item_1 report from the customs authority. - Source - CDS Header Report, CDS Item_1 Report'
;