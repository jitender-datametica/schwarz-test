create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_STOCK_1 cluster by (
     COUNTRY_ORG_CD,
     BUS_DT
)(
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
	INT_ORG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the related business country. (The business country_1 is not identical to a political country.)',
	BUS_DT DATE NOT NULL COMMENT 'The date for which the stock quanity is calculated.',
	STOCK_SALES_UNIT_CNT NUMBER(38,0) COMMENT 'The number of sales_1 variants (that belong to the given product) which are on stock. E.g. if there are two boxes with 20 sales_1 variants each, the stock count is 40. For weight-based products this attribute is empty.',
	STOCK_QTY NUMBER(38,5) COMMENT 'The weight of the product which is on stock in the given store or warehouse, expressed in the indicated unit_1 of measure. (This attribute is only filled for weight-based products.)',
	UOM_CD VARCHAR(20) COMMENT 'The code identifying the unit_1 of measure for the stock quantity.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	PROD_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
	constraint PK_T_STOCK primary key (PROD_SID, INT_ORG_SID, BUS_DT)
)COMMENT='The stock entity describes, how many units of a certain product exist in a store or in a warehouse (i.e. a delivery company). Stock is shown either in kilograms (or any other unit_1 of measure describing its weight) or as the number of sales_1 variants of the respective product. So if there are two boxes with 20 sales_1 item_1 each, the stock count is 40. Stock is calculated from one day to another and shows the quantity that should exist at the end of the business day. An inventory may correct the stock.'
;