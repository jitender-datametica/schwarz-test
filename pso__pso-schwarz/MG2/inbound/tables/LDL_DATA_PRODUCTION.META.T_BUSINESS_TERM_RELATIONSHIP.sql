create or replace TABLE LDL_DATA_PRODUCTION.META.T_BUSINESS_TERM_RELATIONSHIP (
	BUS_TERM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the object term.',
	REL_BUS_TERM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related object term.',
	BUS_TERM_REL_NAME VARCHAR(100) NOT NULL COMMENT 'A verb describing the way how the two business terms are related with each other. E.g. \""works\"" for a relationship describing that an employee works in a store. Ideally, the sequence <Business Term> <Business Term Relation Name> <Related Business Term> should form a sentence.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_BUSINESS_TERM_RELATIONSHIP primary key (REL_BUS_TERM_SID, BUS_TERM_SID, BUS_TERM_REL_NAME, DWH_VALID_FROM_TMSP)
)COMMENT='Business terms may be related to each other, E.g. a supplier provides certain products or an employee works in a department. This entity only contains two-way relations. Due to a limitation in Ab Initio MHub a separate object term needs to be created, in case three or more business terms form the relation.'
;