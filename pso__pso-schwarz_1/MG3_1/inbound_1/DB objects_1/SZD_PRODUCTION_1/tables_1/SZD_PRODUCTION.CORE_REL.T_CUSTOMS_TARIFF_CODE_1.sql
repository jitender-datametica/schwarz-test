create or replace TABLE SZD_PRODUCTION.CORE_REL.T_CUSTOMS_TARIFF_CODE_1 (
	CUSTOMS_CLASSIFICATION_SCHEME_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the customs classification scheme.',
	CUSTOMS_TARIFF_CODE_CD VARCHAR(250) NOT NULL COMMENT 'The standardized customs tariff code number.',
	CUSTOMS_TARIFF_CODE_DESCR VARCHAR(250) COMMENT 'A brief description of what kind of goods this customs tariff code is describing.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_CUSTOMS_TARIFF_CODE primary key (CUSTOMS_CLASSIFICATION_SCHEME_CD, CUSTOMS_TARIFF_CODE_CD)
)COMMENT='Minor Entity - The customs tariff code identifies the type of goods according to the HMRC Tariff. - Source - GTS/WWT, GS-Upload, Excel Report from CDS, Broker (per Mail)'
;