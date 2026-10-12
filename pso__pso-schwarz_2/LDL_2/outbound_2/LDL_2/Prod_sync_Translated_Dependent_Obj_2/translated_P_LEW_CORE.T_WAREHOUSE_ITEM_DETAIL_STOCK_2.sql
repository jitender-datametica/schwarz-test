CREATE OR REPLACE TABLE ldl_p_lew_core.t_warehouse_item_detail_stock_2 (
client_id INTEGER NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
wh_loc_sid INTEGER NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION.'),
wh_stock_pos_nr STRING(100) NOT NULL
OPTIONS(description='It is a technical identifier, it does not have any meaning about the physical item.\n            After replenishment or picking the quantity of the stock at these numbers is updated.\n            \n            In EWM: columns GUIDPARENT||GUIDSTOCK from NEWEWM_PHYSICALSTOCK, In LPV: column BESTAND_ID from BESTAND.\n            \n            In EWM one wh_stock_pos_nr can represent an article or a display (a set of articles)\n            In LPV one wh_stock_pos_nr can represent an article.'),
wh_stock_item_seq INTEGER NOT NULL
OPTIONS(description='Sequence number for the distinctive items available at a particular warehouse stock position.\n            \n            In LPV this sequence is always 1.\n            In EWM, when wh_stock_pos_nr represents a display, each sequence value is an item_2 in the display\n            else this sequence is 1.'),
cal_dt DATE NOT NULL
OPTIONS(description='The calender date when the snapshot_2 was taken / for which the record is valid. The warehouse snapshot_2 at the end of the day / EOB of a day is used.'),
item_sid INTEGER NOT NULL
OPTIONS(description='Artikel_2; FK auf ITEM_2; SAP-Retail: mard.matnr; SAP-BW: t_bw_z_ds_mard.matnr'),
handling_unit_nr STRING(100)
OPTIONS(description='Handling unit_2 identifier. Products packed inside or on a HU. HU can be pallets / trolleys / TKT. HU is needed to move products.'),
handling_unit_type_cd STRING(100) OPTIONS(description='Handling unit_2 type code.'),
wh_storage_area_nr STRING(100)
OPTIONS(description='Storage Area in a WH. In storage, each area consist of one or more storage spaces.'),
wh_storage_space_nr STRING(100)
OPTIONS(description='Destination storage space in the WH where the pallet is placed, e.g. bin, lane, door, etc.'),
stock_best_before_dt DATE OPTIONS(description='Best before date of a product.'),
batch_nr STRING(100)
OPTIONS(description='Identifies the specific batch or lot number assigned to a quantity of material. A batch represents a homogeneous unit_2 of material produced or received in a single production run or delivery. This allows for tracking and managing distinct groups of materials with shared characteristics, crucial for quality control, traceability, and potential recalls. The batch number acts as a unique identifier for a specific group of materials within the overall stock.'),
latest_store_deliv_dt DATE
OPTIONS(description='The latest date a product can be delivered to a store while still adhering to its shelf-life requirements. \n            It is computed by subtracting the minimum acceptable remaining shelf life in the warehouse. \n            \n            LPV: (Minimum days before the BBD is reached / Restlaufzeit) from the Best Before Date (BBD, represented by BESTAND.P5 - AST.V4). \n            EWM: PHYSICALSTOCK.VFDAT - (MARC.ZZ_RLZB * ZEWM_RLZB_UOM.ZDAYS)'),
case_qty NUMERIC(29,5)
OPTIONS(description='Available quantity of the item_2 in cases which are currently in the stock position.'),
item_rcv_dt DATE
OPTIONS(description='The recorded date of confirmed delivery and acceptance for the item_2 belonging to a particular pallet (Wareneingangsdatum).'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (wh_loc_sid, wh_stock_pos_nr, wh_stock_item_seq, cal_dt) NOT ENFORCED
)
OPTIONS(description='This table stores detailed information about item_2 stock within a warehouse.\n             The primary key consist of 4 columns: wh_loc_sid (key identifying the warehouse location_2), wh_stock_pos_nr (key for the specific position on the stock inventory list, it does not have any meaning about physical item_2), wh_stock_item_seq (Sequence number for the distinctive items available at a particular warehouse stock position), cal_dt (calendar_2 date).\n             Each record can have additional information about handling unit_2 (item_2 with pallett), best before date, batch and similar informations.');