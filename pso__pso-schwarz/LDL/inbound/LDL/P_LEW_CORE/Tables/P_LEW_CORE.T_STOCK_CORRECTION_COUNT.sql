CREATE TABLE P_LEW_CORE.T_STOCK_CORRECTION_COUNT (
CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
LOC_SID_WH NUMBER(38,0) NOT NULL COMMENT 'warehouse, foreign key on location, in general the initiator of requests ',
REQUEST_ID NUMBER(38,0) NOT NULL COMMENT 'Inventory ID',
ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg)',
CNT_STATUS_ID NUMBER(38,0) COMMENT 'status of the counting of the item from not counted, not valid article , counted, counted at store',
ACT_ITEM_CNT NUMBER(38,10) COMMENT 'Calculated number of items at the day end based on the counted number of items as result of the counting request',
CALC_ITEM_CNT NUMBER(38,10) COMMENT 'calculated number of items at the day end based on the available data without the counting request results',
DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
CONSTRAINT PK_T_STOCK_CORRECTION_REQUEST PRIMARY KEY (REQUEST_ID, LOC_SID_WH)
NOT ENFORCED
)
COMMENT = '$Revision: 0000 $. table contains counted items for counting requests for stores to correct item related stock information;
Source: WAWI table T438_PART_INV_DET';