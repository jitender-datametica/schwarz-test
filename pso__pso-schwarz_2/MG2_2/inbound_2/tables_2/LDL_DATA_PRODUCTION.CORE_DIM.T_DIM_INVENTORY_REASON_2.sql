create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_INVENTORY_REASON_2 (
	INV_REASON_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for the reason why an inventory was initiated.',
	INV_REASON_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the reason why an inventory was initiated. (Description in group language, i.e. in German)',
	INV_REASON_DESCR_DE VARCHAR(250) COMMENT 'A textual description for the reason why an inventory was initiated. (Description in German)',
	INV_REASON_DESCR_EN VARCHAR(250) COMMENT 'A textual description for the reason why an inventory was initiated. (Description in English)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_INVENTORY_REASON primary key (INV_REASON_ID)
)COMMENT='This minor dimension defines the reason why an inventory was initiated. (The inventory reason only applies to partial inventories.)'
;