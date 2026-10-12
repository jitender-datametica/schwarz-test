DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ODS.ODS_BON_TRANSACTION;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ODS.ODS_BON_TRANSACTION (
BON_ID STRING(25) NOT NULL OPTIONS(description='eindeutige ID eines Bons, generierter Hashwert'),
BON_DAT DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land'),
KASSE_NR INTEGER NOT NULL OPTIONS(description='Nummer der Kasse'),
BON_BEGINN DATETIME OPTIONS(description='Start-Zeitpunkt des Bons'),
DATEI_NAME STRING(255)
OPTIONS(description='Bezeichnung der Ursprungsdatei zwecks Rueckverfolgbarkeit der Daten. Mit CAMSET_L komprimieren'),
KASSIERER_NR STRING(4) OPTIONS(description='Nummer des Kassierers'),
CANCEL_FG INTEGER NOT NULL OPTIONS(description='Das Flag kennzeichnet einen Abbruchvorgang'),
TRANSACTION_NAME STRING(120) OPTIONS(description='Textfeld fuer die Transaktion, wie Kassen-An-, Abmeldung'),
BON_NR INTEGER NOT NULL
OPTIONS(description='Die Bonnummer des Bons (ist eine fortlaufende Nummer die in der Kasse generiert wird, im normal Fall ist diese Nummer pro tag und Kasse Unique)'),
BON_ENDE DATETIME OPTIONS(description='Ende-Zeitpunkt des Bons'),
BON_BOOKING DATETIME
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. fuer artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine Kasse offline war. Kann NULL sein'),
SUSPENDED_FG INTEGER NOT NULL
OPTIONS(description='Flag kennzeichnet einen Suspended-Status der Transaktion. 1 = suspended'),
TRAINING_FG INTEGER NOT NULL
OPTIONS(description='Das Flag kennzeichnet, ob die Transaktion im Trainings-Modus durchgefuehrt wurde.'),
KASSE_TYP_ID INTEGER
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default(Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'),
KPOS_KASSE_TYP STRING(10) OPTIONS(description='Im Kassensystem KPOS verwendete nicht-numerische Kassentypen'),
KASSENSYSTEM_NAME STRING(10)
OPTIONS(description='Es wird nur drei hartkodierte Auspraegungen geben! KPOS, LUCAS, POSITION'),
KPOS_TRANSACTION_NAME STRING(255)
OPTIONS(description='Textfeld fuer die Transaktion speziell fuer Kassensystem KPOS, wie Kassen-An-, Abmeldung. Per CAMSET compressen'),
KPOS_TRANSACTION_STATUS INTEGER OPTIONS(description='Status Kassensystem KPOS. 1 = true, 0 = false'),
DAT_BOOKING DATE
OPTIONS(description='Buchungsdatum des Bons aus businessDayDate. Redundant zu bon_booking aus Performancegruenden'),
BON_NR_FISCAL INTEGER
OPTIONS(description='In Kombination mit Kasse und Markt einmalig kombiniertes Feld (Fiscal invoice receipt)'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
BON_STATUS_CD STRING(100) OPTIONS(description='Gibt den Status des Bons an. Quelle: Kassen XML ReceiptState'),
BON_ABBRUCH_GRUND_TXT STRING(100)
OPTIONS(description='Gibt den Grund für einen Bonabbruch an. Quelle: Kassen XML CancelReason'),
PRIMARY KEY (BON_ID, BON_DAT, WUP_ID, MANDANT_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID, BON_DAT, WUP_ID
OPTIONS(description='ODS - Hier werden die An- und Abmeldungen an den Kassen hinterlegt');