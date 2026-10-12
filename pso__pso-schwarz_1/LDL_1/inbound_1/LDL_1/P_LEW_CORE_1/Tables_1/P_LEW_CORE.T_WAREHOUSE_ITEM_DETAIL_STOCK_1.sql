create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_WAREHOUSE_ITEM_DETAIL_STOCK_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
	WH_LOC_SID NUMBER(38,0) NOT NULL COMMENT 'Warehouse; FK auf LOCATION.',
	WH_STOCK_POS_NR VARCHAR(100) NOT NULL COMMENT 'It is a technical identifier, it does not have any meaning about the physical item.\n            After replenishment or picking the quantity of the stock at these numbers is updated.\n            \n            In EWM: columns GUIDPARENT||GUIDSTOCK from NEWEWM_PHYSICALSTOCK, In LPV: column BESTAND_ID from BESTAND.\n            \n            In EWM one wh_stock_pos_nr can represent an article or a display (a set of articles)\n            In LPV one wh_stock_pos_nr can represent an article.',
	WH_STOCK_ITEM_SEQ NUMBER(38,0) NOT NULL COMMENT 'Sequence number for the distinctive items available at a particular warehouse stock position.\n            \n            In LPV this sequence is always 1.\n            In EWM, when wh_stock_pos_nr represents a display, each sequence value is an item_1 in the display\n            else this sequence is 1.',
	CAL_DT DATE NOT NULL COMMENT 'The calender date when the snapshot_1 was taken / for which the record is valid. The warehouse snapshot_1 at the end of the day / EOB of a day is used.',
	ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1; FK auf ITEM_1; SAP-Retail: mard.matnr; SAP-BW: t_bw_z_ds_mard.matnr',
	HANDLING_UNIT_NR VARCHAR(100) COMMENT 'Handling unit_1 identifier. Products packed inside or on a HU. HU can be pallets / trolleys / TKT. HU is needed to move products.',
	HANDLING_UNIT_TYPE_CD VARCHAR(100) COMMENT 'Handling unit_1 type code.',
	WH_STORAGE_AREA_NR VARCHAR(100) COMMENT 'Storage Area in a WH. In storage, each area consist of one or more storage spaces.',
	WH_STORAGE_SPACE_NR VARCHAR(100) COMMENT 'Destination storage space in the WH where the pallet is placed, e.g. bin, lane, door, etc.',
	STOCK_BEST_BEFORE_DT DATE COMMENT 'Best before date of a product.',
	BATCH_NR VARCHAR(100) COMMENT 'Identifies the specific batch or lot number assigned to a quantity of material. A batch represents a homogeneous unit_1 of material produced or received in a single production run or delivery. This allows for tracking and managing distinct groups of materials with shared characteristics, crucial for quality control, traceability, and potential recalls. The batch number acts as a unique identifier for a specific group of materials within the overall stock.',
	LATEST_STORE_DELIV_DT DATE COMMENT 'The latest date a product can be delivered to a store while still adhering to its shelf-life requirements. \n            It is computed by subtracting the minimum acceptable remaining shelf life in the warehouse. \n            \n            LPV: (Minimum days before the BBD is reached / Restlaufzeit) from the Best Before Date (BBD, represented by BESTAND.P5 - AST.V4). \n            EWM: PHYSICALSTOCK.VFDAT - (MARC.ZZ_RLZB * ZEWM_RLZB_UOM.ZDAYS)',
	CASE_QTY NUMBER(38,5) COMMENT 'Available quantity of the item_1 in cases which are currently in the stock position.',
	ITEM_RCV_DT DATE COMMENT 'The recorded date of confirmed delivery and acceptance for the item_1 belonging to a particular pallet (Wareneingangsdatum).',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_WAREHOUSE_ITEM_DETAIL_STOCK primary key (WH_LOC_SID, WH_STOCK_POS_NR, WH_STOCK_ITEM_SEQ, CAL_DT)
)COMMENT='This table stores detailed information about item_1 stock within a warehouse.\n             The primary key consist of 4 columns: wh_loc_sid (key identifying the warehouse location_1), wh_stock_pos_nr (key for the specific position on the stock inventory list, it does not have any meaning about physical item_1), wh_stock_item_seq (Sequence number for the distinctive items available at a particular warehouse stock position), cal_dt (calendar_1 date).\n             Each record can have additional information about handling unit_1 (item_1 with pallett), best before date, batch and similar informations.'
;
