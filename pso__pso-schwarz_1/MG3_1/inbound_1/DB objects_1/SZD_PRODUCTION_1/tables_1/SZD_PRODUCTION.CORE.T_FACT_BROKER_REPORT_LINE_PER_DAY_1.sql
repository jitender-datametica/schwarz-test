create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_BROKER_REPORT_LINE_PER_DAY_1 (
	CDS_ACCEPTANCE_DT DATE NOT NULL COMMENT 'This is the date when the goods have arrived at the import location.',
	AUTHORITY_COUNTRY_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country_1 of the customs authority.',
	BROKER_DECLARANT_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the broker declarant.',
	CONSIGNOR_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the consignor.',
	CUSTOMS_DECLARATION_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the type of the customs declaration',
	CUSTOMS_PRODUCT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the customs product.',
	CUSTOMS_PROCEDURE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the customs procedure.',
	TOTAL_LINE_CNT NUMBER(38,0) NOT NULL COMMENT 'Fact - additive - The total number of lines in the broker report.',
	ALCOHOLIC_LINE_CNT NUMBER(38,0) NOT NULL COMMENT 'Fact - additive - The count of lines containing alcoholic beverage products in the broker report.',
	NON_ALCOHOLIC_LINE_CNT NUMBER(38,0) NOT NULL COMMENT 'Fact - additive - The count of lines containing non-alcoholic beverage products in the broker report.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) NOT NULL COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_FACT_BROKER_REPORT_LINE_PER_DAY primary key (CDS_ACCEPTANCE_DT, AUTHORITY_COUNTRY_LOCATION_SID, BROKER_DECLARANT_PARTY_SID, CONSIGNOR_PARTY_SID, CUSTOMS_DECLARATION_TYPE_CD, CUSTOMS_PRODUCT_SID, CUSTOMS_PROCEDURE_CD)
)COMMENT='Fact table - Analytical - Granularity - by day and product and customs procedure code and declaration category - Aggregate - Contains facts regarding the lines in a broker report. - Source - Broker Report'
;