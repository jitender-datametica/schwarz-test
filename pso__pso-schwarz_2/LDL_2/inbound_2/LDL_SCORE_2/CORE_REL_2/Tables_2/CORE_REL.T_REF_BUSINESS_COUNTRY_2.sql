CREATE TABLE CORE_REL.T_REF_BUSINESS_COUNTRY_2 (
	BUS_COUNTRY_CD VARCHAR(2) NOT NULL COMMENT 'A two-character code according to the business definition of Kaufland or Lidl.',
	BUS_COUNTRY_DESCR VARCHAR(100) NOT NULL COMMENT 'A textual description for the xxx_2 in group language (German).',
	BUS_COUNTRY_DESCR_DE VARCHAR(100) COMMENT 'A textual description for the xxx_2 in German.',
	BUS_COUNTRY_DESCR_EN VARCHAR(100) COMMENT 'A textual description for the xxx_2 in English.',
	REPORTING_COUNTRY_DESCR VARCHAR(100) COMMENT 'A textual description for the country_2 which is used for the reporting tool.',
	REPORTING_TERRITORY_DESCR VARCHAR(100) COMMENT 'A textual description for the territory (Bundesland) which is used for the reporting tool.',
	LINK_TO_NAT_FLAG_TXT VARCHAR(1000) COMMENT 'A link to a picture of the national flag.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.'
)COMMENT='This minor dimension defines the xxx_2'
;