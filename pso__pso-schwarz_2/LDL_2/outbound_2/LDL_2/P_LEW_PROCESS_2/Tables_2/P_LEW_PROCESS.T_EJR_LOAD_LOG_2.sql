CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_ejr_load_log_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale; FK auf LOCATION_2'),
orig_store_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Originale Filialnummer aus der Kasse'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Bon-Datum'),
receipt_id BIGNUMERIC(38,0) OPTIONS(description='Bon-Nummer'),
receipt_transactiontype_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Transaktionstypnummer zur Identifierung des Bontyps'),
uuid STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige JMS-Message-ID zur Identifizierung des Bons'),
core BIGNUMERIC(38,0) OPTIONS(description='Flag für Core-Beladung des Bons'),
solace BIGNUMERIC(38,0) OPTIONS(description='Flag für Datenquelle des Bons aus SOLACE'),
dayend_completion BIGNUMERIC(38,0) OPTIONS(description='Flag für Bon in Tagesabschlussbericht der Kasse'),
dwh_load_id BIGNUMERIC(38,0) OPTIONS(description='Load_id des Ladeprozesses'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH'),
dwh_updated DATETIME OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH')
);