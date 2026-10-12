create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_ORDER_AREA (
	ORDER_AREA_NR VARCHAR(20) NOT NULL COMMENT 'The number which identifies the order area.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country organization.',
	COUNTRY_ORG_CD VARCHAR(2) COMMENT 'The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)',
	ORDER_AREA_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the order area. (Description in group language, i.e. in German)',
	ORDER_AREA_DESCR_DE VARCHAR(250) COMMENT 'A textual description for the order area. (Description in German)',
	ORDER_AREA_DESCR_EN VARCHAR(250) COMMENT 'A textual description for the order area. (Description in English)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_ORDER_AREA primary key (ORDER_AREA_NR, COUNTRY_ORG_SID)
)COMMENT='The order area groups items that are typically stored in the same storage zone in the warehouse. In different  warehouses, the assignment may be different. An order area is identified by its number and the warehouse. (I.e. the number is local to the warhouse.)'
;