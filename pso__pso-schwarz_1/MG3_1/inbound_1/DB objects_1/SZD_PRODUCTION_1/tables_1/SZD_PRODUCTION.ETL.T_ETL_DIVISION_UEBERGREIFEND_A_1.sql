create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_DIVISION_UEBERGREIFEND_A_1 (
	PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DIVISION_CD VARCHAR(50) NOT NULL COMMENT 'Natural/Business Key - The unique code for each division within the Schwarz Group, i.e.L-Lidl or K-Kaufland',
	DIVISION_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the division within the Schwarz Group, i.e.Lidl or Kaufland',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_DIVISION primary key (PARTY_SID, DWH_VALID_FROM_TMSP)
);