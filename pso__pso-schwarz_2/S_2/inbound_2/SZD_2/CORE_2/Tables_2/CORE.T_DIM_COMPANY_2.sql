CREATE TABLE CORE.T_DIM_COMPANY_2 (
	COMPANY_ID NUMBER(38,0) NOT NULL COMMENT 'The Company number of a store e.g. 13',
	COMPANY_NAME VARCHAR(100) NOT NULL,
	COUNTRY_POL_CD VARCHAR(3) NOT NULL COMMENT 'The code identifying a political country_2 according to ISO 3166.',
	LOB_CD VARCHAR(50) NOT NULL COMMENT 'The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland
lob=line os business',
	STREET_NAME VARCHAR(100) COMMENT 'The name of the street where the store is located.',
	HOUSE_NR VARCHAR(20) COMMENT 'The number of the building within the street where the store is located.',
	CITY_NAME VARCHAR(100) COMMENT 'The name of the city where the store is located.',
	ZIP VARCHAR(15) COMMENT 'The postal code of the store address.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_COMPANY PRIMARY KEY (company_id, lob_cd, country_pol_cd) NOT ENFORCED
)COMMENT='The company identifies the name under which a store is affiliated e.g. Kob Lidl GmbH & Co. KG, KL Vertrieb KAPPA GmbH&Co...'
;