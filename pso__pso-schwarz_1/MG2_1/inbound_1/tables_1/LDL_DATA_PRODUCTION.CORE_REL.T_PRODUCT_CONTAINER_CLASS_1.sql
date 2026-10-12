create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PRODUCT_CONTAINER_CLASS_1 (
	PROD_CONTAINER_CLASS_CD VARCHAR(20) NOT NULL COMMENT 'The code distinguishing between module containers, area containers and technical containers.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_CONTAINER_CLASS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the product container class.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PRODUCT_CONTAINER_CLASS primary key (PROD_CONTAINER_CLASS_CD, LANG_CD)
)COMMENT='This minor entity distinguishes between module containers, area containers and technical containers. A module container contains a set of related products. If a module container is assigned to a store, the store offers all these products. An area container is of a specific size (small / medium / large / etc.). Area containers are cumulative. I.e. a product is assigned to only one container. Depending on the sales_1 area allocated in the store, all containers up to the chosen size get allocated to the store So if a store has a sales_1 area of size Large for a specific category, it gets the containers for Small, Medium and Large assigned. Technical containers serve for test_1 purposes or as temporary containers, e.g. in case of retro-fitting of a store.'
;