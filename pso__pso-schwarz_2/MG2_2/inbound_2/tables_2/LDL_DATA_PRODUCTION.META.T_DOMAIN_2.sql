create or replace TABLE LDL_DATA_PRODUCTION.META.T_DOMAIN_2 (
	DOMAIN_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the domain.',
	DOMAIN_DESCR VARCHAR(250) COMMENT 'A textual definition of the domain describing its purpose and how it should be used.',
	DOMAIN_FAMILY_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the group of domains. E.g. Numeric, Code, Identifier, ...',
	LOGICAL_SUFFIX_NAME VARCHAR(100) COMMENT 'In case domain get considered in the naming standard, this is the suffix used for logical models.',
	PHYSICAL_SUFFIX_NAME VARCHAR(100) COMMENT 'In case domain get considered in the naming standard, this is the suffix used for physical models.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DOMAIN primary key (DOMAIN_NAME)
)COMMENT='A domain describes the character of a data element, e.g. of an attribute in an entity. It is not only an abstract data type, but also defines the purpose and the format of the column.'
;