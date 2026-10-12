    CREATE TABLE CORE_REL.T_PRICE_GROUP_1 (
	PRICE_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the price level of a product.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PRICE_GRP_NR NUMBER(38,0) NOT NULL COMMENT 'The number which identifies the price level within its country_1 organization.',
	PRICE_GRP_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the price level is known in the country_1 organization.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_1 organization which has defined the price level.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	CONSTRAINT PK_T_PRICE_GROUP PRIMARY KEY (PRICE_GRP_SID, DWH_VALID_FROM_TMSP)
)COMMENT='The sales_1 price of a product varies depending on a number of factors, such as the location_1 and the competitive situation of the store. During promotional periods prices for certain products are typically lower. The price group defines the price level. A product has a different sales_1 price, depending on its price level.'
;