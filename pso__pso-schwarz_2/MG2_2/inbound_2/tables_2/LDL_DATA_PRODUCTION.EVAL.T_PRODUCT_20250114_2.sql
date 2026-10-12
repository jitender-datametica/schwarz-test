create or replace TABLE LDL_DATA_PRODUCTION.EVAL.T_PRODUCT_20250114_2 (
	PROD_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PROD_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminator for products.',
	ITEM_TYPE_CD VARCHAR(20) COMMENT 'The code for the subtype discriminator for items.',
	PROD_NR VARCHAR(20) NOT NULL COMMENT 'The number which (globally) identifies the product within the organization. (Note that the product number is unique for a certain point in time, but may be re_2-used later on.)',
	PROD_NAME VARCHAR(250) NOT NULL COMMENT 'The (global) name by which the product is marketed.',
	PROD_DESCR VARCHAR(250) COMMENT 'A more detailed (free text) description for the product.',
	PROD_CREATION_DT DATE COMMENT 'The date when product was first listed.',
	PACKING_TYPE_CD VARCHAR(20) COMMENT 'The code identifying the way, how a product is packed.',
	GOODS_ON_CONSIGNMENT_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if the product is sold on behalf of a third party. Sales_2 revenue is directly transferred to this third party, who in turn, pays a commisson to the vending party.',
	EXCL_FROM_VAT_CALC_FG BOOLEAN NOT NULL COMMENT 'An indidcator showing, if the product should be excluded from the VAT calculation.',
	COUNTRY_SPECIFIC_PROD_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if the product has been defined by only one country_2 organization and is therefore available only in one country. (This does not include products, which are defined globally, but which happen to be sold in only one country.)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PRODUCT primary key (PROD_SID, DWH_VALID_FROM_TMSP)
)COMMENT='The term „Product\"" describes goods and services which are offered by the enterprise. In the case of a retailer these are the goods the company trades with. The term “product” is not limited to the current assortment of goods and services, but may also include articles of competitors or articles which are currently not in the assortment.'
;