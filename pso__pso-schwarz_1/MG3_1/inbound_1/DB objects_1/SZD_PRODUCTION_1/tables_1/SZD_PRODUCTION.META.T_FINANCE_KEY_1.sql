create or replace TABLE SZD_PRODUCTION.META.T_FINANCE_KEY_1 (
	FINANCE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the finance object.',
	FINANCE_KEY_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The code for the type of natural key which identifies the finance object.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	FINANCE_NAT_KEY_NR VARCHAR(250) NOT NULL COMMENT 'The natural key which identifies the finance object. In case the natural key consist of several columns, all components get concatenated.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	constraint PK_FINANCE_KEY primary key (FINANCE_KEY_TYPE_CD, DWH_VALID_FROM_TMSP, FINANCE_NAT_KEY_NR)
)COMMENT='Metadata - Keytable - Finance - Contains the mapping between surrogate keys and natural keys for business objects from the subject area \"Finance\".'
;