create or replace TABLE UGS_ARIS_PRODUCTION.CORE.T_DIM_COUNTRY_ORGANIZATION_1 (
	DWH_TENANT_CD VARCHAR(8) NOT NULL COMMENT 'The code for the data warehoue tenant.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_1 organization.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	COUNTRY_ORG_NR VARCHAR(20) NOT NULL COMMENT 'The number (or code) which identifies the country_1 organization.',
	COUNTRY_ORG_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the country_1 organization is known.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(100) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.'
)COMMENT='A country_1 organization is an organizational unit_1 within the Schwarz Group which is responsible for the operation in a certain geographical area, typically a political country_1 such as Gemany or France. Few country_1 organizations are responsible for more than one country. E.g. Belgium and Luxemburg are handled by one country_1 organization. Some country_1 organizations cover only a part of a country_1, E.g. the Canary Islands are handeld by a separate country_1 organization.'
;