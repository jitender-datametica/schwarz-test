create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_CUSTOMS_TARIFF_NUMBER_2 (
	CUSTOMS_CLASSIFICATION_SCHEME_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the customs classification scheme.',
	CUSTOMS_TARIFF_NUMBER_CD VARCHAR(50) NOT NULL COMMENT 'Natural Key/Business Key - The unique code of the type of the customs tariff number.',
	CUSTOMS_TARIFF_NUMBER_DESCR VARCHAR(250) COMMENT 'The name of the type of the customs tariff number.',
	FOOD_NONFOOD_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the Food/Nonfood Type.',
	FOOD_NONFOOD_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the Food/Nonfood Type.',
	ALCOHOLIC_BEVERAGE_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the Alcoholic Beverage Type.',
	ALCOHOLIC_BEVERAGE_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the Alcoholic Beverage Type.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_T_DIM_CUSTOMS_TARIFF_NUMBER primary key (CUSTOMS_CLASSIFICATION_SCHEME_CD, CUSTOMS_TARIFF_NUMBER_CD)
)COMMENT='Minor Dimension - Contains the customs tariff numbers for a classification schema. - Source - Manual'
;