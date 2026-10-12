create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_REAL_ESTATE_2 (
	RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	DIVISION_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'Natural/Business Key - The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
	DIVISION_CD VARCHAR(50) COMMENT 'Descriptive Attribute - The unique code for each division within the Schwarz Group, i.e.L-Lidl or K-Kaufland',
	DIVISION_NAME VARCHAR(100) COMMENT 'Descriptive Attribute - The name for the division within the Schwarz Group, i.e.Lidl or Kaufland',
	COUNTRY_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'Natural/Business Key - The unique identifier (surrogate key) of the political country.',
	COUNTRY_CD VARCHAR(50) COMMENT 'Descriptive Attribute - The ISO code of the country.',
	COUNTRY_NAME VARCHAR(100) COMMENT 'Descriptive Attribute - The name of the country.',
	REAL_ESTATE_NR VARCHAR(250) NOT NULL COMMENT 'Natural/Business Key - The unique code of the real estate within the country.',
	ZIP VARCHAR(15) COMMENT 'Descriptive Attribute - The zip code of the city/area where the real estate is located.',
	CITY VARCHAR(100) COMMENT 'Descriptive Attribute - The name of the city where the real estate is located.',
	STREET VARCHAR(1000) COMMENT 'Descriptive Attribute - The street name of the address_2 of the real estate.',
	LATITUDE NUMBER(9,6) COMMENT 'Descriptive Attribute - The latitude part of the geographical position of the real estate.',
	LONGITUDE NUMBER(9,6) COMMENT 'Descriptive Attribute - The longitude part of the geographical position of the real estate.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_DIM_REAL_ESTATE primary key (RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Dimension - A real estate is a building used for a specific purpose. It can be a store, a office building, a parking garage and so on. - Source - IOT Charger'
;