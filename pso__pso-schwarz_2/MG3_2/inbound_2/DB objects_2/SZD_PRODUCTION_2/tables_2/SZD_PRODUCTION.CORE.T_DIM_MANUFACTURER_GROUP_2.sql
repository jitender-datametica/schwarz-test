create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_MANUFACTURER_GROUP_2 (
	MANUFACTURER_GROUP_CD VARCHAR(50) NOT NULL COMMENT 'the type of machines, products..a manufacturer produces',
	MANUFACTURER_GROUP_NAME VARCHAR(100) NOT NULL COMMENT 'The group name of manufacturers Productions',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_DIM_MANUFACTURER_GROUP primary key (MANUFACTURER_GROUP_CD)
)COMMENT='This minor dimension defines Manufactrurer groups for which they produce machines e.g. RVM, HGA'
;