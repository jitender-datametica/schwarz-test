/* --------------------------------------------------------------------------------
   DDL for table: t_item_store_storage_stock_hist
   generated from Powerdesigner on Donnerstag, 1. Dezember 2022 11:46:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_store_storage_stock_hist (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg).'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION (eindeutig über alle Länder / Mandanten hinweg).'),
store_storage_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='column contains the piece quantity for non food items in the storage of the store.            WAWI: t462_store_storage_fes.c462_pieces_storageroom'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Loeschflag (0/1) -- hier immer 0, das geloeschte Satze bei Bestaenden eliminiert werden (broken timeline history)'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Datum der Bestandsaufnahme; SAP-BW: the extractor does not contain the stock_date, therefore extraction_date is used; ELWIS: stock_dat'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Bisdatum des Bestandes (gefullt nach Umschaltung auf historisches Laden als Zustandsgro?e)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, loc_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id, dwh_valid_from, dwh_valid_to
OPTIONS(description='stock data on the level store, day and item for stock in the store storage. the overall stock in t_item_ocation_stock_hist is the sum of the stock in the store storage and the store sales room.             WAWI: t_462_store_storage_fes (non food data only)             this data is separated from t_item_ocation_stock_hist due to the complexity of the ETL process.');