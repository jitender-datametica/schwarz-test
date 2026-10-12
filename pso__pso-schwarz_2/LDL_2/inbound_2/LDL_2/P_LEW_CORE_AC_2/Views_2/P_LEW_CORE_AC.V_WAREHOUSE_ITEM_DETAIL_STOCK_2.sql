create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE_AC.V_WAREHOUSE_ITEM_DETAIL_STOCK_2(
	CLIENT_ID COMMENT 'DWH-Mandant_2; FK auf CLIENT',
	WH_LOC_SID COMMENT 'Warehouse; FK auf LOCATION.',
	WH_STOCK_POS_NR COMMENT 'It is a technical identifier, it does not have any meaning about the physical item.\nAfter replenishment or picking the quantity of the stock at these numbers is updated.\n\nIn EWM: columns GUIDPARENT||GUIDSTOCK from NEWEWM_PHYSICALSTOCK, In LPV: column BESTAND_ID from BESTAND.\n\nIn EWM one wh_stock_pos_nr can represent an article or a display (a set of articles)\nIn LPV one wh_stock_pos_nr can represent an article.',
	WH_STOCK_ITEM_SEQ COMMENT 'Sequence number for the distinctive items available at a particular warehouse stock position.\n\nIn LPV this sequence is always 1.\nIn EWM, when wh_stock_pos_nr represents a display, each sequence value is an item_2 in the display\nelse this sequence is 1.',
	CAL_DT COMMENT 'The calender date when the snapshot_2 was taken / for which the record is valid. The warehouse snapshot_2 at the end of the day / EOB of a day is used.',
	ITEM_SID COMMENT 'Artikel_2; FK auf ITEM_2; SAP-Retail: mard.matnr; SAP-BW: t_bw_z_ds_mard.matnr',
	HANDLING_UNIT_NR COMMENT 'Handling unit_2 identifier. Products packed inside or on a HU. HU can be pallets / trolleys / TKT. HU is needed to move products.',
	HANDLING_UNIT_TYPE_CD COMMENT 'Handling unit_2 type code.',
	WH_STORAGE_AREA_NR COMMENT 'Storage Area in a WH. In storage, each area consist of one or more storage spaces.',
	WH_STORAGE_SPACE_NR COMMENT 'Destination storage space in the WH where the pallet is placed, e.g. bin, lane, door, etc.',
	STOCK_BEST_BEFORE_DT COMMENT 'Best before date of a product.',
	BATCH_NR COMMENT 'Identifies the specific batch or lot number assigned to a quantity of material. A batch represents a homogeneous unit_2 of material produced or received in a single production run or delivery. This allows for tracking and managing distinct groups of materials with shared characteristics, crucial for quality control, traceability, and potential recalls. The batch number acts as a unique identifier for a specific group of materials within the overall stock.',
	LATEST_STORE_DELIV_DT COMMENT 'The latest date a product can be delivered to a store while still adhering to its shelf-life requirements. \nIt is computed by subtracting the minimum acceptable remaining shelf life in the warehouse. \n\nLPV: (Minimum days before the BBD is reached / Restlaufzeit) from the Best Before Date (BBD, represented by BESTAND.P5 - AST.V4). \nEWM: PHYSICALSTOCK.VFDAT - (MARC.ZZ_RLZB * ZEWM_RLZB_UOM.ZDAYS)',
	CASE_QTY COMMENT 'Available quantity of the item_2 in cases which are currently in the stock position.',
	ITEM_RCV_DT COMMENT 'The recorded date of confirmed delivery and acceptance for the item_2 belonging to a particular pallet (Wareneingangsdatum).',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table stores detailed information about item_2 stock within a warehouse.\nThe primary key consist of 4 columns: wh_loc_sid (key identifying the warehouse location_2), wh_stock_pos_nr (key for the specific position on the stock inventory list, it does not have any meaning about physical item_2), wh_stock_item_seq (Sequence number for the distinctive items available at a particular warehouse stock position), cal_dt (calendar_2 date).\nEach record can have additional information about handling unit_2 (item_2 with pallett), best before date, batch and similar informations.'
 as SELECT
   client_id
  ,wh_loc_sid
  ,wh_stock_pos_nr
  ,wh_stock_item_seq
  ,cal_dt
  ,item_sid
  ,handling_unit_nr
  ,handling_unit_type_cd
  ,wh_storage_area_nr
  ,wh_storage_space_nr
  ,stock_best_before_dt
  ,batch_nr
  ,latest_store_deliv_dt
  ,case_qty
  ,item_rcv_dt
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_WAREHOUSE_ITEM_DETAIL_STOCK_2
;
