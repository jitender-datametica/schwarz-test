create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_ITEM_STORE_STORAGE_STOCK_HIST_1 cluster by (
     CLIENT_ID
     ,DWH_VALID_FROM
     ,DWH_VALID_TO 
)(
	CLIENT_ID NUMBER(38,0) NOT NULL,
	ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key ITEM_1 (eindeutig ueber alle Laender/Mandanten hinweg).',
	LOC_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key LOCATION_1 (eindeutig über alle Länder / Mandanten hinweg).',
	STORE_STORAGE_QTY NUMBER(38,5) NOT NULL COMMENT 'column contains the piece quantity for non food items in the storage of the store.\n            WAWI: t462_store_storage_fes.c462_pieces_storageroom',
	DELETED_FG NUMBER(38,0) NOT NULL COMMENT 'Loeschflag (0/1) -- hier immer 0, das geloeschte Satze bei Bestaenden eliminiert werden (broken timeline history)',
	DWH_VALID_FROM DATE NOT NULL COMMENT 'Datum der Bestandsaufnahme; SAP-BW: the extractor does not contain the stock_date, therefore extraction_date is used; ELWIS: stock_dat',
	DWH_VALID_TO DATE NOT NULL COMMENT 'Bisdatum des Bestandes (gefullt nach Umschaltung auf historisches Laden als Zustandsgro?e)',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	constraint PK_T_ITEM_STORE_STORAGE_STOCK_HIST primary key (ITEM_SID, LOC_SID, DWH_VALID_FROM)
)COMMENT='stock data on the level store, day and item_1 for stock in the store storage. the overall stock in t_item_ocation_stock_hist is the sum of the stock in the store storage and the store sales_1 room.\n             WAWI: t_462_store_storage_fes (non food data only)\n             this data is separated from t_item_ocation_stock_hist due to the complexity of the ETL process.'
;
