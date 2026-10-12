create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE_AC.V_REF_WAREHOUSE_ITEM_PICK_STORAGE_SPACE(
	CLIENT_ID COMMENT 'DWH-Mandant; FK auf CLIENT',
	WH_LOC_SID COMMENT 'Warehouse; FK auf LOCATION.',
	ITEM_SID COMMENT 'Artikel; FK auf ITEM; SAP-Retail: mard.matnr; SAP-BW: t_bw_z_ds_mard.matnr',
	WH_PICK_STORAGE_SPACE_NR COMMENT 'Picking storage space in the WH where the pallet is placed, e.g. bin, lane, door, etc.',
	DELETED_FG COMMENT 'Deleted flag (0/1) - here always 0, meaning that deleted records for stocks are removed (broken timeline history).',
	DWH_VALID_FROM COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
	DWH_VALID_TO COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='The table contains information about picking places for each item. One item can be picked from various picking places. One picking place can be reused for different items over time.'
 as SELECT
   client_id
  ,wh_loc_sid
  ,item_sid
  ,wh_pick_storage_space_nr
  ,deleted_fg
  ,dwh_valid_from
  ,dwh_valid_to
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_WAREHOUSE_ITEM_PICK_STORAGE_SPACE
;
