create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_MANUFACTURER_1 (
	MANUFACTURER_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a company which produces deposit machines.',
	MANUFACTURER_GROUP_CD VARCHAR(50) NOT NULL COMMENT 'the type of machines, products..a manufacturer produces',
	MANUFACTURER_NAME VARCHAR(100) NOT NULL COMMENT 'The name of a company which produces deposit machines.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_DIM_MANUFACTURER primary key (MANUFACTURER_SID)
)COMMENT='A company that produces machines, products e.g..Tomra, Sielaff'
;