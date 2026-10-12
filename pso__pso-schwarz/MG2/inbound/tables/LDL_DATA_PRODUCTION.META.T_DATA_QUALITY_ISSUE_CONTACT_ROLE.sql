create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_QUALITY_ISSUE_CONTACT_ROLE (
	DQ_ISSUE_CONTACT_ROLE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the role, which the contact person plays in the context of the data quality issue. E.g. an employee may be the primary contact for analyzing the issue or a secondary contact for resolving the issue.',
	DQ_ISSUE_CONTACT_ROLE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the role, which the contact person plays in the context of the data quality issue. E.g. an employee may be the primary contact for analyzing the issue or a secondary contact for resolving the issue.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_QUALITY_ISSUE_CONTACT_ROLE primary key (DQ_ISSUE_CONTACT_ROLE_CD)
)COMMENT='This minor entity defines, which role the contact person plays in the context of the data quality issue. E.g. an employee may be the primary contact for analyzing the issue or a secondary contact for resolving the issue.'
;