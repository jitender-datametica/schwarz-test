create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_STATUS_TYPE_1 (
	PROD_STATUS_CATEG_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of status_1 lifecycle for products.',
	PROD_STATUS_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the lifecycle status_1 for products.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_STATUS_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the lifecycle status_1 for products.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PRODUCT_STATUS_TYPE primary key (PROD_STATUS_TYPE_CD, LANG_CD, PROD_STATUS_CATEG_CD)
)COMMENT='This minor entity defines the lifecycle status_1 for products. There may be more than one lifecycle for a given product, e.g. the buying status_1 and the workflow status_1 for non-food items or the status_1 in the retail system. The lifecycle is identified by the status_1 category code. For a given status_1 category, a product has one status_1 code.'
;