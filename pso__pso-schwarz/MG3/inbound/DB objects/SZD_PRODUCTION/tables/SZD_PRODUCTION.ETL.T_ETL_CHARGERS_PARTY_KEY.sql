create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_CHARGERS_PARTY_KEY (
	PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party.',
	PARTY_KEY_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The code for the type of natural key which identifies the party.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PARTY_NAT_KEY_NR VARCHAR(250) NOT NULL COMMENT 'The natural key which identifies the party.In case the natural key consist of several columns, all components get concatenated.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	constraint PK_PARTY_KEY primary key (PARTY_KEY_TYPE_CD, DWH_VALID_FROM_TMSP, PARTY_NAT_KEY_NR)
);