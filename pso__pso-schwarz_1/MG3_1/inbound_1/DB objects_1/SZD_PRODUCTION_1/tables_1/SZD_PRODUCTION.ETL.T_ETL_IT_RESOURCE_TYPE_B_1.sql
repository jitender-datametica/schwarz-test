create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_IT_RESOURCE_TYPE_B_1 (
	IT_RESOURCE_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the discriminators for task configuration item_1 groups in IT4You',
	IT_RESOURCE_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the discriminators for task configuration item_1 groups',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_IT_RESOURCE_TYPE primary key (IT_RESOURCE_TYPE_ID)
);