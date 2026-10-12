create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_QUALITY_RULE_SOURCE (
	DQ_RULE_SRC_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the origin of the data quality rule. A rule may be defined by business or by the data modelling team or because of a formal guideline, such as checking all foreign keys for referential integrity violations. (Note that the origin of a data quality rule is independent from the way how it is implemented, i.e. as a generated rule, a parametrized rule or as a business rule.)',
	DQ_RULE_SRC_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the origin of the data quality rule.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_QUALITY_RULE_SOURCE primary key (DQ_RULE_SRC_CD)
)COMMENT='This minor entity defines the origin of the data quality rule. A rule may be defined by business or by the data modelling team or because of a formal guideline, such as checking all foreign keys for referential integrity violations. (Note that the origin of a data quality rule is independent from the way how it is implemented, i.e. as a generated rule, a parametrized rule or as a business rule.)'
;