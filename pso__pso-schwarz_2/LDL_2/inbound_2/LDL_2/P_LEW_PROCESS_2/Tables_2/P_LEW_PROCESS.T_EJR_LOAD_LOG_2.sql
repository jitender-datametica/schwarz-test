CREATE TABLE P_LEW_PROCESS.T_EJR_LOAD_LOG_2 (
CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
LOC_SID NUMBER(38,0) NOT NULL COMMENT 'Filiale; FK auf LOCATION_2',
ORIG_STORE_NR NUMBER(38,0) NOT NULL COMMENT 'Originale Filialnummer aus der Kasse',
DWH_CAL_DT DATE NOT NULL COMMENT 'Bon-Datum',
RECEIPT_ID NUMBER(38,0) COMMENT 'Bon-Nummer',
RECEIPT_TRANSACTIONTYPE_ID  VARCHAR(3) COLLATE 'en-ci' COMMENT 'Transaktionstypnummer zur Identifierung des Bontyps', 
UUID VARCHAR(100) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige JMS-Message-ID zur Identifizierung des Bons',
CORE NUMBER(38,0) COMMENT 'Flag für Core-Beladung des Bons',
SOLACE NUMBER(38,0) COMMENT 'Flag für Datenquelle des Bons aus SOLACE',
DAYEND_COMPLETION NUMBER(38,0) COMMENT 'Flag für Bon in Tagesabschlussbericht der Kasse',
DWH_LOAD_ID NUMBER(38,0) COMMENT 'Load_id des Ladeprozesses',
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH',
DWH_UPDATED TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH'  
   )
;