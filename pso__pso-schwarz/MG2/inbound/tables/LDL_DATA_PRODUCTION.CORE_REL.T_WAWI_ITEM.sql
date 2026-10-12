create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_WAWI_ITEM (
	WAWI_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country organization which has created the Wawi item.',
	WAWI_ITEM_NR NUMBER(38,0) NOT NULL COMMENT 'The number which identifies the Wawi item within the given country organization. Note that the number is unique for a certain point in time, but may be re-used later on. It is also known as the short Wawi number.',
	WAWI_ITEM_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the Wawi item is known within the given country organization.',
	WAWI_ITEM_DESCR VARCHAR(250) COMMENT 'A more detailed (free text) description for the Wawi item - which applies to the given country organization.',
	WAWI_ITEM_CREATION_DT DATE NOT NULL COMMENT 'The date when the item was created in the operational system (Wawi) of the given country organization.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the business country for which created this Wawi item. (The business country is not identical to a political country.)',
	constraint PK_T_WAWI_ITEM primary key (WAWI_ITEM_SID, DWH_VALID_FROM_TMSP)
)COMMENT='An item as defined by the operational system (Wawi). Items are tangible goods which are purchased by the enterprise with the intention of selling them at a (potentially) higher price, thus generating profit. The Wawi item is similar, but not identical to the global product, as Wawi items are primarily based on logistic process. E.g. Wawi creates a new item if the composition of a package changes or if an item has a different sales price. A Wawi item is specific to a country organization.'
;