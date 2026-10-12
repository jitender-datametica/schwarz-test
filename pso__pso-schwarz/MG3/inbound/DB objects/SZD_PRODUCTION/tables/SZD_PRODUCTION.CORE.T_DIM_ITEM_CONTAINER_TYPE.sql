create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_ITEM_CONTAINER_TYPE (
	ITEM_CONTAINER_TYPE_CD VARCHAR(250) NOT NULL COMMENT 'The code of a container which can be foreign or own container',
	ITEM_CONTAINER_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'The description of a container which can be foreign or own container',
	ITEM_CONTAINER_TYPE_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'The description of a container which can be foreign or own container in German',
	ITEM_CONTAINER_TYPE_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'The description of a container which can be foreign or own container in English',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_DIM_ITEM_CONTAINER_TYPE primary key (ITEM_CONTAINER_TYPE_CD)
)COMMENT='This minor dimension defines the item container types of deposits e.g. own brand ord foreign brand'
;