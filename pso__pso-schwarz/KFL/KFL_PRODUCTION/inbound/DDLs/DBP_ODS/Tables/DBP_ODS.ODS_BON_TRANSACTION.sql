create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_ODS.ODS_BON_TRANSACTION cluster by (
     MANDANT_ID,
     BON_DAT,
     WUP_ID 
)(
	BON_ID VARCHAR(25) NOT NULL COMMENT 'eindeutige ID eines Bons, generierter Hashwert',
	BON_DAT DATE NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land',
	KASSE_NR NUMBER(38,0) NOT NULL COMMENT 'Nummer der Kasse',
	BON_BEGINN TIMESTAMP_NTZ(9) COMMENT 'Start-Zeitpunkt des Bons',
	DATEI_NAME VARCHAR(255) COMMENT 'Bezeichnung der Ursprungsdatei zwecks Rueckverfolgbarkeit der Daten. Mit CAMSET_L komprimieren',
	KASSIERER_NR VARCHAR(4) WITH MASKING POLICY #unknown_policy COMMENT 'Nummer des Kassierers',
	CANCEL_FG NUMBER(38,0) NOT NULL COMMENT 'Das Flag kennzeichnet einen Abbruchvorgang',
	TRANSACTION_NAME VARCHAR(120) COMMENT 'Textfeld fuer die Transaktion, wie Kassen-An-, Abmeldung',
	BON_NR NUMBER(38,0) NOT NULL COMMENT 'Die Bonnummer des Bons (ist eine fortlaufende Nummer die in der Kasse generiert wird, im normal Fall ist diese Nummer pro tag und Kasse Unique)',
	BON_ENDE TIMESTAMP_NTZ(9) COMMENT 'Ende-Zeitpunkt des Bons',
	BON_BOOKING TIMESTAMP_NTZ(9) COMMENT 'Buchungszeitpunkt des Bons, relevant z.Bsp. fuer artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine Kasse offline war. Kann NULL sein',
	SUSPENDED_FG NUMBER(38,0) NOT NULL COMMENT 'Flag kennzeichnet einen Suspended-Status der Transaktion. 1 = suspended',
	TRAINING_FG NUMBER(38,0) NOT NULL COMMENT 'Das Flag kennzeichnet, ob die Transaktion im Trainings-Modus durchgefuehrt wurde.',
	KASSE_TYP_ID NUMBER(38,0) COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default(Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt',
	KPOS_KASSE_TYP VARCHAR(10) COMMENT 'Im Kassensystem KPOS verwendete nicht-numerische Kassentypen',
	KASSENSYSTEM_NAME VARCHAR(10) COMMENT 'Es wird nur drei hartkodierte Auspraegungen geben! KPOS, LUCAS, POSITION',
	KPOS_TRANSACTION_NAME VARCHAR(255) COMMENT 'Textfeld fuer die Transaktion speziell fuer Kassensystem KPOS, wie Kassen-An-, Abmeldung. Per CAMSET compressen',
	KPOS_TRANSACTION_STATUS NUMBER(38,0) COMMENT 'Status Kassensystem KPOS. 1 = true, 0 = false',
	DAT_BOOKING DATE COMMENT 'Buchungsdatum des Bons aus businessDayDate. Redundant zu bon_booking aus Performancegruenden',
	BON_NR_FISCAL NUMBER(38,0) COMMENT 'In Kombination mit Kasse und Markt einmalig kombiniertes Feld (Fiscal invoice receipt)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	BON_STATUS_CD VARCHAR(100) COMMENT 'Gibt den Status des Bons an. Quelle: Kassen XML ReceiptState',
	BON_ABBRUCH_GRUND_TXT VARCHAR(100) COMMENT 'Gibt den Grund für einen Bonabbruch an. Quelle: Kassen XML CancelReason',
	constraint PK_ODS_BON_TRANSACTION primary key (BON_ID, BON_DAT, WUP_ID, MANDANT_ID)
)COMMENT='ODS - Hier werden die An- und Abmeldungen an den Kassen hinterlegt'
;
