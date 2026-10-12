CREATE OR REPLACE TABLE kfl_production_dbp_data.besch_best_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
best_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege.'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
dat_best_beleg DATE NOT NULL OPTIONS(description='Dieses Feld enthält das Belegdatum der Bestellung.'),
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
loesch_fg INTEGER NOT NULL
OPTIONS(description='Das loesch_fg enthält das Löschkennzeichen für diese Position, Wert 1 entspricht gelöscht.'),
nachbest_fg INTEGER NOT NULL
OPTIONS(description='Dieses Kennzeichen steuert beim Anlegen einer Bestellung, ob sie als Nachbestel-lung behandelt wird. Ist das Kennzeichen gesetzt, können aus dieser Bestellung ausschließlich Lieferungen generiert werden, die mit geringerer Priorität kommissioniert werden.'),
einkaufsorganisation_id INTEGER NOT NULL OPTIONS(description='Einkaufsorganisation aus ekorg'),
kunde_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='Kannfeld: Eingabe des Marktes der eine_1 Veraenderung im Preis erhalten soll. Vom Normalpreis auf Sonderpreis oder umgekehrt.'),
dat_aenderung DATE
OPTIONS(description='Dieses Datum stellt das Übernahmedatum bei einem neuen Beleg bzw. das Updatedatum bei einer neuen Version eines Datensatzes dar.'),
wup_id INTEGER OPTIONS(description='Verteilzentrum für die Bestellung (auf Kopfebene)'),
nb_id INTEGER OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
best_beleg_status_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Status_1 der Bestellung, z. B. C entspricht Bestellung aus Wareneingang'),
system_id INTEGER DEFAULT 7 NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
empfaenger_wup_id INTEGER
OPTIONS(description='Bei dezentraler Bestellung ist dieser Wert mit dem Empfänger der Ware befüllt. Denormalisiert aus der Detailtabelle.'),
anz_pos_aktiv INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der nicht gelöschten Positionen aus der Detailtabelle. Denormalisiert'),
anz_pos_offen INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der noch nicht gelieferten Positionen aus der Detailtabelle. Nur nicht gelöschte. Denormalisiert'),
submi_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='Submissionsnummer aus submi. Nummer oder Bezeichnung, die der Verwaltung mehrerer Anfragen oder Bestellungen dient.'),
ref_beleg_id_intern STRING(20) COLLATE 'und:ci'
OPTIONS(description='Interne Referenznummer des Kunden oder Lieferanten aus ihrez'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, best_beleg_id) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Kopfdaten der Bestellungen aus der SAP Tabelle EKKO_1 enthalten.  - MULTISET');