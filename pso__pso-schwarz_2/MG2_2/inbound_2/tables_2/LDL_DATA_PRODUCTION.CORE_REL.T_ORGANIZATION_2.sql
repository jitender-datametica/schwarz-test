create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_ORGANIZATION_2 (
	ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the organization.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	ORG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminator for organizations.',
	ORG_NAME VARCHAR(100) COMMENT 'The name by which the organization is known.',
	LEGAL_NAME VARCHAR(100) COMMENT 'The official name of the company, as shown in the company register.',
	VAT_NR VARCHAR(20) COMMENT 'The VAT identification number of the company.',
	IS_SUP_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if the company is a supplier.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_ORGANIZATION primary key (ORG_SID, DWH_VALID_FROM_TMSP)
)COMMENT='An organization is any group of persons or other organizations that has been formed for a specific purpose. This includes for example companies, private associations or government bodies such as the tax office or regulatory authorities. The concept of an organization does not apply to internal organizations of the Schwarz Group, such as departments, cost or profit centres.'
;