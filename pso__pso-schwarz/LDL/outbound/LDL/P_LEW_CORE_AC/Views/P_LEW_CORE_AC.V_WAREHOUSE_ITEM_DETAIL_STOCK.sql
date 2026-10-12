CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_warehouse_item_detail_stock (client_id
OPTIONS(description='DWH-Mandant; FK auf CLIENT'), wh_loc_sid OPTIONS(description='Warehouse; FK auf LOCATION.'),
wh_stock_pos_nr
OPTIONS(description='It is a technical identifier, it does not have any meaning about the physical item.\nAfter replenishment or picking the quantity of the stock at these numbers is updated.\n\nIn EWM: columns GUIDPARENT||GUIDSTOCK from NEWEWM_PHYSICALSTOCK, In LPV: column BESTAND_ID from BESTAND.\n\nIn EWM one wh_stock_pos_nr can represent an article or a display (a set of articles)\nIn LPV one wh_stock_pos_nr can represent an article.'),
wh_stock_item_seq
OPTIONS(description='Sequence number for the distinctive items available at a particular warehouse stock position.\n\nIn LPV this sequence is always 1.\nIn EWM, when wh_stock_pos_nr represents a display, each sequence value is an item in the display\nelse this sequence is 1.'),
cal_dt
OPTIONS(description='The calender date when the snapshot was taken / for which the record is valid. The warehouse snapshot at the end of the day / EOB of a day is used.'),
item_sid OPTIONS(description='Artikel; FK auf ITEM; SAP-Retail: mard.matnr; SAP-BW: t_bw_z_ds_mard.matnr'),
handling_unit_nr
OPTIONS(description='Handling unit identifier. Products packed inside or on a HU. HU can be pallets / trolleys / TKT. HU is needed to move products.'),
handling_unit_type_cd OPTIONS(description='Handling unit type code.'), wh_storage_area_nr
OPTIONS(description='Storage Area in a WH. In storage, each area consist of one or more storage spaces.'),
wh_storage_space_nr
OPTIONS(description='Destination storage space in the WH where the pallet is placed, e.g. bin, lane, door, etc.'),
stock_best_before_dt OPTIONS(description='Best before date of a product.'), batch_nr
OPTIONS(description='Identifies the specific batch or lot number assigned to a quantity of material. A batch represents a homogeneous unit of material produced or received in a single production run or delivery. This allows for tracking and managing distinct groups of materials with shared characteristics, crucial for quality control, traceability, and potential recalls. The batch number acts as a unique identifier for a specific group of materials within the overall stock.'),
latest_store_deliv_dt
OPTIONS(description='The latest date a product can be delivered to a store while still adhering to its shelf-life requirements.\nIt is computed by subtracting the minimum acceptable remaining shelf life in the warehouse.\n\nLPV: (Minimum days before the BBD is reached / Restlaufzeit) from the Best Before Date (BBD, represented by BESTAND.P5 - AST.V4).\nEWM: PHYSICALSTOCK.VFDAT - (MARC.ZZ_RLZB * ZEWM_RLZB_UOM.ZDAYS)'),
case_qty OPTIONS(description='Available quantity of the item in cases which are currently in the stock position.'),
item_rcv_dt
OPTIONS(description='The recorded date of confirmed delivery and acceptance for the item belonging to a particular pallet (Wareneingangsdatum).'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table stores detailed information about item stock within a warehouse.\nThe primary key consist of 4 columns: wh_loc_sid (key identifying the warehouse location), wh_stock_pos_nr (key for the specific position on the stock inventory list, it does not have any meaning about physical item), wh_stock_item_seq (Sequence number for the distinctive items available at a particular warehouse stock position), cal_dt (calendar date).\nEach record can have additional information about handling unit (item with pallett), best before date, batch and similar informations.`)
AS SELECT client_id,
 wh_loc_sid,
 wh_stock_pos_nr,
 wh_stock_item_seq,
 cal_dt,
 item_sid,
 handling_unit_nr,
 handling_unit_type_cd,
 wh_storage_area_nr,
 wh_storage_space_nr,
 stock_best_before_dt,
 batch_nr,
 latest_store_deliv_dt,
 case_qty,
 item_rcv_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_warehouse_item_detail_stock;