create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_WAWI_ITEM_VARIANT (
	WAWI_ITEM_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item variant.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	WAWI_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item on which the variant is based.',
	WAWI_ITEM_VARIANT_NR NUMBER(38,0) NOT NULL COMMENT 'The number which identifies the Wawi item variant within the given country organization. Note that the number is unique for a certain point in time, but may be re-used later on. It is also known as the long Wawi number.',
	WAWI_ITEM_VARIANT_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the Wawi item variant is known within the given country organization.',
	WAWI_ITEM_VARIANT_DESCR VARCHAR(250) COMMENT 'A more detailed (free text) description for the Wawi item variant - which applies to the given country organization.',
	CASE_SIZE_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of individual items that are contained in the Wawi item variant. (Note that the individual item represents the smallest sellable unit. E.g. if a packed try of meat contains two slices, the entire tray is considered one sellable unit.) In case of weight-based items this is the integer part of the expected net weight of the package.',
	WEIGHT_BASED_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if the Wawi item variant is sold by weight instead of count.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country organization which has created the Wawi item variant. (This column is denormalized from t_wawi_item.)',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the business country for which created this Wawi item. (The business country is not identical to a political country.)',
	WAWI_ITEM_VARIANT_CREATION_DT DATE NOT NULL COMMENT 'The date when the item variant was created in the operational system (Wawi) of the given country organization.',
	constraint PK_T_WAWI_ITEM_VARIANT primary key (WAWI_ITEM_VARIANT_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A Wawi item can exist in various sizes, e.g. a box consisting of 10 individual items and another box consisting of 15 items. The Wawi item variant describes the package in which individual sales units are contained. The Wawi item variant is similar, but not identical to the (global) logistic variant, as Wawi items are specific to a country organization and as Wawi sometimes creates multiple items for the same global product. E.g. Wawi creates a new item if the composition of a package changes or if an item has a different sales price.'
;