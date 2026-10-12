
CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_DIM_LISTING_TYPE_1 (
	LIST_TYPE_CD COMMENT 'The code identifying the listing type, e.g. regular assortment, seasonal products, promotional items, etc.',
	LIST_TYPE_DESCR COMMENT 'A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc. (Description in group language, i.e. in German)',
	LIST_TYPE_DESCR_DE  COMMENT 'A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc. (Description in German)',
	LIST_TYPE_DESCR_EN  COMMENT 'A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc. (Description in English)',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
)COMMENT='The listing types distinguishes the regular assortment from seasonal products, promotional items, etc.'
AS SELECT
	 main.LIST_TYPE_CD
	,main.LIST_TYPE_DESCR
	,main.LIST_TYPE_DESCR_DE
	,main.LIST_TYPE_DESCR_EN
	,main.DWH_CREATED_TMSP
	,main.DWH_UPDATED_TMSP
	,main.DWH_LOAD_ID
	,main.DWH_NODE_CD
	FROM CORE_DIM.T_DIM_LISTING_TYPE_1 main
;