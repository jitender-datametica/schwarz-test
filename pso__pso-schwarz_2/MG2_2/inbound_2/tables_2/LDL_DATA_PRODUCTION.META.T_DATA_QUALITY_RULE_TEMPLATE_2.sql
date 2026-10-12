create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_QUALITY_RULE_TEMPLATE_2 (
	DQ_RULE_TEMPLATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the template for formal data quality rules.',
	DQ_RULE_TEMPLATE_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the template script which was used to generate a formal data quality rule.',
	DQ_RULE_TEMPLATE_DESCR VARCHAR(250) NOT NULL COMMENT 'A free text describing the purpose and structure of the template for formal data quality rules.',
	TEMPLATE_SQL_TXT VARCHAR(1000) COMMENT 'The SQL template for the data quality check.',
	DQ_RULE_TYPE_CD VARCHAR(20) COMMENT 'A code for the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_QUALITY_RULE_TEMPLATE primary key (DQ_RULE_TEMPLATE_SID)
)COMMENT='Formal data quality checks can generated based on a template.'
;