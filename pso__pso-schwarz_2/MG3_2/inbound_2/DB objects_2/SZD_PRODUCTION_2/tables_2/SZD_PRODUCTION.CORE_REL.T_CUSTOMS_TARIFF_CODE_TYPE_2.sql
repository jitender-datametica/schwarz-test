create or replace TABLE SZD_PRODUCTION.CORE_REL.T_CUSTOMS_TARIFF_CODE_TYPE_2 (
	CUSTOMS_TARIFF_CODE_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the customs tariff code type.',
	CUSTOMS_TARIFF_CATEGORY_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the customs tariff category.',
	CUSTOMS_TARIFF_CODE_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the customs tariff code type.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) NOT NULL COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_CUSTOMS_TARIFF_CODE_TYPE primary key (CUSTOMS_TARIFF_CODE_TYPE_CD, CUSTOMS_TARIFF_CATEGORY_CD)
)COMMENT='Minor Entity - Defines the meanings of the different customs tariff numbers.  - Source - Manual'
;