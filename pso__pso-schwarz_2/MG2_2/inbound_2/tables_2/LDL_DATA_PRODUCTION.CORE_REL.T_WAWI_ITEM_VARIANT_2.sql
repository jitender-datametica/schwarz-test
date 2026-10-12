create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_WAWI_ITEM_VARIANT_2 (
	WAWI_ITEM_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item_2 variant.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	WAWI_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item_2 on which the variant is based.',
	WAWI_ITEM_VARIANT_NR NUMBER(38,0) NOT NULL COMMENT 'The number which identifies the Wawi item_2 variant within the given country_2 organization. Note that the number is unique for a certain point in time, but may be re_2-used later on. It is also known as the long Wawi number.',
	WAWI_ITEM_VARIANT_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the Wawi item_2 variant is known within the given country_2 organization.',
	WAWI_ITEM_VARIANT_DESCR VARCHAR(250) COMMENT 'A more detailed (free text) description for the Wawi item_2 variant - which applies to the given country_2 organization.',
	CASE_SIZE_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of individual items that are contained in the Wawi item_2 variant. (Note that the individual item_2 represents the smallest sellable unit. E.g. if a packed try of meat contains two slices, the entire tray is considered one sellable unit.) In case of weight-based items this is the integer part of the expected net weight of the package.',
	WEIGHT_BASED_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if the Wawi item_2 variant is sold by weight instead of count.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_2 organization which has created the Wawi item_2 variant. (This column is denormalized from t_wawi_item.)',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the business country_2 for which created this Wawi item. (The business country_2 is not identical to a political country.)',
	WAWI_ITEM_VARIANT_CREATION_DT DATE NOT NULL COMMENT 'The date when the item_2 variant was created in the operational system (Wawi) of the given country_2 organization.',
	constraint PK_T_WAWI_ITEM_VARIANT primary key (WAWI_ITEM_VARIANT_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A Wawi item_2 can exist in various sizes, e.g. a box consisting of 10 individual items and another box consisting of 15 items. The Wawi item_2 variant describes the package_2 in which individual sales_2 units are contained. The Wawi item_2 variant is similar, but not identical to the (global) logistic variant, as Wawi items are specific to a country_2 organization and as Wawi sometimes creates multiple items for the same global product. E.g. Wawi creates a new item_2 if the composition of a package_2 changes or if an item_2 has a different sales_2 price.'
;