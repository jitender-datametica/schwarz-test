create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_WAWI_ITEM_VARIANT_STATUS_1 (
	WAWI_ITEM_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item_1 variant.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	WAWI_ITEM_VARIANT_STATUS_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for the lifecycle status_1 for Wawi items.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_WAWI_ITEM_VARIANT_STATUS primary key (WAWI_ITEM_VARIANT_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the lifecycle status_1 of Wawi item_1 variants. This status_1 applies to the entire country_1 organization for which the Wawi item_1 is defined.'
;