create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_WAREHOUSE_ITEM_PICK_STORAGE_SPACE (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
	WH_LOC_SID NUMBER(38,0) NOT NULL COMMENT 'Warehouse; FK auf LOCATION.',
	ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Artikel; FK auf ITEM; SAP-Retail: mard.matnr; SAP-BW: t_bw_z_ds_mard.matnr',
	WH_PICK_STORAGE_SPACE_NR VARCHAR(100) NOT NULL COMMENT 'Picking storage space in the WH where the pallet is placed, e.g. bin, lane, door, etc.',
	DELETED_FG NUMBER(38,0) NOT NULL COMMENT 'Deleted flag (0/1) - here always 0, meaning that deleted records for stocks are removed (broken timeline history).',
	DWH_VALID_FROM DATE NOT NULL COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
	DWH_VALID_TO DATE NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_REF_WAREHOUSE_ITEM_PICK_STORAGE_SPACE primary key (WH_LOC_SID, ITEM_SID, WH_PICK_STORAGE_SPACE_NR, DWH_VALID_FROM)
)COMMENT='The table contains information about picking places for each item. One item can be picked from various picking places. One picking place can be reused for different items over time.'
;
