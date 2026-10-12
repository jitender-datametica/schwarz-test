create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_FACT_DEPOSIT_ARTICLE_PER_WEEK_1 (
	ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for an item_1',
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	LOB_CD VARCHAR(50) NOT NULL COMMENT 'The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland lob=line os business',
	COUNTRY_POL_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying a political country_1 according to ISO 3166.',
	ITEM_GTIN VARCHAR(20) NOT NULL COMMENT 'A European article number',
	CY_WEEK NUMBER(38,0) NOT NULL COMMENT 'The week containing the partial week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the year. I.e. the week that was split to form this partial week. ',
	REJECT_CNT NUMBER(38,0) NOT NULL COMMENT 'The number for the item_1 rejections.',
	RETURN_CNT NUMBER(38,0) NOT NULL COMMENT 'The number for the item_1 return',
	ITEM_CONTAINER_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The description of a container which can be foreign or own container',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_DEPOSIT_ARTICLE_PER_WEEK primary key (ITEM_SID, RVM_SID, CY_WEEK)
);