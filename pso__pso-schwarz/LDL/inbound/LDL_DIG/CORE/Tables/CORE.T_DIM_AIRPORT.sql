CREATE TABLE CORE.T_DIM_AIRPORT (
	AIRPORT_CD VARCHAR(5) NOT NULL COMMENT 'The three letter code for international airports in the world',
	COUNTRY_CD VARCHAR(5) NOT NULL COMMENT 'The unique code for a country according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
	AIRPORT_CITY_NAME VARCHAR(100) NOT NULL COMMENT 'The city name in which the airport is located',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_AIRPORT PRIMARY KEY (AIRPORT_CD)
)COMMENT='This minor dimension defines the airport and their city details'
;