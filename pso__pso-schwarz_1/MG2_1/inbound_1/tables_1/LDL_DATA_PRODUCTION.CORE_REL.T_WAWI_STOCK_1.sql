create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_WAWI_STOCK_1 cluster by (
     COUNTRY_ORG_CD,
     BUS_DT
)(
	WAWI_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item.',
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
	INT_ORG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country_1 organization which is responsible for the internal organization on which stock is tracked.',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)',
	BUS_DT DATE NOT NULL COMMENT 'The date for which the stock quanity is calculated.',
	STOCK_SALES_UNIT_CNT NUMBER(38,0) COMMENT 'The number of individual items (that belong to the given Wawi item_1) which are on stock. E.g. if there are two boxes with 20 sales_1 variants each, the stock count is 40. For weight-based products this attribute is empty.',
	STOCK_QTY NUMBER(38,5) COMMENT 'The weight of the Wawi item_1 which is on stock in the given store or warehouse, expressed in the indicated unit_1 of measure. (This attribute is only filled for weight-based products.)',
	UOM_CD VARCHAR(20) COMMENT 'The code identifying the unit_1 of measure for the stock quantity.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_WAWI_STOCK primary key (WAWI_ITEM_SID, INT_ORG_SID, BUS_DT)
)COMMENT='The Wawi stock entity describes, how many units of a certain Wawi item_1 exist in a store or in a warehouse (i.e. a delivery company). Stock is shown either in kilograms (or any other unit_1 of measure describing weight) or as the number of sales_1 variants of the respective Wawi product. So if there are two boxes with 20 sales_1 item_1 each, the stock count is 40. Stock is calculated from one day to another and shows the quantity that should exist at the end of the business day. An inventory may correct the stock.'
;