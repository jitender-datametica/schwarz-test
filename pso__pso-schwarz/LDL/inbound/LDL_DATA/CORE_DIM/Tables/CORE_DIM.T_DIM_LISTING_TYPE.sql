CREATE TABLE CORE_DIM.T_DIM_LISTING_TYPE (
	LIST_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the listing type, e.g. regular assortment, seasonal products, promotional items, etc.',
	LIST_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc. (Description in group language, i.e. in German)',
	LIST_TYPE_DESCR_DE VARCHAR(250) COMMENT 'A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc. (Description in German)',
	LIST_TYPE_DESCR_EN VARCHAR(250) COMMENT 'A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc. (Description in English)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	CONSTRAINT PK_T_DIM_LISTING_TYPE PRIMARY KEY (LIST_TYPE_CD)
)COMMENT='The listing types distinguishes the regular assortment from seasonal products, promotional items, etc.'
;