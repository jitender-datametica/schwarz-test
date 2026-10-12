CREATE TABLE CORE.T_DIM_STORE_HIST_1 (
	STORE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a main store. It is identical to the key of the store that has first been assigned to this main store.',
	DWH_VALID_FROM_DT DATE NOT NULL COMMENT 'The date when this record became valid.',
	DWH_VALID_TO_DT DATE NOT NULL COMMENT 'The date when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	LOB_CD VARCHAR(50) NOT NULL COMMENT 'The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland 
lob=line os business',
	LOB_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the line of business within the Schwarz Group, i.e.Lidl or Kaufland
lob=line os business',
	COMPANY_ID NUMBER(38,0) COMMENT 'The Company number of a store e.g. 13',
	COMPANY_NAME VARCHAR(100) COMMENT 'The Company name of a store. e.g. Lidl GmbH & Co. KG',
	STORE_NR VARCHAR(250) COMMENT 'The number by which the store is known to business. This number is unique for a given client_id, but not globally unique. (The same number can be in different clients).',
	STORE_NAME VARCHAR(100) COMMENT 'The name, by which the store in known.',
	STORE_ACTIVE_FG BOOLEAN NOT NULL COMMENT 'An indicator showing if the store had any sales_1 during the last 36 months. (The flag is equivalent to mis_store_active_fg in the core. It is not delivered by a source system, but calculated during the core load.)',
	STREET_NAME VARCHAR(100) COMMENT 'The name of the street where the store is located.',
	HOUSE_NR VARCHAR(20) COMMENT 'The number of the building within the street where the store is located.',
	CITY_NAME VARCHAR(100) COMMENT 'The name of the city where the store is located.',
	ZIP VARCHAR(15) COMMENT 'The postal code of the store address.',
	COUNTRY_POL_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying a political country_1 according to ISO 3166.',
	COUNTRY_POL_NAME VARCHAR(100) NOT NULL COMMENT 'The name for a political country_1 in group language, i.e. in German.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_STORE_HIST PRIMARY KEY (STORE_SID, DWH_VALID_FROM_DT)
)COMMENT='The main store identifies a physical store, regardless if its business store number gets changed in the source systems or not.'
;