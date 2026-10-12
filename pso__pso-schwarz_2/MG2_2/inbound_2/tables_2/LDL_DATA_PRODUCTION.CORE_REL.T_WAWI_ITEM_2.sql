create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_WAWI_ITEM_2 (
	WAWI_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_2 organization which has created the Wawi item.',
	WAWI_ITEM_NR NUMBER(38,0) NOT NULL COMMENT 'The number which identifies the Wawi item_2 within the given country_2 organization. Note that the number is unique for a certain point in time, but may be re_2-used later on. It is also known as the short Wawi number.',
	WAWI_ITEM_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the Wawi item_2 is known within the given country_2 organization.',
	WAWI_ITEM_DESCR VARCHAR(250) COMMENT 'A more detailed (free text) description for the Wawi item_2 - which applies to the given country_2 organization.',
	WAWI_ITEM_CREATION_DT DATE NOT NULL COMMENT 'The date when the item_2 was created in the operational system (Wawi) of the given country_2 organization.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the business country_2 for which created this Wawi item. (The business country_2 is not identical to a political country.)',
	constraint PK_T_WAWI_ITEM primary key (WAWI_ITEM_SID, DWH_VALID_FROM_TMSP)
)COMMENT='An item_2 as defined by the operational system (Wawi). Items are tangible goods which are purchased by the enterprise with the intention of selling them at a (potentially) higher price, thus generating profit. The Wawi item_2 is similar, but not identical to the global product, as Wawi items are primarily based on logistic process. E.g. Wawi creates a new item_2 if the composition of a package_2 changes or if an item_2 has a different sales_2 price. A Wawi item_2 is specific to a country_2 organization.'
;