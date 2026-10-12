CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BESCH_BEST (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
BEST_BELEG_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege.'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
DAT_BEST_BELEG DATE NOT NULL OPTIONS(description='Dieses Feld enthält das Belegdatum der Bestellung.'),
BESTELLART_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
LOESCH_FG INTEGER NOT NULL
OPTIONS(description='Das loesch_fg enthält das Löschkennzeichen für diese Position, Wert 1 entspricht gelöscht.'),
NACHBEST_FG INTEGER NOT NULL
OPTIONS(description='Dieses Kennzeichen steuert beim Anlegen einer Bestellung, ob sie als Nachbestel-lung behandelt wird. Ist das Kennzeichen gesetzt, können aus dieser Bestellung ausschließlich Lieferungen generiert werden, die mit geringerer Priorität kommissioniert werden.'),
EINKAUFSORGANISATION_ID INTEGER NOT NULL OPTIONS(description='Einkaufsorganisation aus ekorg'),
KUNDE_ID STRING(10) COLLATE 'und:ci'
OPTIONS(description='Kannfeld: Eingabe des Marktes der eine Veraenderung im Preis erhalten soll. Vom Normalpreis auf Sonderpreis oder umgekehrt.'),
DAT_AENDERUNG DATE
OPTIONS(description='Dieses Datum stellt das Übernahmedatum bei einem neuen Beleg bzw. das Updatedatum bei einer neuen Version eines Datensatzes dar.'),
WUP_ID INTEGER OPTIONS(description='Verteilzentrum für die Bestellung (auf Kopfebene)'),
NB_ID INTEGER OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
BEST_BELEG_STATUS_ID STRING(1) COLLATE 'und:ci'
OPTIONS(description='Status der Bestellung, z. B. C entspricht Bestellung aus Wareneingang'),
SYSTEM_ID INTEGER DEFAULT 7 NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
EMPFAENGER_WUP_ID INTEGER
OPTIONS(description='Bei dezentraler Bestellung ist dieser Wert mit dem Empfänger der Ware befüllt. Denormalisiert aus der Detailtabelle.'),
ANZ_POS_AKTIV INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der nicht gelöschten Positionen aus der Detailtabelle. Denormalisiert'),
ANZ_POS_OFFEN INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der noch nicht gelieferten Positionen aus der Detailtabelle. Nur nicht gelöschte. Denormalisiert'),
SUBMI_ID STRING(10) COLLATE 'und:ci'
OPTIONS(description='Submissionsnummer aus submi. Nummer oder Bezeichnung, die der Verwaltung mehrerer Anfragen oder Bestellungen dient.'),
REF_BELEG_ID_INTERN STRING(20) COLLATE 'und:ci'
OPTIONS(description='Interne Referenznummer des Kunden oder Lieferanten aus ihrez'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, BEST_BELEG_ID) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Kopfdaten der Bestellungen aus der SAP Tabelle EKKO enthalten.  - MULTISET');