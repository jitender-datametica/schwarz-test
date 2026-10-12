create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_PACKING_TYPE_1 (
	PACKING_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way, how a product is packed.',
	PACKING_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the way how a product is packed in group language, i.e. in German.',
	PACKING_TYPE_DESCR_DE VARCHAR(250) COMMENT 'A textual description for the way how a product is packed in German.',
	PACKING_TYPE_DESCR_EN VARCHAR(250) COMMENT 'A textual description for the way how a product is packed in English.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_PACKING_TYPE primary key (PACKING_TYPE_CD)
)COMMENT='This minor dimension defines the ways how a product (item_1) can be packed. E.g. box, bag, tin, ...'
;