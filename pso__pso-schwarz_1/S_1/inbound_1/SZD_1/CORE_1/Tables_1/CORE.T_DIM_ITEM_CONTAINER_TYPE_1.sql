CREATE TABLE CORE.T_DIM_ITEM_CONTAINER_TYPE_1 (
	ITEM_CONTAINER_TYPE_CD VARCHAR(250) NOT NULL COMMENT 'The code of a container which can be foreign or own container',
	ITEM_CONTAINER_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'The description of a container which can be foreign or own container',
	ITEM_CONTAINER_TYPE_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'The description of a container which can be foreign or own container in German',
	ITEM_CONTAINER_TYPE_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'The description of a container which can be foreign or own container in English',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_ITEM_CONTAINER_TYPE PRIMARY KEY (ITEM_CONTAINER_TYPE_CD) NOT ENFORCED
)COMMENT='This minor dimension defines the item_1 container types of deposits e.g. own brand_1 ord foreign brand_1'
;