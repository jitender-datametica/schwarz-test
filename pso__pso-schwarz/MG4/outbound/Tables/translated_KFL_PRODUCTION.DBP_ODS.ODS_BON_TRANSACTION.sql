DROP TABLE IF EXISTS kfl_production_dbp_ods.ods_bon_transaction;
CREATE OR REPLACE TABLE kfl_production_dbp_ods.ods_bon_transaction (
bon_id STRING(25) NOT NULL OPTIONS(description='eindeutige ID eines Bons, generierter Hashwert'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land'),
kasse_nr INTEGER NOT NULL OPTIONS(description='Nummer der Kasse'),
bon_beginn DATETIME OPTIONS(description='Start-Zeitpunkt des Bons'),
datei_name STRING(255)
OPTIONS(description='Bezeichnung der Ursprungsdatei zwecks Rueckverfolgbarkeit der Daten. Mit CAMSET_L komprimieren'),
kassierer_nr STRING(4) OPTIONS(description='Nummer des Kassierers'),
cancel_fg INTEGER NOT NULL OPTIONS(description='Das Flag kennzeichnet einen Abbruchvorgang'),
transaction_name STRING(120) OPTIONS(description='Textfeld fuer die Transaktion, wie Kassen-An-, Abmeldung'),
bon_nr INTEGER NOT NULL
OPTIONS(description='Die Bonnummer des Bons (ist eine fortlaufende Nummer die in der Kasse generiert wird, im normal Fall ist diese Nummer pro tag und Kasse Unique)'),
bon_ende DATETIME OPTIONS(description='Ende-Zeitpunkt des Bons'),
bon_booking DATETIME
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. fuer artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine Kasse offline war. Kann NULL sein'),
suspended_fg INTEGER NOT NULL
OPTIONS(description='Flag kennzeichnet einen Suspended-Status der Transaktion. 1 = suspended'),
training_fg INTEGER NOT NULL
OPTIONS(description='Das Flag kennzeichnet, ob die Transaktion im Trainings-Modus durchgefuehrt wurde.'),
kasse_typ_id INTEGER
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default(Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'),
kpos_kasse_typ STRING(10) OPTIONS(description='Im Kassensystem KPOS verwendete nicht-numerische Kassentypen'),
kassensystem_name STRING(10)
OPTIONS(description='Es wird nur drei hartkodierte Auspraegungen geben! KPOS, LUCAS, POSITION'),
kpos_transaction_name STRING(255)
OPTIONS(description='Textfeld fuer die Transaktion speziell fuer Kassensystem KPOS, wie Kassen-An-, Abmeldung. Per CAMSET compressen'),
kpos_transaction_status INTEGER OPTIONS(description='Status Kassensystem KPOS. 1 = true, 0 = false'),
dat_booking DATE
OPTIONS(description='Buchungsdatum des Bons aus businessDayDate. Redundant zu bon_booking aus Performancegruenden'),
bon_nr_fiscal INTEGER
OPTIONS(description='In Kombination mit Kasse und Markt einmalig kombiniertes Feld (Fiscal invoice receipt)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
bon_status_cd STRING(100) OPTIONS(description='Gibt den Status des Bons an. Quelle: Kassen XML ReceiptState'),
bon_abbruch_grund_txt STRING(100)
OPTIONS(description='Gibt den Grund für einen Bonabbruch an. Quelle: Kassen XML CancelReason'),
PRIMARY KEY (bon_id, bon_dat, wup_id, mandant_id) NOT ENFORCED
) CLUSTER BY mandant_id, bon_dat, wup_id
OPTIONS(description='ODS - Hier werden die An- und Abmeldungen an den Kassen hinterlegt');